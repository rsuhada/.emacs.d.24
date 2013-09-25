;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ctags / etags

(setq tags-revert-without-query t)

(setq path-to-pytags "/Users/rs/data1/sw/scripts/buildpytags") ;; wrapper that fixes problem w import
(defun create-pytags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s %s" path-to-pytags dir-name (directory-file-name dir-name)))
  )

;; auto refresh tags
(defadvice find-tag (around refresh-etags activate)
  "Rerun etags and reload tags if tag not found and redo find-tag.
   If buffer is modified, ask about save before running etags."
  (let ((extension (file-name-extension (buffer-file-name))))
    (condition-case err
        ad-do-it
      (error (and (buffer-modified-p)
                  (not (ding))
                  (y-or-n-p "Buffer is modified, save it? ")
                  (save-buffer))
             (er-refresh-etags extension)
             ad-do-it))))
(defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently."
  (interactive)
  (shell-command
   (format "%s" path-to-pytags))
  (let ((tags-revert-without-query t))  ; don't query, revert silently
    (visit-tags-table default-directory nil)))

;; auto jump
(global-set-key (kbd "C-x C-M-1") 'find-tag) ; bind to some unused placeholder
(global-set-key (kbd "C-x C-M-2") 'find-tag-other-window) ; bind to some unused placeholder
(global-set-key (kbd "M-.") (kbd "C-x C-M-1 <return>"))
(global-set-key (kbd "C-c M-.") (kbd "C-x C-M-2 <return>"))
