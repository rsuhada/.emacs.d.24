;; mac disable and use the command as the meta key
(setq mac-command-modifier 'meta) ;; Sets the command (Apple) key as Meta

;; killing buffers
(global-set-key (kbd "C-x C-k") 'kill-buffer) ; was kmacro-edit-macro

;; tweak for motion
(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning) ;; was move-beginning-of-line

;; Find matching parens
(global-set-key (kbd "C-'") 'goto-match-paren)

;; ibuffer > list-buffers
(global-set-key (kbd "C-x b") 'ibuffer)
;; (global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; save
(global-set-key (kbd "C-x s") 'use-emacs-keys)
(global-set-key (kbd "C-x C-s") 'use-emacs-keys)
(global-set-key (kbd "M-s") 'save-buffer) ;; was save-some-buffers

;; using the stock Emacs splitting (stay in same buffer)
(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-2") 'split-window-vertically) ; was digit-argument

(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-0") 'delete-window) ; was digit-argument
(global-set-key (kbd "M-o") 'other-window) ; was facemenu-keymap

(global-set-key (kbd "M-e") 'rs-macro/mark-line) ; forward-sentence

;; Replace dired's M-o
(add-hook 'dired-mode-hook (lambda () (define-key dired-mode-map (kbd "M-o") 'other-window))) ; was dired-omit-mode

;; Replace ibuffer's M-o
(add-hook 'ibuffer-mode-hook (lambda () (define-key ibuffer-mode-map (kbd "M-o") 'other-window))) ; was ibuffer-visit-buffer-1-window

;; To help Unlearn C-x 0, 1, 2, o
(global-unset-key (kbd "C-x 3")) ; was split-window-horizontally
(global-unset-key (kbd "C-x 2")) ; was split-window-vertically
(global-unset-key (kbd "C-x 1")) ; was delete-other-windows
(global-unset-key (kbd "C-x 0")) ; was delete-window
(global-unset-key (kbd "C-x o")) ; was other-window

;; setting mark should be less clumsy
(global-set-key (kbd "M-ESC") 'cua-set-mark)

(global-set-key (kbd "M-SPC") 'cua-set-mark) ; was just-one-space
;; (global-set-key (kbd "M-SPC") 'set-mark-command) ; was just-one-space
(global-set-key (kbd "C-c SPC") 'just-one-space) ; was just-one-space

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; abbrev temporary patch

(defun protect-underscore ()
  (interactive)
    (insert "_"))
(defun protect-dash ()
  (interactive)
    (insert "-"))
(defun protect-equal ()
  (interactive)
    (insert "="))

(add-hook 'abbrev-mode-hook
            (lambda ()
              (local-set-key (kbd "_") 'protect-underscore)
              (local-set-key (kbd "-") 'protect-dash)
              (local-set-key (kbd "=") 'protect-equal)
))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; better word-at-point search
;; http://sachachua.com/blog/2008/07/emacs-keyboard-shortcuts-for-navigating-code/

(defun sacha/isearch-yank-current-word ()
  "Pull current word from buffer into search string."
  (interactive)
  (save-excursion
    (skip-syntax-backward "w_")
    (isearch-yank-internal
     (lambda ()
       (skip-syntax-forward "w_")
       (point)))))
(define-key isearch-mode-map (kbd "C-x") 'sacha/isearch-yank-current-word)

(defun sacha/search-word-backward ()
  "Find the previous occurrence of the current word."
  (interactive)
  (let ((cur (point)))
    (skip-syntax-backward "w_")
    (goto-char
     (if (re-search-backward (concat "\\_<" (current-word) "\\_>") nil t)
	 (match-beginning 0)
       cur))))

(defun sacha/search-word-forward ()
  "Find the next occurrance of the current word."
  (interactive)
  (let ((cur (point)))
    (skip-syntax-forward "w_")
    (goto-char
     (if (re-search-forward (concat "\\_<" (current-word) "\\_>") nil t)
	 (match-beginning 0)
       cur))))
(global-set-key '[M-up] 'sacha/search-word-backward)
(global-set-key '[M-down] 'sacha/search-word-forward)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; exiting iserch

(defun isearch-exit-other-end (rbeg rend)
  "Exit isearch, but at the other end of the search string.
This is useful when followed by an immediate kill."
  (interactive "r")
  (isearch-exit)
  (goto-char isearch-other-end))

(defun isearch-exit-normal-end (rbeg rend)
  "Exit isearch, but at the other end of the search string.
This is useful when followed by an immediate kill."
  (interactive "r")
  (isearch-exit))

(define-key isearch-mode-map [(return)] 'isearch-exit-other-end)
(define-key isearch-mode-map [(control return)] 'isearch-exit-normal-end)

(defun underscore ()
  (interactive)
  (isearch-unread-key-sequence (list ?_)))

(define-key isearch-mode-map (kbd "M-u") 'underscore)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; defmacro cmd - some sort of simplified macro wrapping?

(defmacro cmd (name &rest body)
  "declare an interactive command without all the boilerplate"
  `(defun ,name ()
     ,(if (stringp (car body)) (car body))
     ;; tried (let (documented (stringp (first body))) but didn't know gensym
     ;; and couldn't get it to work. should be possible
     (interactive)
     ,@(if (stringp (car body)) (cdr `,body) body)))

;; search in other window
(cmd isearch-other-window
     ;; thank you leo2007!
     (save-selected-window
       (other-window 1)
       (isearch-forward)))

(global-set-key (kbd "C-c s") 'isearch-other-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; help me unlearn arrorw

(defun use-emacs-keys () (interactive)
"Remind me to use emacs move keys not arrows!!"
(message "Use emacs keys!!"))

(global-set-key '[up] 'use-emacs-keys)
(global-set-key '[down] 'use-emacs-keys)
(global-set-key '[left] 'use-emacs-keys)
(global-set-key '[right] 'use-emacs-keys)

(global-set-key (kbd "\C-x \C-h") 'mark-whole-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; search

(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-s") 'isearch-forward-regexp)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; Jump to a definition in the current file. (Protip: this is awesome.)
(global-set-key (kbd "C-x C-i") 'imenu)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; occur

(defun occur-clean-buffer ()
  "Removes all commentary from the *Occur* buffer, leaving the
 unadorned lines."
  (interactive)
  (if (get-buffer "*Occur*")
      (save-excursion
        (set-buffer (get-buffer "*Occur*"))
        (goto-char (point-min))
        (toggle-read-only 0)
        (if (looking-at "^[0-9]+ lines matching \"")
            (kill-line 1))
        (while (re-search-forward "^[ \t]*[0-9]+:"
                                  (point-max)
                                  t)
          (replace-match "")
          (forward-line 1)))
    (message "There is no buffer named \"*Occur*\".")))

(define-key occur-mode-map (kbd "C-c C-o") 'occur-clean-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; commenting a single line

;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
"Replacement for the comment-dwim command.  If no region is selected
and current line is not blank and we are not at the end of the
line, then comment current line.  Replaces default behaviour
of comment-dwim, when it inserts comment at the end of the
line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; comment paragraph
(defun comment-paragraph ()
  "Comment current region. Shortcut to C-; M-;"
  (interactive)
  (mark-paragraph)
  (comment-dwim-line)
  )

(global-set-key "\M-'" 'comment-paragraph)
(global-set-key "\M-]" 'rs-comment-line-separator-macro)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer flipping
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; duplicate & comment

(defun djcb-duplicate-line (&optional comment line)
"Duplicate the line containing the point.
\nIf COMMENT is non-nil, also comment out the original line.
If LINE is non-nil, duplicate that line instead."
(interactive "P")
(let ((col (current-column)))
(save-excursion
(when line
(goto-line line))
(let ((line (buffer-substring (point-at-bol) (point-at-eol))))
(when comment
(comment-region (point-at-bol) (point-at-eol)))
(goto-char (point-at-eol))
(if (eobp)
(newline)
(forward-line 1))
(open-line 1)
(insert line)))
(forward-line 1)
(move-to-column col)))

(global-set-key (kbd "M-[") (lambda()(interactive)(djcb-duplicate-line t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; select parantheis with C-M-u SPC

(defun backward-up-sexp (arg)
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))

(global-set-key [remap backward-up-list] 'backward-up-sexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; better basic movement - ErgoEmacs + my ideas

;; Single char cursor movement. (assuming you are on qwerty)
(global-set-key (kbd "M-j") 'backward-char) ;indent-new-comment-line
(global-set-key (kbd "M-l") 'forward-char)  ;downcase-word
(global-set-key (kbd "M-i") 'previous-line) ;tab-to-tab-stop
(global-set-key (kbd "M-k") 'next-line)     ;command kill-sentence
(global-set-key (kbd "M-h") 'backward-kill-word)  ; was mark-paragraph

;; kicking the habit
(global-unset-key (kbd "C-b")) ; backward-char
(global-unset-key (kbd "C-f")) ; forward-char
(global-unset-key (kbd "C-p")) ; previous-line
(global-unset-key (kbd "C-n")) ; next-line

;; per word movement
(global-set-key (kbd "C-M-l") 'forward-word)  ; reposition-window
(global-set-key (kbd "C-M-j") 'backward-word)   ; indent-new-comment-line

;; how to use the freed bindings:
(global-set-key (kbd "C-f") 'find-file) ; ido
(global-set-key (kbd "C-b") 'anything)
(global-set-key (kbd "C-n") 'ace-jump-char-mode)

;; set the -h instead of backspace
(global-set-key "\C-h" 'backward-delete-char-untabify)
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)

(global-set-key (kbd "M-H") 'backward-kill-sexp)  ; was mark-defun (only relevant for lisp)
(global-set-key (kbd "M-D") 'kill-sexp)  ; was mark-paragraph

;; more movement improvement
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-unset-key (kbd "M-u")) ; upcase-word
(global-set-key (kbd "C-c M-u") 'upcase-word)

(global-set-key (kbd "M-u") 'protect-underscore)

(defun jao-toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))

(global-set-key [f11] 'jao-toggle-selective-display)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; function keys

; leave f1 for emterm switch
(global-set-key (kbd "<M-S-f1>") 'bm-toggle)
(global-set-key (kbd "<M-f1>")   'bm-next)
(global-set-key (kbd "<S-f1>") 'bm-previous)

(global-set-key (kbd "M-m")   'er/expand-region)
(global-set-key (kbd "M-M")   'er/contract-region)
(global-set-key (kbd "C-M-m")   'rs-macro/mark-line)


(global-set-key [f2]    'replace-string)
(global-set-key [M-f2]  'replace-regexp)

(global-set-key [f5]    'rgrep)
(global-set-key [f6]    'occur)

(global-set-key [f7]   'next-error)
(global-set-key [M-f7] 'previous-error)

(global-set-key [f9]   'switch-to-previous-buffer)
(global-set-key [C-f9]   'next-user-buffer)
(global-set-key [C-M-f9]   'previous-user-buffer)

(global-set-key [f10]   'unexpand-abbrev)
(global-set-key [M-f11]   'eval-region)

(global-set-key [S-f12] 'help)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert word to minibuffer ala isearch
;; credit: scottfrazer

(defun my-minibuffer-insert-word-at-point ()
  "Get word at point in original buffer and insert it to minibuffer."
  (interactive)
  (let (word beg)
    (with-current-buffer (window-buffer (minibuffer-selected-window))
      (save-excursion
        (skip-syntax-backward "w_")
        (setq beg (point))
        (skip-syntax-forward "w_")
        (setq word (buffer-substring-no-properties beg (point)))))
    (when word
      (insert word))))

(defun my-minibuffer-setup-hook ()
  (local-set-key (kbd "C-w") 'my-minibuffer-insert-word-at-point))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; copy to end of line-spacing

(defun copy-end-line (&optional arg)
  "Copy to the kill ring from point to the end of the current line.
    With a prefix argument, copy that many lines from point. Negative
    arguments copy lines backward. With zero argument, copies the
    text before point to the beginning of the current line."
  (interactive "p")
  (save-excursion
    (copy-region-as-kill
     (point)
     (progn (if arg (forward-visible-line arg)
              (end-of-visible-line))
            (1-(point))))))

(global-set-key (kbd "C-c k") 'copy-end-line) ; C-u - C-c k copies backward

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; open lines
(defun open-line-below ()
  (interactive)
  (if (eolp)
      (newline)
    (end-of-line)
    (newline))
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<M-return>") 'open-line-below)
(global-set-key (kbd "<M-S-return>") 'open-line-above)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; replacement of mark paragraph - ignore empty line
(defun rs-mark-paragraph (&optional arg allow-extend)
"The original default mark-paragraph, but doesn't mark the first
empty line. Put point at beginning of this paragraph, mark at
end.  The paragraph marked is the one that contains point or
follows point.

With argument ARG, puts mark at end of a following paragraph, so that
the number of paragraphs marked equals ARG.

If ARG is negative, point is put at end of this paragraph, mark is put
at beginning of this or a previous paragraph.

Interactively, if this command is repeated
or (in Transient Mark mode) if the mark is active,
it marks the next ARG paragraphs after the ones already marked."
  (interactive "p\np")
  (unless arg (setq arg 1))
  (when (zerop arg)
    (error "Cannot mark zero paragraphs"))
  (cond ((and allow-extend
	      (or (and (eq last-command this-command) (mark t))
		  (and transient-mark-mode mark-active)))
	 (set-mark
	  (save-excursion
	    (goto-char (mark))
	    (forward-paragraph arg)
	    (point))))
	(t
	 (forward-paragraph arg)
	 (push-mark nil t t)
	 (backward-paragraph arg)
     (if (/= (line-number-at-pos) 1)
                        (next-line)))))

(global-set-key (kbd "C-;") 'rs-mark-paragraph)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bookmarks mouse stuff

(global-set-key (kbd "<left-fringe> <wheel-down>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <wheel-up>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; replace in rectangle (from phils at stackoverflow)
(require 'rect)

(defun my-search-replace-in-rectangle
  (start end search-pattern replacement search-function literal)
  "Replace all instances of SEARCH-PATTERN (as found by SEARCH-FUNCTION)
with REPLACEMENT, in each line of the rectangle established by the START
and END buffer positions.

SEARCH-FUNCTION should take the same BOUND and NOERROR arguments as
`search-forward' and `re-search-forward'.

The LITERAL argument is passed to `replace-match' during replacement.

If `case-replace' is nil, do not alter case of replacement text."
  (apply-on-rectangle
   (lambda (start-col end-col search-function search-pattern replacement)
     (move-to-column start-col)
     (let ((bound (min (+ (point) (- end-col start-col))
                       (line-end-position)))
           (fixedcase (not case-replace)))
       (while (funcall search-function search-pattern bound t)
         (replace-match replacement fixedcase literal))))
   start end search-function search-pattern replacement))

(defun my-replace-regexp-rectangle-read-args (regexp-flag)
  "Interactively read arguments for `my-replace-regexp-rectangle'
or `my-replace-string-rectangle' (depending upon REGEXP-FLAG)."
  (let ((args (query-replace-read-args
               (concat "Replace"
                       (if current-prefix-arg " word" "")
                       (if regexp-flag " regexp" " string"))
               regexp-flag)))
    (list (region-beginning) (region-end)
          (nth 0 args) (nth 1 args) (nth 2 args))))

(defun my-replace-regexp-rectangle
  (start end regexp to-string &optional delimited)
  "Perform a regexp search and replace on each line of a rectangle
established by START and END (interactively, the marked region),
similar to `replace-regexp'.

Optional arg DELIMITED (prefix arg if interactive), if non-nil, means
replace only matches surrounded by word boundaries.

If `case-replace' is nil, do not alter case of replacement text."
  (interactive (my-replace-regexp-rectangle-read-args t))
  (when delimited
    (setq regexp (concat "\\b" regexp "\\b")))
  (my-search-replace-in-rectangle
   start end regexp to-string 're-search-forward nil))

(defun my-replace-string-rectangle
  (start end from-string to-string &optional delimited)
  "Perform a string search and replace on each line of a rectangle
established by START and END (interactively, the marked region),
similar to `replace-string'.

Optional arg DELIMITED (prefix arg if interactive), if non-nil, means
replace only matches surrounded by word boundaries.

If `case-replace' is nil, do not alter case of replacement text."
  (interactive (my-replace-regexp-rectangle-read-args nil))
  (let ((search-function 'search-forward))
    (when delimited
      (setq search-function 're-search-forward
            from-string (concat "\\b" (regexp-quote from-string) "\\b")))
    (my-search-replace-in-rectangle
     start end from-string to-string search-function t)))

(global-set-key (kbd "C-x r <f2>") 'my-replace-string-rectangle)
(global-set-key (kbd "C-x r <M-f2>") 'my-replace-regexp-rectangle)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hyper-key

(setq ns-function-modifier 'hyper)

;; join line
(global-set-key (kbd "C-M-u")           ;was backward-sexp
            (lambda ()
                  (interactive)
                  (join-line -1)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-c bindings to Emacs native functions

(global-set-key (kbd "C-c C-s") 'python-send-string)      ; in org mode clases w schedule

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python binings

(defun rs/switch-to-python-shell ()
  "Show an existing buffer called \"*ansi-term*\" if one exists, otherwise
call function ansi-term interactively."
  (interactive)
  (let ((existing-buffer (get-buffer "*Python*")))
         (switch-to-buffer existing-buffer)))
(global-set-key [M-f12] 'rs/switch-to-python-shell)

;; hooks
(add-hook 'python-mode-hook
          #'(lambda ()
              (add-hook 'abbrev-expand-functions
                        'hash-comment-mode-abbrev-expand-function
                        nil t)))

(add-hook 'python-mode-hook
          (lambda () (define-key python-mode-map (kbd "C-m") 'newline-and-indent)))

(add-hook 'python-mode-hook
          (lambda () (define-key python-mode-map (kbd "C-<f7>") 'rs-macro/pycompile)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; unset keys needed for system

(global-unset-key (kbd "M-`")) ;; was tmm-menubar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; switch bindings for undo

(global-set-key (kbd "C-z") 'undo-tree-visualize) ; was: repeat
(global-set-key (kbd "M-z") 'zap-to-char)
