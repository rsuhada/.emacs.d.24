;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; settings for big packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "~/.emacs.d/settings-packages/helm.el")
(load "~/.emacs.d/settings-packages/smex.el")
(load "~/.emacs.d/settings-packages/auto-complete.el")
(load "~/.emacs.d/settings-packages/multiple-cursors.el")
(load "~/.emacs.d/settings-packages/bm.el")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; local settings for smaller packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet

(yas-global-mode 1)

;; yas-snippet-dirs
;; (yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow-delimiters - parenthesis color matching

(add-hook 'text-mode-hook '(lambda ()
                             (rainbow-delimiters-mode 1)))
(add-hook 'python-mode-hook '(lambda ()
                             (rainbow-delimiters-mode 1)))
(add-hook 'sh-mode-hook (lambda ()
                             (rainbow-delimiters-mode 1)))
(add-hook 'latex-mode-hook '(lambda ()
                             (rainbow-delimiters-mode 1)))
(add-hook 'emacs-lisp-mode-hook '(lambda ()
                             (rainbow-delimiters-mode 1)))
(add-hook 'ess-mode-hook '(lambda ()
                             (rainbow-delimiters-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-jump

;; just lowercase for jumps
(setq ace-jump-mode-move-keys (loop for i from ?a to ?z collect i))

;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-M-n") 'ace-jump-mode-pop-mark)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; browse-kill-ring

(browse-kill-ring-default-keybindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evaling math in buffers

(autoload 'macro-math-eval-and-round-region "macro-math" "macro-math" t)
(autoload 'macro-math-eval-region "macro-math" "macro-math" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree

(global-undo-tree-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown

(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; extend-region

; nothing atm