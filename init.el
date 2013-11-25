;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; init file
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq debug-on-error t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turn off mouse interface early in startup to avoid momentary
;; display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-message t)

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
(load "~/.emacs.d/settings/windows.el")

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
(load "~/.emacs.d/settings/elpa.el")
(load "~/.emacs.d/settings/el-get.el")

;; manually installed packages - should be refactored and managed via
;; el-get
(add-to-list 'load-path "~/.emacs.d/manual-packages/")

;; load the installed packages
;; auto installed packages are loaded at the very end so load their
;; configs ony afterward
(add-hook
 'after-init-hook (lambda () (load "~/.emacs.d/packages.el")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; color theme
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook
 'after-init-hook (lambda () (load "~/.emacs.d/settings/init-color-theme.el")
                    (load "~/.emacs.d/settings/colemak-bindings.el")
                    ))





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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(custom-safe-themes (quote ("62b86b142b243071b5adb4d48a0ab89aefd3cf79ee3adc0bb297ea873b36d23f" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ediff-diff-options "-w")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#073642" . 0) ("#546E00" . 20) ("#00736F" . 30) ("#00629D" . 50) ("#7B6000" . 60) ("#8B2C02" . 70) ("#93115C" . 85) ("#073642" . 100))))
 '(jabber-auto-reconnect nil)
 '(jabber-avatar-verbose nil)
 '(jabber-chat-buffer-format "*-jab-%n-*")
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode nil)
 '(jabber-roster-buffer "*-jab-*")
 '(jabber-roster-line-format " %c %-25n %u %-8s (%r)")
 '(jabber-show-offline-contacts t)
 '(jabber-vcard-avatars-retrieve nil)
 '(magit-diff-use-overlays nil)
 '(safe-local-variable-values (quote ((eval when (fboundp (quote rainbow-mode)) (rainbow-mode 1)))))
 '(syslog-debug-face (quote ((t :background unspecified :foreground "#2aa198" :weight bold))))
 '(syslog-error-face (quote ((t :background unspecified :foreground "#dc322f" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#859900"))))
 '(syslog-info-face (quote ((t :background unspecified :foreground "#268bd2" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#b58900"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#d33682"))))
 '(syslog-warn-face (quote ((t :background unspecified :foreground "#cb4b16" :weight bold))))
 '(weechat-color-list (quote (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :heigh 120 :width normal :foundry "apple" :family "Andale Mono")))))
(put 'downcase-region 'disabled nil)
