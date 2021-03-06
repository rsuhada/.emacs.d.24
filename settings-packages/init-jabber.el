;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; jabber
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; path to jabber secrets
(load "~/.emacs.d/secrets/jabber.el")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(jabber-auto-reconnect nil)
 '(jabber-avatar-verbose nil)
 '(jabber-vcard-avatars-retrieve nil)
 '(jabber-chat-buffer-format "*-jab-%n-*")
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode nil)
 '(jabber-roster-buffer "*-jab-*")
 '(jabber-roster-line-format " %c %-25n %u %-8s (%r)")
 '(jabber-show-offline-contacts t))


(defun adjust-jabber-mode-line ()
  (setq global-mode-string (delete '(t jabber-activity-mode-string) global-mode-string))
  (add-to-list 'global-mode-string jabber-activity-count-in-title-format))

(add-hook 'jabber-chat-mode-hook 'adjust-jabber-mode-line)
