;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my saved macros

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; table data macros - better rewrite them as functions!

(fset 'orgtaby
   [?\M-> ?\C-r ?# ?\C-m return return ?\C-d ?\C-d M-escape ?\M-n ?\C-c ?| ?\C-a ?\C-x ?\C-s])

(fset 'orguntaby
   [?\M-< ?\C-s ?| ?\C-m backspace backspace ?\C-d ?# ?\C-d ?\M-< ?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?s ?t ?r ?i ?n ?g return ?| return return ?\M-< ?\C-x ?\C-s?\M-l ? ?\C-s ? ?\C-d ?\M-<])

;; FIXME
(fset 'orguntaby-simple
   [?\M-< f2 ?| return ?  return ?\M-< ?# ?\C-d ?\M-w ?\C-d ?\C-d ?\M-s])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; utility macros

(fset 'untexify-table
   [?\M-< ?& ?\C-/ ?\C-x ?\C-s f2 ?& return ?  ?  ?  ?  return ?\M-< f2 ?\\ ?\\ return return ?\M-< f2 ?$ return return ?\M-< f2 ?^ ?\{ return ?  ?  ?  ?  return ?\M-< f2 ?_ ?\{ return ?  ?  ?  ?  return ?\M-< f2 ?\} return return ?\M-< f2 ?\\ ?p ?m return return ?\M-< ?\C-x ?\C-s])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; comment-line-separator

;; C-u 70 M-;		;; comment-dwim-line
;; LFD			;; newline-and-indent

(fset 'rs-comment-line-separator-macro
      ;; "\C-u70\273\C-j")   ;qwerty
   "\C-u70\357\C-j")                    ;colemak

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pdf export from org mode with line separator

(fset 'rs/org2pdf
   [?\C-x ?r ?  ?p ?\M-< ?\C-s ?* ?\C-s ?* ?\C-m M-f2 ?$ return ?\\ ?\\ ?\\ ?\\ return ?\M-x ?o ?r ?g ?- ?e ?x ?p ?o ?r ?t ?- ?a ?s ?- ?p ?d ?f ?- ?a ?n ?d ?- ?o ?p ?e ?n return ?\C-/ ?\C-x ?r ?j ?p ?\M-s])

(fset 'rs-macro/xproc0
   [?\M-d ?\C-d ?\C-d ?\C-d ?\C-d ?\C-d ?\C-\; f2 ?8 backspace ?& ?\' ?\C-d ?\C-q ?\C-d backspace ?\C-q ?\C-j ?C ?O ?N ?T ?I ?N ?U ?E ?  ?  ?\' ?\C-d return return ?\C-a ?\C-\; f2 ?  return ?\C-q ?\C-j return ?\C-w ?\M-i ?\C-w ?\M-i ?\C-w ?\M-s])

(fset 'rs-latex-comment
   [return return return return ?\M-i ?\M-i ?\C-u ?7 ?0 ?% ?\M-w return ?\M-\; ?\C-/ ?% ?  ?R ?S return ?% return ?\C-y ?\M-i ? ])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mark line (temporary solution)

(fset 'rs-macro/mark-line
   [?\C-a ?\C-a M-escape ?\C-e ?\C-e ?\C-e ?\C-e ?\C-e]) ;multiple end line for long line bug

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; macro for book list

(fset 'rs-macro/ebook
   [?\M-< ?\C-\; ?\C-d ?\C-d M-f2 ?: ?: ?. ?* return return ?\M-< ?\M-s ?\M-k ?\M-k ?\M-k])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; options on of

(fset 'rs-macro/opt-off
   [f2 ?= ?1 return ?= ?0 return ?\M-s])

(fset 'rs-macro/opt-on
   [f2 ?= ?0 return ?= ?1 return ?\M-s])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for talks

(fset 'rs-macro/new-item
   "\C-e\M-q\M-n\C-m-\C-o ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; remove occur markup

(fset 'rs/macro-unoccur
   [?\C-k ?\C-k M-f2 ?^ ?  ?+ ?\[ ?0 ?- ?9 ?\C-e ?+ ?: return return ?\M-<])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; remove tex markup
;; FIXME: work on this

(fset 'rs-macro/detexify
   [?\M-< f2 ?^ backspace ?& return ?  return ?\M-< f2 ?/ backspace ?\\ ?\\ return return ?\M-< f2 ?$ return return ?\M-< f2 ?\\ ?p ?m return ?  ?  ?  return ?\M-< f2 ?^ ?\{ ?\M-l backspace return ?  ?  return ?\M-< f2 ?\} return return ?\M-< f2 ?_ ?\{ ?\C-d return ?  return ?\M-<])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; transfor selected region to anki cloze form

(fset 'rs-macro/clozeify
   [?\{ ?\M-  ?\C-\' ?\{ ?\C-\' ?\M-l ?\M-l ?c ?: ?: ?\M-j ?\M-j ?\M-s])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; exchanges point ana mark and switches of selection
(fset 'rs-macro/jump-to-last-mark
   "\C-x\C-x\240")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; force compile python

(fset 'rs-macro/pycompile
   [?\M-o ?\M-> return return ?\M-o ?\C-c ?\C-c])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; macros for desktop recover

(fset 'rs-macro/recover1
   [?\C-s ?\" ?/ ?s ?s ?h ?2 return ?\M-m ?\C-d ?\C-d])

(fset 'rs-macro/recover2
   [?\C-s ?s ?s ?h ?2 ?: return ?\C-\; ?\C-d ?\C-d])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; convert a raw mysql dump to a tpc compatible table
;; USE: start at t 0:0

(fset 'rs-macro/sqldump_cleanup
   [?\M-  ?\C-s ?S ?P ?T ?\M-i ?\M-\; ?\C-d ?\C-e return ?# ?  ?c ?a ?n ?d ?\M-u ?n ?a ?m ?e ?  ?s ?p ?t ?\M-u ?r ?a ?  ?s ?p ?t ?\M-u ?d ?e ?c ?  ?s ?p ?t ?\M-u ?s ?n ?  ?o ?b ?s ?i ?d ?  ?s ?t ?a ?t ?u ?s ?  ?t ?i ?m ?e ?  ?d ?e ?t ?e ?c ?t ?o ?r ?  ?e ?x ?p ?o ?s ?u ?r ?e ?  ?p ?i ?  ?c ?h ?a ?n ?d ?r ?a ?\M-u ?n ?a ?m ?e ?  ?x ?m ?m ?\M-u ?s ?t ?a ?t ?u ?s ?  ?s ?m ?m ?\M-u backspace backspace backspace backspace ?x ?m ?m ?\M-u ?p ?i ?\M-s ?  ?x ?m ?m ?\M-u ?o ?b ?s ?i ?d ?\M-s ?  ?x ?m ?m ?\M-u ?n ?a ?m ?e ?\C-a ?\M-s ?\M-s])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; invert anki card
(fset 'invcard
     [?\C-s ?: ?: ?\C-m ?\M-  ?\C-k backspace backspace ?\C-a ?\C-y ?  ?: ?: ?  ?\C-a ?\C-s ?\C-d ?\C-e ?\C-m ?\; ?\; return ?\M-s])

;; remove useless lines from t moon reader+
(fset 'anki-remove-lines
   [?\C-s ?0 ?\C-q ?\C-j return ?\C-w ?\C-w ?\M-e ?\C-o ?\C-t ?\C-t])
