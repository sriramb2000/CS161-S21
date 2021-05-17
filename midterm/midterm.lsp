(defun SP-EXP (l) (
   cond
    ((null l) '(0 1))
    ((numberp l) (list l l))
    (t (let*
		(
			(head (SP-EXP (first l)))
			(tail (SP-EXP (cdr l)))
		)
		(
			list (+ (first head) (first tail)) (* (second head) (second tail))
		)
	))
))

(SP-EXP '(1 1 3))
(SP-EXP '(3 (1 4) (0)))
(SP-EXP '2)