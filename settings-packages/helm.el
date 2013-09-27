;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; helm settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; sources
(setq helm-sources
   '(
     helm-c-source-ffap-line
     helm-c-source-ffap-guesser
     helm-c-source-buffers
     helm-c-source-imenu
     helm-c-source-etags-select
     helm-c-source-bm
     helm-c-source-register
     helm-c-source-recentf
     helm-c-source-file-name-history
     helm-c-source-file-cache
     helm-c-source-files-in-current-dir+
     helm-c-source-locate
     )
)

;; keys
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "M-k") 'helm-next-line)
     (define-key helm-map (kbd "M-i") 'helm-previous-line)
     (define-key helm-map (kbd "M-l") 'helm-next-source)
     (define-key helm-map (kbd "M-j") 'helm-previous-source)))
