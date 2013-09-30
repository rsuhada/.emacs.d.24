;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; color-theme settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rs-zenburn
;; my "fork" of the official zenburn theme


(add-to-list 'custom-theme-load-path "~/.emacs.d/manual-packages/rs-zenburn")
(load-theme 'zenburn t)
;; (load "~/.emacs.d/settings/tweak-zenburn.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zenburn

;; (load-theme 'zenburn t)
;; (load "~/.emacs.d/settings/tweak-zenburn.el")
;; ;; (disable-theme 'zenburn)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solarized dark

;; (load-theme 'solarized-dark t)
;; (load "~/.emacs.d/settings/tweak-solarized-dark.el")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; further settings that have to come after the theme

(load "~/.emacs.d/settings/mode-line.el")
(load "~/.emacs.d/settings/appearance.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set the font

(custom-set-faces '(default ((t (:inherit nil :stipple
 nil :inverse-video nil :box nil :strike-through nil
 :overline nil :underline nil :slant normal :weight normal :height 130
 :width normal :foundry "apple" :family "Andale Mono")))))
