;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; key-chord settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(key-chord-mode 1)

(setq key-chord-two-keys-delay 0.07)    ;default=0.1
(setq key-chord-one-key-delay  0.2)    ;default=0.2

;; (key-chord-define-global "kl"     'forward-word)
;; (key-chord-define-global "jk"     'backward-word)

(key-chord-define-global "4r"     "$")
(key-chord-define-global "5t"     "%")
(key-chord-define-global "6t"     "^")
(key-chord-define-global "6y"     "^")
(key-chord-define-global "7y"     "&")
(key-chord-define-global "8i"     "*")
(key-chord-define-global "8u"     "*")
(key-chord-define-global "9i"     "(")
(key-chord-define-global "0o"     ")")
(key-chord-define-global "p-"     "_")
(key-chord-define-global "[;"     "{")
(key-chord-define-global "]'"     "}")

(key-chord-define-global "--"     "->")
(key-chord-define-global ",."     "<>")

(key-chord-define-global "kk" 'rs-macro/new-item)

;; (key-chord-define-global "qw" 'rs-macro/mark-line)
;; (key-chord-define-global "qw" '"_")

;; mode specific maps can't be in bindings because they require
;; preloaded libs

;; (add-hook 'python-mode-hook
;;           #'(lambda ()
;;               (key-chord-define python-mode-map "cc"  'python-send-buffer)))


;; (key-chord-define org-mode-map "cc"  'org-capture-finalize) ;; doesn't work



;; (key-chord-define-global "fj"     "_")
