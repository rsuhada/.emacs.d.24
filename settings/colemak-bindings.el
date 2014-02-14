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

(add-hook 'ido-setup-hook 'ido-my-keys)

;; org
(add-hook 'org-mode-hook
          (lambda ()
           ;; (local-set-key (kbd "M-e") 'rs-macro/mark-line)
           (local-set-key (kbd "M-e") 'next-line)
           (local-set-key (kbd "M-h") 'backward-kill-word) ;; was org-mark-element
          ))

;; old attempt
;; (global-set-key (kbd "C-t") 'find-file)
;; (global-set-key (kbd "C-f") 'transpose-chars)
;; (global-set-key (kbd "M-t") 'forward-paragraph)



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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fix bindings in org

(add-hook 'org-mode-hook
          (lambda ()
           (local-set-key '[M-up] 'sacha/search-word-backward)
           (local-set-key '[M-down] 'sacha/search-word-forward)
           (local-set-key (kbd "C-'") 'goto-match-paren)
           ;; (local-set-key (kbd "M-e") 'rs-macro/mark-line)
           (local-set-key (kbd "M-h") 'backward-kill-word) ;; was org-mark-element
           (local-set-key '[f7] 'org-store-link)
           (local-set-key '[M-f7] 'org-insert-link)
          ))




(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "M-n") 'backward-char) ;indent-new-comment-line
(define-key my-keys-minor-mode-map (kbd "M-i") 'forward-char)  ;downcase-word
(define-key my-keys-minor-mode-map (kbd "M-u") 'previous-line) ;tab-to-tab-stop
(define-key my-keys-minor-mode-map (kbd "M-e") 'next-line)     ;command kill-sentence

(define-key my-keys-minor-mode-map (kbd "C-t") 'delete-char)
(define-key my-keys-minor-mode-map (kbd "M-t") 'kill-word)
(define-key my-keys-minor-mode-map (kbd "C-f") 'find-file)
(define-key my-keys-minor-mode-map (kbd "C-d") 'transpose-chars)

(define-key my-keys-minor-mode-map (kbd "M-p") 'ace-jump-char-mode)
;; (define-key my-keys-minor-mode-map (kbd "M-f") 'backward-word)

(define-key my-keys-minor-mode-map (kbd "C-i") 'forward-word)
(define-key my-keys-minor-mode-map (kbd "C-n") 'backward-word)
(define-key my-keys-minor-mode-map (kbd "M-C-u") 'backward-paragraph)
(define-key my-keys-minor-mode-map (kbd "M-C-e") 'forward-paragraph)

(define-key my-keys-minor-mode-map (kbd "M-a") 'rs-macro/mark-line)     ;mark line


(define-key my-keys-minor-mode-map (kbd "M-;") 'other-window) ; was facemenu-keymap
(add-hook 'dired-mode-hook (lambda () (define-key my-keys-minor-mode-map dired-mode-map (kbd "M-;") 'other-window))) ; was dired-omit-mode
(add-hook 'ibuffer-mode-hook (lambda () (define-key my-keys-minor-mode-map ibuffer-mode-map (kbd "M-;") 'other-window))) ; was ibuffer-visit-buffer-1-window
(define-key my-keys-minor-mode-map (kbd "C-;") 'open-line) ; was facemenu-keymap

(define-key my-keys-minor-mode-map "\M-o" 'comment-dwim-line)
(define-key my-keys-minor-mode-map (kbd "C-o") 'rs-mark-paragraph)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

;; (defun my-minibuffer-setup-hook ()
;;   (my-keys-minor-mode 1))
;; (add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)
