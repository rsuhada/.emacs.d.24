;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; init file
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turn off mouse interface early in startup to avoid momentary
;; display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; font for mac
;; good fonts: Andale Mono, Inconsolata, Consolas
;; this also sets a rudimentary dark color theme

(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "#121212"
 :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil
 :overline nil :underline nil :slant normal :weight normal :height 130
 :width normal :foundry "apple" :family "Andale Mono"))))
 '(bm-fringe-persistent-face ((((class color) (background dark))
 (:background "#d0bf8f" :foreground "#d0bf8f"))))
 '(my-linum-hl ((t (:inherit background :linum "#259185"))))
 '(org-level-1 ((t (:foreground "#dfaf8f"))))
 '(which-func ((((class color) (min-colors 88) (background dark))
 (:foreground "#859900")))))
(put 'ido-exit-minibuffer 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; run server
;; (if (not (server-mode)) (server-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load in setups from files

;; fundametals
(load "~/.emacs.d/settings/bindings.el")
(load "~/.emacs.d/settings/global.el")
(load "~/.emacs.d/settings/utils.el")
(load "~/.emacs.d/settings/paths.el")
(load "~/.emacs.d/settings/tab.el")
(load "~/.emacs.d/settings/modes.el")
(load "~/.emacs.d/settings/abbrev.el")

;; appearance
(load "~/.emacs.d/settings/windows.el")
(load "~/.emacs.d/settings/mode-line.el")
(load "~/.emacs.d/settings/appearance.el")

;; built-in tools settings
(load "~/.emacs.d/settings/ibuffer.el")
(load "~/.emacs.d/settings/occur.el")
(load "~/.emacs.d/settings/macros.el")
(load "~/.emacs.d/settings/dired.el")
(load "~/.emacs.d/settings/tags.el")
(load "~/.emacs.d/settings/tramp.el")
(load "~/.emacs.d/settings/ido.el")
(load "~/.emacs.d/settings/org.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; packages management
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setup package managers
(load "~/.emacs.d/elpa.el")
(load "~/.emacs.d/el-get.el")

;; manually installed packages - should be refactored and managed via
;; el-get
(add-to-list 'load-path
              "~/.emacs.d/manual-packages/")

;; load the installed packages
;; auto installed packages are loaded at the very end so load their
;; configs ony afterward
(add-hook
 'after-init-hook (lambda () (load "~/.emacs.d/packages.el")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; working but not used

;; (load "~/.emacs.d/settings/irc.el")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load options from files

;; (load "~/.emacs.d/settings/defun")
;; (load "~/.emacs.d/settings/env")
;; (load "~/.emacs.d/settings/macros")
;; (load "~/.emacs.d/settings/ido")
;; (load "~/.emacs.d/settings/tab")
;; (load "~/.emacs.d/settings/rect")
;; (load "~/.emacs.d/settings/org")
;; (load "~/.emacs.d/settings/ibuffer")
;; (load "~/.emacs.d/settings/abbrev.el")
;; (load "~/.emacs.d/settings/modes.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; has to come *after external*
 ;; (load "~/.emacs.d/settings/terminal")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; parts auto-written by custom set
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(ediff-diff-options "-w")
;;  '(jabber-auto-reconnect nil)
;;  '(jabber-avatar-verbose nil)
;;  '(jabber-chat-buffer-format "*-jab-%n-*")
;;  '(jabber-history-enabled t)
;;  '(jabber-mode-line-mode nil)
;;  '(jabber-roster-buffer "*-jab-*")
;;  '(jabber-roster-line-format " %c %-25n %u %-8s (%r)")
;;  '(jabber-show-offline-contacts t)
;;  '(jabber-vcard-avatars-retrieve nil)
;;  '(longlines-auto-wrap t)
;;  '(longlines-wrap-follows-window-size t)
;;  '(mediawiki-site-alist (quote (("spt-chan" "https://pole.uchicago.edu/spt-chandra/" "Rsuhada" "" "The XMM-Newton sample"))))
;;  '(minimap-window-location (quote left))
;;  '(org-link-frame-setup (quote ((vm . vm-visit-folder-other-frame) (gnus . org-gnus-no-new-news) (file . find-file) (wl . wl-other-frame))))
;;  '(pomodoro-break-cycle "b ")
;;  '(which-func-modes (quote (c-mode c++-mode perl-mode cperl-mode python-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode diff-mode org-mode)))
;;  '(which-function-mode t))

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#121212" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Envy Code R")))))
;; (put 'ido-exit-minibuffer 'disabled nil)

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#121212" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Deja Vu Sans Mono")))))
;; (put 'ido-exit-minibuffer 'disabled nil)

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#121212" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "apple" :family "Inconsolata")))))
;; (put 'ido-exit-minibuffer 'disabled nil)
