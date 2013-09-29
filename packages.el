;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; settings for big packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "~/.emacs.d/settings-packages/init-helm.el")
(load "~/.emacs.d/settings-packages/init-smex.el")
(load "~/.emacs.d/settings-packages/init-auto-complete.el")
(load "~/.emacs.d/settings-packages/init-multiple-cursors.el")
(load "~/.emacs.d/settings-packages/init-bm.el")
(load "~/.emacs.d/settings-packages/init-jabber.el")
(load "~/.emacs.d/settings-packages/init-key-chord.el")
(load "~/.emacs.d/settings-packages/init-backups-mode.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; local settings for smaller packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tellicopy

(load "tellicopy")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet


(setq yas-snippet-dirs
      '("~/.emacs.d/data/snippets"            ;; personal snippets
        ))
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
;; desktop autosaving and recovery

(add-to-list
'load-path "~/.emacs.d/manual-packages/desktop-recover/")

(require 'desktop-recover)
(setq desktop-recover-location
      (desktop-recover-fixdir "$HOME/"))

;; measured in autosave cycles - doesn't work?
(setq desktop-recover-save-period 1)

; if idle s save
(run-with-idle-timer 100.0 t 'desktop-save-in-desktop-dir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; counter
;; C-u C-c c for setup
;; C-u 100 C-c c to insert 100 numbers

(global-unset-key (kbd "C-c c")) ; conflicts with org template launcher
(autoload 'counter "counter" nil t)
(global-set-key "\C-cc" 'counter)

(add-hook 'counter-post-insert-hook '(lambda ()
                             (newline))) ; or: newline-and-indent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; constants

(autoload 'constants-insert "constants" "Insert constants into source." t)
(autoload 'constants-get "constants" "Get the value of a constant." t)
(autoload 'constants-replace "constants" "Replace name of a constant." t)
;; (define-key global-map "\C-cci" 'constants-insert)
;; (define-key global-map "\C-ccg" 'constants-get)
;; (define-key global-map "\C-ccr" 'constants-replace)
(setq constants-unit-system 'cgs)   ;  this is the default

;; Use "cc" as the standard variable name for speed of light,
;; "bk" for Boltzmann's constant, and "hp" for Planck's constant
(setq constants-rename '(("cc" . "c") ("bk" . "k") ("hp" . "h")))

;; A default list of constants to insert when none are specified
(setq constants-default-list "cc,bk,hp,Mpc,Msun")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; x-dict (formerly know as leo) - german dictionary

(require 'x-dict)
(add-to-list 'process-coding-system-alist '("x-dict" . latin-9))
(global-set-key (kbd "C-c C-g C-q") 'xdict-query)
(global-set-key (kbd "C-c C-g C-a") 'xdict-query-with-word-at-point)
