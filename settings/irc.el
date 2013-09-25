;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; irc

;; (erc :server "irc.freenode.net" :port 6667 :nick "rs")
(setq erc-autojoin-channels-alist
          '(("freenode.net" "#emacs" "#wiki")))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-input-line-position -2)

(provide 'erc-nick-colors)

(define-minor-mode ncm-mode "" nil
  (:eval
   (let ((ops 0)
         (voices 0)
         (members 0))
     (maphash (lambda (key value)
                (when (erc-channel-user-op-p key)
                  (setq ops (1+ ops)))
                (when (erc-channel-user-voice-p key)
                  (setq voices (1+ voices)))
                (setq members (1+ members)))
              erc-channel-users)
     (format " %S/%S/%S" ops voices members))))
