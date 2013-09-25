;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; modes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; new modes

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; settings for data files

(defun my-set-tab-mode ()
  (when (or (or (and (stringp buffer-file-name)
             (string-match "\\.cat\\'" buffer-file-name))
(and (stringp buffer-file-name)
             (string-match "\\.tab\\'" buffer-file-name)))
(and (stringp buffer-file-name)
             (string-match "\\.dat\\'" buffer-file-name)))
    (toggle-truncate-lines)
    (turn-on-orgtbl)))

(add-hook 'find-file-hook 'my-set-tab-mode)

