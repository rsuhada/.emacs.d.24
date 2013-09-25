;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ibuffer settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("tramp"   (or (filename . "ssh2:")
                              (name . "tramp")
                              ))
               ("data" (or
                           (name . ".dat$")
                           (name . ".cat$")
                           (name . ".tab$")
                           (name . ".csv$")
                           (name . ".table$")
                           ))
               ("pics" (or
                           (name . ".jpg$")
                           (name . ".jpeg$")
                           (name . ".gif$")
                           (name . ".png$")
                           ))
               ("kapi" (filename . "/kapi/"))
               ("esaspi" (filename . "/esaspi/"))
               ("sh" (mode . sh-mode))
               ("python" (or
                          (name . "^\\*Python\\*")
                          (mode . python-mode)))
               ("html" (mode . xhtml-mode))
               ("c" (mode . c-mode))
               ("r" (mode . ess-mode))
               ("fortran" (mode . fortran-mode))
               ("idl" (mode . idlwave-mode))
               ("tex" (or
                       (name . ".bib$")
                       (name . ".bbl$")
                       (mode . latex-mode)))
               ("org" (or
                           (name . "^\\*Calendar\\*$")
                           (name . "^diary$")
                           (mode . org-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (mode . Emacs-Lisp-Mode)))
               ("dired" (mode . dired-mode))
))))

(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-default-sorting-mode 'alphabetic)
(setq ibuffer-expert t)                 ; no promt on saved files

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
