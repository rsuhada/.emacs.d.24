;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; patch to colemak
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; |--------+---------|
;; | qwerty | colemak |
;; |--------+---------|
;; | top    |         |
;; |--------+---------|
;; | e      | f       |
;; | r      | p       |
;; | t      | g       |
;; | y      | j       |
;; | u      | l       |
;; | i      | u       |
;; | o      | y       |
;; | p      | ;       |
;; |--------+---------|
;; | top    |         |
;; |--------+---------|
;; | s      | r       |
;; | d      | s       |
;; | f      | t       |
;; | g      | d       |
;; | j      | n       |
;; | k      | e       |
;; | l      | i       |
;; | ;      | o       |
;; |--------+---------|
;; | bottom |         |
;; |--------+---------|
;; | n      | k       |
;; |--------+---------|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; movement

(global-set-key (kbd "M-n") 'backward-char) ;indent-new-comment-line
(global-set-key (kbd "M-i") 'forward-char)  ;downcase-word
(global-set-key (kbd "M-u") 'previous-line) ;tab-to-tab-stop
(global-set-key (kbd "M-e") 'next-line)     ;command kill-sentence

;; keys
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "M-e") 'helm-next-line)
     (define-key helm-map (kbd "M-u") 'helm-previous-line)
     (define-key helm-map (kbd "M-i") 'helm-next-source)
     (define-key helm-map (kbd "M-n") 'helm-previous-source)))

;; ido
(defun ido-my-keys ()
;;  "Add my keybindings for ido."
(define-key ido-completion-map (kbd "M-u") 'ido-prev-match)
(define-key ido-completion-map (kbd "M-e") 'ido-next-match)
)

(add-hook 'idoaatup-hook 'ido-my-keys)

;; org
(add-hook 'org-mode-hook
          (lambda ()
           ;; (local-set-key (kbd "M-e") 'rs-macro/mark-line)
           (local-set-key (kbd "M-e") 'next-line)
           (local-set-key (kbd "M-h") 'backward-kill-word) ;; was org-mark-element
          ))

;; switch for convenienkce

(global-set-key (kbd "C-t") 'delete-char)
(global-set-key (kbd "M-t") 'kill-word)
(global-set-key (kbd "C-f") 'find-file)
(global-set-key (kbd "M-f") 'backward-word)
(global-set-key (kbd "C-d") 'transpose-chars)
(global-set-key (kbd "M-d") 'backward-paragraph)
(global-set-key (kbd "M-b") 'forward-paragraph)
(global-set-key (kbd "M-p") 'forward-word)

;; old attempt
;; (global-set-key (kbd "C-t") 'find-file)
;; (global-set-key (kbd "C-f") 'transpose-chars)
;; (global-set-key (kbd "M-t") 'forward-paragraph)

(global-set-key (kbd "C-,") 'keyboard-quit)

(global-set-key (kbd "M-a") 'rs-macro/mark-line)     ;mark line

;; missing
;; M-t transpose-words

;; (global-set-key (kbd "M-u") 'previous-line) ;underscore

;; free
;; M-r (move-to-window-line-top-bottom &optional ARG)
;; f8


(global-set-key (kbd "M-;") 'other-window) ; was facemenu-keymap
(add-hook 'dired-mode-hook (lambda () (define-key dired-mode-map (kbd "M-;") 'other-window))) ; was dired-omit-mode
(add-hook 'ibuffer-mode-hook (lambda () (define-key ibuffer-mode-map (kbd "M-;") 'other-window))) ; was ibuffer-visit-buffer-1-window
(global-set-key (kbd "C-;") 'open-line) ; was facemenu-keymap

(global-set-key "\M-o" 'comment-dwim-line)
(global-set-key (kbd "C-o") 'rs-mark-paragraph)

;; (global-set-key "\M-o" 'comment-dwim-line)
;; rs-macro/mark-line


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ein bindings:

;; (define-key ein:notebook-mode-map "\M-i"
;;             'forward-char)

;; (define-key ein:notebook-mode-map "\M-n"
;;             'backward-char)

;; (define-key ein:notebook-mode-map "\C-\M-e"
;;             'ein:worksheet-goto-next-input)

;; (define-key ein:notebook-mode-map "\C-\M-u"
;;             'ein:worksheet-goto-prev-input)

;; (define-key ein:notebook-mode-map "\M-return"
;;             'ein:worksheet-execute-cell-and-goto-next)
