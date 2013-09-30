;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; helm settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;  add back ffap support

;; ;;;;;;;
;; ;; ffap support. copied verbatim from helm-files.el at
;; ;; https://github.com/emacs-helm/helm/blob/1fb1f6965ab36a9a13dc730bca1a8cfa1511f465/helm-files.el,
;; ;; before it was removed in
;; ;; https://github.com/emacs-helm/helm/commit/c4cad2a2c86c24acc89ce73424b474fc782b9b32
;; ;;;;;;;
;; (eval-when-compile (require 'ffap))
;; (defvar helm-c-source-ffap-guesser
;;   `((name . "File at point")
;;     (init . (lambda () (require 'ffap)))
;;     (candidates . (lambda ()
;;                     (helm-aif
;;                         (with-helm-current-buffer
;;                           (ffap-guesser))
;;                         (list it))))
;;     (keymap . ,helm-generic-files-map)
;;     (help-message . helm-generic-file-help-message)
;;     (mode-line . helm-generic-file-mode-line-string)
;;     (action . ,(cdr (helm-get-attribute-from-type 'action 'file)))))

;; ;;; ffap with line number
;; (defun helm-c-ffap-file-line-at-point ()
;;   "Get (FILENAME . LINENO) at point."
;;   (helm-aif (let (ffap-alist) (ffap-file-at-point))
;;       (save-excursion
;;         (forward-line 0)
;;         (when (and (search-forward it nil t)
;;                    (looking-at ":\\([0-9]+\\)"))
;;           (cons it (string-to-number (match-string 1)))))))

;; (defun helm-c-ffap-line-candidates ()
;;   (with-helm-current-buffer
;;     (helm-attrset 'ffap-line-location
;;                   (helm-c-ffap-file-line-at-point)))
;;   (helm-aif (helm-attr 'ffap-line-location)
;;       (loop for (file . line) in (list it) collect
;;             (cons (format "%s (line %d)" file line) file))))

;; ;;; Goto line after opening file by `helm-c-source-ffap-line'.
;; (defun helm-c-ffap-line-goto-line ()
;;   (helm-aif (helm-attr 'ffap-line-location)
;;     (unwind-protect
;;          (ignore-errors
;;            (with-selected-window
;;                (get-buffer-window
;;                 (get-file-buffer (car it)))
;;              (helm-goto-line (cdr it))))
;;       (helm-attrset 'ffap-line-location nil))))
;; (add-hook 'helm-after-action-hook 'helm-c-ffap-line-goto-line)
;; (add-hook 'helm-after-persistent-action-hook 'helm-c-ffap-line-goto-line)

;; (defvar helm-c-source-ffap-line
;;   `((name . "File/Lineno at point")
;;     (init . (lambda () (require 'ffap)))
;;     (candidates . helm-c-ffap-line-candidates)
;;     (keymap . ,helm-map)
;;     (action . ,(cdr (helm-get-attribute-from-type 'action 'file)))))

(defun helm-hud ()
  "Helm HUD display."
  (interactive)
  (require 'helm-files)
  (require 'helm-imenu)
  (helm-other-buffer '(;; helm-c-source-ffap-line
                       ;; helm-c-source-ffap-guesser
                       helm-source-buffers-list
                       helm-source-recentf
                       helm-source-file-name-history
                       helm-source-file-cache
                       ;; helm-imenu-candidates
                       ;; helm-etags-select
                       ;; helm-source-bm
                       helm-source-files-in-current-dir
                       helm-source-locate)
                       "*helm hud*"))

;; keys
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "M-k") 'helm-next-line)
     (define-key helm-map (kbd "M-i") 'helm-previous-line)
     (define-key helm-map (kbd "M-l") 'helm-next-source)
     (define-key helm-map (kbd "M-j") 'helm-previous-source)))
