;;;;;;;;;;;;;;
; Homework 4 ;
;;;;;;;;;;;;;;

;; Checks if a mapping satisfies a set of expressions, delta
(defun satisfied? (delta mapping) (
  if (equal nil delta)
    t
    (and (expr-satisfied? (first delta) mapping) (satisfied? (cdr delta) mapping))
))

;; Checks is a mapping satisfies an expression
(defun expr-satisfied? (expr mapping) (
  if (equal nil expr)
    nil
    (or (member? (first expr) mapping) (expr-satisfied? (cdr expr) mapping))
))

;; Determines if val is in list
(defun member? (val list) (
  if (equal nil list)
    nil
    (or (= val (first list)) (member? val (cdr list)))
))

;; Tries to detect any dead expressions, assuming the first n 
;; variables have been assigned
(defun is-dead? (n delta mapping) (
  if (equal nil delta)
    nil
    (or (is-expr-dead? n (first delta) mapping) (is-dead? n (cdr delta) mapping))
))

;; Determines if an expression can be declared dead for a given mapping
(defun is-expr-dead? (n expr mapping) (
  if (eval-with-n? n expr) 
    (not (expr-satisfied? expr mapping))
    nil ;; Can't evaluate, cannot say it is dead
))

;; Is every member of delta less than or equal to n
(defun eval-with-n? (n delta) (
  if (equal nil delta)
    t
    (and (< (abs (first delta)) (+ n 1)) (eval-with-n? n (cdr delta)))
))


; EXERCISE: Modify this function to decide satisifiability of delta.
; If delta is satisfiable, sat? returns a list of n integers that represents a model of delta,  
; otherwise it returns NIL. (See spec for details.)
; param n: number of variables in delta
; param delta: a CNF represented as a list of lists
;; (defun sat? (n delta)
;;   (find-mapping n delta (nlist n 1))
;; )

(defun sat? (n delta)
  (find-mapping n 1 delta nil)
)

;; Performs a DFS to find a mapping of n variables to satisfy the set of expressions
;; delta, backtracking whenever it determines a mapping is dead or cannot satisfy 
;; delta
(defun find-mapping (n cur delta mapping) (
  if (< n cur)
    (if (satisfied? delta mapping)
      mapping
      nil    
    )
    (let*
      (
        (next (+ cur 1))
        (tMapping (cons cur mapping))
        (fMapping (cons (* -1 cur) mapping))
        (tDead (is-dead? cur delta tMapping))
        (fDead (is-dead? cur delta fMapping))
        (tMap (if tDead nil (find-mapping n next delta tMapping)))
        (fMap (if fDead nil (find-mapping n next delta fMapping)))
      )
      (
        if tDead
          fMap
          (if (not (null tMap)) 
            tMap
            fMap
          )
      )
    )
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions that help you parse CNF from files in folder cnfs/
; You need not modify any functions in this section
; Usage (solve-cnf <path-to-file>)
; e.g., (solve-cnf "./cnfs/f1/sat_f1.cnf")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun split-line (line)
  (if (equal line :eof)
      :eof
      (with-input-from-string (s line) (loop for x = (read s nil) while x collect x))))

(defun read-cnf (filename)
  (with-open-file (in filename)
    (loop for line = (split-line (read-line in nil :eof)) until (equal line :eof)
      if (equal 'p (first line)) collect (third line)      ; var count
      if (integerp (first line)) collect (butlast line)))) ; clause

(defun parse-cnf (filename)
  (let ((cnf (read-cnf filename))) (list (car cnf) (cdr cnf))))

; Following is a helper function that combines parse-cnf and sat?
(defun solve-cnf (filename)
  (let ((cnf (parse-cnf filename))) (sat? (first cnf) (second cnf))))

