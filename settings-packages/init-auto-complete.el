;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; autocomplete
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; launch
(require 'auto-complete-config)
(global-auto-complete-mode)

(setq ac-comphist-file "~/.emacs.d/data/ac-comphist.dat")

(ac-flyspell-workaround)                ; has to be in this line otherwise does not work
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete-1.3.1/ac-dict")
;; (ac-config-default)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'sh-mode)
(add-to-list 'ac-modes 'ess-mode)
;;
;; auto start after this many characters
;; (setq ac-auto-start 2)
(setq ac-auto-show-menu 0.2)            ;set time in seconds
;;
;; stop on save, C-g and:
(define-key ac-completing-map "\ESC/" 'ac-stop)
;;
;; adaptive case sensitivity - rather not
(setq ac-ignore-case nil)
;;
;; consider also frequency
(setq ac-use-comphist t)
;;
(setq-default ac-sources '(
ac-source-yasnippet
ac-source-filename
;; ac-source-imenu
ac-source-words-in-buffer
ac-source-words-in-same-mode-buffers
ac-source-dictionary
ac-source-abbrev
))
;;
(defun my-ac-emacs-lisp-mode ()
  (setq ac-sources '(
ac-source-yasnippet
ac-source-features                      ;elisp
ac-source-functions                     ;elisp
ac-source-variables                     ;elisp
ac-source-symbols                       ;elisp
ac-source-filename
ac-source-imenu
ac-source-words-in-buffer
ac-source-words-in-same-mode-buffers
ac-source-dictionary
ac-source-abbrev
)))
;;
(add-hook 'emacs-lisp-mode-hook 'my-ac-emacs-lisp-mode)
(setq ac-dwim nil)
;;
(define-key ac-completing-map "\C-m" nil)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-m" 'ac-complete)

;; org-mode fix
;; the reason was that org-mode distinguieshes between TAB, tab C-i
(define-key ac-complete-mode-map [tab] 'ac-expand)
