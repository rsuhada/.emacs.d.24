;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; backups-mode
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/manual-packages/backups-mode/")
(require 'backups-mode)

(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(defvar backup-directory "~/.emacs-backups/")
(defvar tramp-backup-directory "~/.emacs-backups/tramp-backups/")

(backups-mode-start)

(setq auto-save-interval 100)
(setq auto-save-timeout 15)
(setq make-backup-files         t ;backup my files
      backup-by-copying         t ;don't clobber symlinks
      delete-old-versions       t
      kept-new-versions         10
      kept-old-versions         5
      version-control           t ;use versioned backups
      vc-make-backup-files      t ;make backups for cvs projects
      vc-follow-symlinks        t)
