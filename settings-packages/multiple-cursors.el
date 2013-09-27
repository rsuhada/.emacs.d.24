;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; multiple-cursors settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(global-set-key (kbd "C-S-o C-S-o") 'mc/edit-lines)
(global-set-key (kbd "C-S-o C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-o C-a") 'mc/edit-beginnings-of-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c >") 'mc/mark-all-like-this)

;; Rectangular region mode
(global-set-key (kbd "S-SPC") 'set-rectangular-region-anchor)

;; switch newline and exit
(eval-after-load "multiple-cursors-core"
  '(progn
     (define-key mc/keymap (kbd "<return>") nil)
     (define-key mc/keymap (kbd "C-j") 'multiple-cursors-mode)))
