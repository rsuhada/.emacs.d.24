;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; package management
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setting up package archives
(require 'package)

(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; settings for big packages

(load "~/.emacs.d/settings-packages/helm.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; settings for packages
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
