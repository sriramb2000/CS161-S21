;;;;;;;;;;;;;;
; Homework 4 ;
;;;;;;;;;;;;;;


(defun satisfied? (delta mapping) (
  if (equal nil delta)
    t
    (and (expr-satisfied? (first delta) mapping) (satisfied? (cdr delta) mapping))
))

(defun expr-satisfied? (expr mapping) (
  if (equal nil expr)
    nil
    (or (not (equal nil (find (first expr) mapping))) (expr-satisfied? (cdr expr) mapping))
))


; EXERCISE: Modify this function to decide satisifiability of delta.
; If delta is satisfiable, sat? returns a list of n integers that represents a model of delta,  
; otherwise it returns NIL. (See spec for details.)
; param n: number of variables in delta
; param delta: a CNF represented as a list of lists
(defun sat? (n delta)
  (find-mapping n delta (nlist n 1))
)

(defun nlist (n cur) (
  if (= n (- cur 1))
    nil
    (cons cur (nlist n (+ cur 1)))
))

(defun flip-nth (n mapping) (
  let*
  (
    (nTail (nthcdr n mapping))
    (nthEl (first nTail))
    (tail (cdr nTail))
  )
  (
    append (subseq mapping 0 n) (cons (* -1 nthEl) tail)
  )
))

;; find-mapping
(defun find-mapping (n delta mapping) (
  if (= n 0)
    nil
    (let*
      (
        (nthCheck (traverse-mapping n delta mapping))
      )
      (
         if (equal nil nthCheck)
          (traverse-mapping n delta (flip-nth (- n 1) mapping))
          nthCheck
      )      
    )
))

;; traverse-mapping
(defun traverse-mapping (n delta mapping) (
  if (satisfied? delta mapping)
    mapping
    (find-mapping (- n 1) delta mapping)
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

