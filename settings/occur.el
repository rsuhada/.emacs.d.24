;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; advice the search functions

(defadvice compilation-start (after compilation-start-maximize activate)
  (when (equal mode 'grep-mode)
    (switch-to-buffer "*grep*")
    ;; you may want to maximize the buffer
    (delete-other-windows)))

(defadvice occur-1 (before occur-maximize activate)
  (window-configuration-to-register ?>)) ; use some uncommon reg name

(defadvice occur-1 (after occur-maximize activate)
  (other-window 1)
  (next-line 1))

(defun occur-mode-quit ()
  "Quit and close occur window. I want to press 'q' and leave things as they were before in regard of the split of windows in the frame.
This is the equivalent of pressing C-x 0 and reset windows in the frame, in whatever way they were,
plus jumping to the latest position of the cursor which might have been changed by using the links out
of any of the matches found in occur."
  (interactive)
  (switch-to-buffer "*Occur*")
  ;; in order to know where we put the cursor thay might have jumped from qoccur
  (other-window 1)                  ;; go to the main window
  (point-to-register ?<)            ;; store the latest cursor position
  (switch-to-buffer "*Occur*")      ;; go back to the occur window
  ;; (kill-buffer "*Occur*")           ;; FIXME: test if should or not
  (jump-to-register ?>)             ;; reset the original frame state
  (register-to-point ?<))           ;; re-position cursor

(defun occur-browse-next ()
  (interactive)
  (next-line 1)
  (occur-mode-display-occurrence))

(defun occur-browse-previous ()
  (interactive)
  (previous-line 1)
  (occur-mode-display-occurrence))

;; some key bindings defined below. Use "p" ans "n" as in dired mode (without Cntrl key) for previous and next line; just show occurrence without leaving the "occur" buffer; use RET to display the line of the given occurrence, instead of jumping to i,t which you do clicking instead;  also quit mode with Ctrl-g.
(define-key occur-mode-map (kbd "q") 'occur-mode-quit)
(define-key occur-mode-map (kbd "C-q") 'occur-mode-quit)
(define-key occur-mode-map (kbd "C-g") 'occur-mode-quit)
(define-key occur-mode-map (kbd "C-RET") 'occur-mode-goto-occurrence-other-window)
(define-key occur-mode-map (kbd "C-<up>") 'occur-mode-goto-occurrence-other-window)
(define-key occur-mode-map (kbd "RET") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "p") 'previous-line)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "M-n") 'occur-browse-next)
(define-key occur-mode-map (kbd "M-p") 'occur-browse-previous)