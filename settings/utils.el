;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; small utility scripts
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; send buffer path to clipboard

(defun filename-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name: %s" filename))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; google stuff - there ius also a module but this is
;; faster/slimmer

(defun google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
       (read-string "Google: "))))))
(global-set-key (kbd "C-c g") 'google)

(require 'webjump)
(global-set-key (kbd "C-c j") 'webjump)

(setq webjump-sites
      '(
  ("Wikipedia" .
     [simple-query "en.wikipedia.org" "en.wikipedia.org/w/index.php?title=Special:&search=" ""])
  ("de Wikipedia" .
     [simple-query "de.wikipedia.org" "de.wikipedia.org/w/index.php?title=Special:&search=" ""])
  ("stackoverflow" .
     [simple-query "stackoverflow.com" "stackoverflow.com/search?q=" ""])
  ("Emacs Wiki" .
     [simple-query "www.emacswiki.org"
		   "www.emacswiki.org/cgi-bin/wiki/" ""])
  ("Google" .
     [simple-query "www.google.com"
		   "www.google.com/search?q=" ""])
  ("gm google maps" . [simple-query "maps.google.com" "https://maps.google.com/maps?q=" ""])
  ("gi Google Image Search" .
   [simple-query "images.google.com" "images.google.com/images?hl=en&q=" ""])
  ("Reddit Search" .
   [simple-query "www.reddit.com" "http://www.reddit.com/search?q=" ""])
  ("Flickr Search" .
   [simple-query "www.flickr.com" "flickr.com/search/?q=" ""]))
      webjump-sample-sites)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sum-column

(defun sum-column()
  "Sums a column of numbers starting at point. Needs at least one
   empty line at the end of the column to insert result"
  (interactive)
  (save-excursion
    (if (and (not (= (current-column) 0))
	     (re-search-backward "[ \t]" 0 t ))
	(forward-char))
    (let ((retn 0)
	  (old-column (current-column))
	  (old-next-line-add-newlines))
      (setq next-line-add-newlines nil)
      (while (not
	      (looking-at "^[ \t]*$"))
	(move-to-column old-column t)
	(if (and (looking-at "-?[0123456789]+")
		 (eq (current-column) old-column))
		(setq retn (+ retn (string-to-number (current-word)))))
	(next-line)
	(beginning-of-line))
      (next-line)
      (next-line)
      (move-end-of-line 0)
      (insert (make-string (- old-column (current-column)) 32))
      (insert (number-to-string retn))
      (setq next-line-add-newlines old-next-line-add-newlines)
      retn)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; text mode fill paragrph

(defun maybe-fill-paragraph (&optional justify region)
  "Fill paragraph at or after point (see `fill-paragraph').

Does nothing if `visual-line-mode' is on."
  (interactive (progn
    	 (barf-if-buffer-read-only)
    	 (list (if current-prefix-arg 'full) t)))
  (or visual-line-mode
      (fill-paragraph justify region)))

;; Replace M-q with new binding:

(add-hook 'text-mode-hook
  (defun cjm-fix-text-mode ()
    (define-key text-mode-map "\M-q" 'maybe-fill-paragraph)
    (remove-hook 'text-mode-hook 'cjm-fix-text-mode)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; incrementing and renumbering

;; renumber region
(defun renumber (start end &optional num)
  "Renumber the list items in the current START..END region.
    If optional prefix arg NUM is given, start numbering from that number
    instead of 1."
  (interactive "*r\np")
  (save-excursion
    (goto-char start)
    (setq num (or num 1))
    (save-match-data
      (while (re-search-forward "[0-9]+]" end t)
        (replace-match (number-to-string num))
        (setq num (1+ num))))))

(defun renumber-array-index (start end &optional num)
  "renumber for array indexe [i]"
  (interactive "*r\np")
  (save-excursion
    (goto-char start)
    (setq num (or num 1))
    (save-match-data
      (while (re-search-forward "[[0-9]+]" end t)
        (replace-match (format "%s%s%s" "[" (number-to-string num) "]"))
        (setq num (1+ num))))))


;;  these funcntions are useful in macros
(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; moving text

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(defun move-line-region-up (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-up start end n) (move-line-up n)))

(defun move-line-region-down (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-down start end n) (move-line-down n)))

(global-set-key [M-S-up] 'move-line-region-up)
(global-set-key [M-S-down] 'move-line-region-down)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; redefine zap-to-char to zap-up-to-char

(defadvice zap-to-char (after my-zap-to-char-advice (arg char) activate)
  "Kill up to the ARG'th occurence of CHAR, and leave CHAR. If
  you are deleting forward, the CHAR is replaced and the point is
  put before CHAR"
  (insert char)
  (if (< 0 arg) (forward-char -1)))

;; inserts an additional character
(defun zap-copy-up-to-char (arg char)
  "Zap to a character, but save instead of kill."
  (interactive "p\ncZap to char: ")
  (save-excursion
    (zap-to-char arg char)
    (yank)
    (delete-char 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; go to matching parenthesis
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        ;; ((  (and ())         (re-search-forward "[\[\(\{]")    ))
        (t nil)))

(global-set-key (kbd "C-'") 'goto-match-paren)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Move buffer aa file
;;
(defun move-buffer-file (dir)
 "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
 (let* ((name (buffer-name))
	 (filename (buffer-file-name))
	 (dir
	 (if (string-match dir "\\(?:/\\|\\\\)$")
	 (substring dir 0 -1) dir))
	 (newname (concat dir "/" name)))

 (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
 (progn 	(copy-file filename newname 1) 	(delete-file filename) 	(set-visited-file-name newname)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rename buffer
;; from magnars sveen

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rotate-text
;; FIXME: move to own file

(defvar rotate-text-rotations
  '(("true" "false")
    ("True" "False")
    ("yes" "no")
    ("Yes" "No")
    ("0" "1")
    ("pn" "m1" "m2")
    ("PN" "M1" "M2")
    ("width" "height")
    ("left" "top" "right" "bottom")
    ("start" "end")
    ("red" "orange" "yellow" "green" "blue" "indigo" "violet")
    ("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday")
    ("zero" "one" "two"))
  "List of text rotation sets.")

(defun rotate-region (beg end)
  "Rotate all matches in `rotate-text-rotations' between point and mark."
  (interactive "r")
  (let ((regexp (rotate-convert-rotations-to-regexp
		 rotate-text-rotations))
	(end-mark (copy-marker end)))
    (save-excursion
      (goto-char beg)
      (while (re-search-forward regexp (marker-position end-mark) t)
	(let* ((found (match-string 0))
	       (replace (rotate-next found)))
	  (replace-match replace))))))

(defun rotate-string (string &optional rotations)
  "Rotate all matches in STRING using associations in ROTATIONS.
If ROTATIONS are not given it defaults to `rotate-text-rotations'."
  (let ((regexp (rotate-convert-rotations-to-regexp
		 (or rotations rotate-text-rotations)))
	(start 0))
    (while (string-match regexp string start)
      (let* ((found (match-string 0 string))
	     (replace (rotate-next
		       found
		       (or rotations rotate-text-rotations))))
	(setq start (+ (match-end 0)
		       (- (length replace) (length found))))
	(setq string (replace-match replace nil t string))))
    string))

(defun rotate-next (string &optional rotations)
  "Return the next element after STRING in ROTATIONS."
  (let ((rots (rotate-get-rotations-for
	       string
	       (or rotations rotate-text-rotations))))
    (if (> (length rots) 1)
	(error (format "Ambiguous rotation for %s" string))
      (if (< (length rots) 1)
	  ;; If we get this far, this should not occur:
	  (error (format "Unknown rotation for %s" string))
	(let ((occurs-in-rots (member string (car rots))))
	  (if (null occurs-in-rots)
	      ;; If we get this far, this should *never* occur:
	      (error (format "Unknown rotation for %s" string))
	  (if (null (cdr occurs-in-rots))
	      (caar rots)
	    (cadr occurs-in-rots))))))))

(defun rotate-get-rotations-for (string &optional rotations)
  "Return the string rotations for STRING in ROTATIONS."
  (remq nil (mapcar (lambda (rot) (if (member string rot) rot))
		    (or rotations rotate-text-rotations))))

(defun rotate-convert-rotations-to-regexp (rotations)
  (regexp-opt (rotate-flatten-list rotations)))

(defun rotate-flatten-list (list-of-lists)
  "Flatten LIST-OF-LISTS to a single list.
Example:
  (rotate-flatten-list '((a b c) (1 ((2 3)))))
    => (a b c 1 2 3)"
  (if (null list-of-lists)
      list-of-lists
    (if (listp list-of-lists)
	(append (rotate-flatten-list (car list-of-lists))
		(rotate-flatten-list (cdr list-of-lists)))
      (list list-of-lists))))

(defun rotate-word-at-point ()
  "Rotate word at point based on sets in `rotate-text-rotations'."
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'word))
        (opoint (point)))
    (when (consp bounds)
      (let ((beg (car bounds))
            (end (copy-marker (cdr bounds))))
        (rotate-region beg end)
        (goto-char (if (> opoint end) end opoint))))))

;; (global-set-key "\C-c/" 'rotate-word-at-point)
(global-set-key "\C-\M-]" 'rotate-word-at-point)
