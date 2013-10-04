;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; apperance settings - appart from theme, window and mode-line
;; settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cursor

(setq-default cursor-type 'bar)         ; defult: box
(setq default-frame-alist
  '((cursor-color . "brown3")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight current line
(global-hl-line-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color current line in the left border - from stackowerflow

;; FIXME: could be refactored wo hl-line for my purposes

;; If the foreground and background don't match nicely, you can assign a
;; foreground colour explicitly with M-x customize-face RET my-linum-hl
;; RET

(require 'hl-line)
(defface my-linum-hl
  ;; `((t :inherit linum :background ,(face-background 'hl-line nil t)))
  `((t :inherit linum :foreground "#1d1d1d" :background "#9FC59F"))
  "Face for the current line number."
  :group 'linum)

(defvar my-linum-format-string "%3d")

(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 1)

(setq linum-format 'my-linum-format)

(defun my-linum-format (line-number)
  (propertize (format my-linum-format-string line-number) 'face
              (if (eq line-number my-linum-current-line-number)
                  'my-linum-hl
                'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)

;; To customize the highlighted background color
(set-face-background 'hl-line "#242424")
(set-face-foreground 'highlight nil)
(set-face-foreground 'hl-line nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; higlhlight parens

(show-paren-mode t)
(setq show-paren-delay 0)           ; how long to wait?
(setq show-paren-style 'expression) ; alternatives are 'parenthesis' and 'mixed'

(custom-set-faces
 '(show-paren-match ((t (:background "#121212" :weight bold)))))


;; (set-face-background 'show-paren-match-face (face-background 'default))
;; (set-face-background 'show-paren-match-face (face-background "#def"))
;; (set-face-foreground 'show-paren-match-face "#def")
;; (set-face-attribute 'show-paren-match-face nil :weight 'extra-bold :slant italic)

;; (set-face-attribute 'show-paren-match-face t
;;         :weight 'bold :underline nil :overline nil :slant 'italic)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; if using visual-line-mode in fullscreen you can set a column width

(defvar visual-wrap-column nil)

(defun set-visual-wrap-column (new-wrap-column &optional buffer)
  "Force visual line wrap at NEW-WRAP-COLUMN in BUFFER (defaults
    to current buffer) by setting the right-hand margin on every
    window that displays BUFFER.  A value of NIL or 0 for
    NEW-WRAP-COLUMN disables this behavior."
  (interactive (list (read-number "New visual wrap column, 0 to disable: " (or visual-wrap-column fill-column 0))))
  (if (and (numberp new-wrap-column)
           (zerop new-wrap-column))
      (setq new-wrap-column nil))
  (with-current-buffer (or buffer (current-buffer))
    (visual-line-mode t)
    (set (make-local-variable 'visual-wrap-column) new-wrap-column)
    (add-hook 'window-configuration-change-hook 'update-visual-wrap-column nil t)
    (let ((windows (get-buffer-window-list)))
      (while windows
        (when (window-live-p (car windows))
          (with-selected-window (car windows)
            (update-visual-wrap-column)))
        (setq windows (cdr windows))))))

(defun update-visual-wrap-column ()
  (if (not visual-wrap-column)
      (set-window-margins nil nil)
    (let* ((current-margins (window-margins))
           (right-margin (or (cdr current-margins) 0))
           (current-width (window-width))
           (current-available (+ current-width right-margin)))
      (if (<= current-available visual-wrap-column)
          (set-window-margins nil (car current-margins))
        (set-window-margins nil (car current-margins)
                            (- current-available visual-wrap-column))))))
