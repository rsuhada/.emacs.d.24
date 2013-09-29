;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; color-theme settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-theme 'solarized-dark t)

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
