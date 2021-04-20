;
; CS161 Hw3: Sokoban
; 
; *********************
;    READ THIS FIRST
; ********************* 
;
; All functions that you need to modify are marked with 'EXERCISE' in their header comments.
; Do not modify a-star.lsp.
; This file also contains many helper functions. You may call any of them in your functions.
;
; *Warning*: The provided A* code only supports the maximum cost of 4999 for any node.
; That is f(n)=g(n)+h(n) < 5000. So, be careful when you write your heuristic functions.
; Do not make them return anything too large.
;
; For Allegro Common Lisp users: The free version of Allegro puts a limit on memory.
; So, it may crash on some hard sokoban problems and there is no easy fix (unless you buy 
; Allegro). 
; Of course, other versions of Lisp may also crash if the problem is too hard, but the amount
; of memory available will be relatively more relaxed.
; Improving the quality of the heuristic will mitigate this problem, as it will allow A* to
; solve hard problems with fewer node expansions.
; 
; In either case, this limitation should not significantly affect your grade.
; 
; Remember that most functions are not graded on efficiency (only correctness).
; Efficiency can only influence your heuristic performance in the competition (which will
; affect your score).
;  
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; General utility functions
; They are not necessary for this homework.
; Use/modify them for your own convenience.
;

;
; For reloading modified code.
; I found this easier than typing (load "filename") every time. 
;
(defun reload()
  (load "hw3.lsp")
  )

;
; For loading a-star.lsp.
;
(defun load-a-star()
  (load "a-star.lsp"))

;
; Reloads hw3.lsp and a-star.lsp
;
(defun reload-all()
  (reload)
  (load-a-star)
  )

;
; A shortcut function.
; goal-test and next-states stay the same throughout the assignment.
; So, you can just call (sokoban <init-state> #'<heuristic-name>).
; 
;
(defun sokoban (s h)
  (a* s #'goal-test #'next-states h)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; end general utility functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; We now begin actual Sokoban code
;

; Define some global variables
(setq blank 0)
(setq wall 1)
(setq box 2)
(setq keeper 3)
(setq star 4)
(setq boxstar 5)
(setq keeperstar 6)

; Some helper functions for checking the content of a square
(defun isBlank (v)
  (= v blank)
  )

(defun isWall (v)
  (= v wall)
  )

(defun isBox (v)
  (= v box)
  )

(defun isKeeper (v)
  (= v keeper)
  )

(defun isStar (v)
  (= v star)
  )

(defun isBoxStar (v)
  (= v boxstar)
  )

(defun isKeeperStar (v)
  (= v keeperstar)
  )

;
; Helper function of getKeeperPosition
;
(defun getKeeperColumn (r col)
  (cond ((null r) nil)
	(t (if (or (isKeeper (car r)) (isKeeperStar (car r)))
	       col
	     (getKeeperColumn (cdr r) (+ col 1))
	     );end if
	   );end t
	);end cond
  )

;
; getKeeperPosition (s firstRow)
; Returns a list indicating the position of the keeper (c r).
; 
; Assumes that the keeper is in row >= firstRow.
; The top row is the zeroth row.
; The first (right) column is the zeroth column.
;
(defun getKeeperPosition (s row)
  (cond ((null s) nil)
	(t (let ((x (getKeeperColumn (car s) 0)))
	     (if x
		 ;keeper is in this row
		 (list x row)
		 ;otherwise move on
		 (getKeeperPosition (cdr s) (+ row 1))
		 );end if
	       );end let
	 );end t
	);end cond
  );end defun

;
; cleanUpList (l)
; returns l with any NIL element removed.
; For example, if l is '(1 2 NIL 3 NIL), returns '(1 2 3).
;
(defun cleanUpList (L)
  (cond ((null L) nil)
	(t (let ((cur (car L))
		 (res (cleanUpList (cdr L)))
		 )
	     (if cur 
		 (cons cur res)
		  res
		 )
	     );end let
	   );end t
	);end cond
  );end 

; EXERCISE: Modify this function to return true (t)
; if and only if s is a goal state of the game.
; (neither any boxes nor the keeper is on a non-goal square)
;
; Currently, it always returns NIL. If A* is called with
; this function as the goal testing function, A* will never
; terminate until the whole search space is exhausted.
;
(defun goal-test (s) (
  if (equal s nil)
	T
  (
	  and (goal-test-row (car s)) (goal-test (cdr s))
  )
));end defun

(defun goal-test-row (r) (
	if (equal r nil)
		t
	(
		let 
		(
			(head (first r))
			(tail (cdr r))
		)
		(
			if (or (isBox head) (isKeeper head))
				nil
			(goal-test-row tail)
		);end let
	);end if
));end defun

; EXERCISE: Modify this function to return the list of 
; sucessor states of s.
;
; This is the top-level next-states (successor) function.
; Some skeleton code is provided below.
; You may delete them totally, depending on your approach.
; 
; If you want to use it, you will need to set 'result' to be 
; the set of states after moving the keeper in each of the 4 directions.
; A pseudo-code for this is:
; 
; ...
; (result (list (try-move s UP) (try-move s DOWN) (try-move s LEFT) (try-move s RIGHT)))
; ...
; 
; You will need to define the function try-move and decide how to represent UP,DOWN,LEFT,RIGHT.
; Any NIL result returned from try-move can be removed by cleanUpList.
; 
;
(defun next-states (s)
  (let* (
	 (tmp (getKeeperPosition s 0))
	 (pos (list (second tmp) (first tmp)))
	 ;x and y are now the coordinate of the keeper in s.
	 (result (list (try-move s pos '(0 -1)) (try-move s pos '(0 1)) (try-move s pos '(-1 0)) (try-move s pos '(1 0))))
	 )
    (cleanUpList result);end
   );end let
  );

; UP (0 -1), RIGHT (1 0), DOWN (0 1), LEFT (-1 0)
(defun try-move (s pos d)(
	let*
	(
		(curSquare (fetch-square s pos d 0))
		(fstSquare (fetch-square s pos d 1))
		(fstCoords (move-coords pos d 1))
		(sndSquare (fetch-square s pos d 2))
	)
	(
		if (or (= fstSquare blank) (= fstSquare star))
			(move-obj s pos d curSquare fstSquare #'keeper-move-fn)
		(
			if (can-push-box fstSquare sndSquare)
			(
				move-obj (move-obj s fstCoords d fstSquare sndSquare #'box-move-fn) pos d curSquare (transition-move-fn fstSquare) #'keeper-move-fn
			)
				nil
		)
	)
))

(defun can-push-box (adjSquare adjAdjSquare) (
	and (or (= adjSquare box) (= adjSquare boxstar)) (or (= adjAdjSquare blank) (= adjAdjSquare star))
))

;; Moves object at pos 1 step in direction d - the old square's value is determined by
;; transition-move-fn, and the new square's value is determined by the replace-fn
(defun move-obj (s pos d currentSquare targetSquare replace-fn) (
	let*
	(
		(transition-s (set-square s pos (transition-move-fn currentSquare)))
	)
	(
		set-square transition-s (move-coords pos d 1) (funcall replace-fn targetSquare)
	)
))

;; What type of square should we get if the KEEPER moves on top of
;; a square of type targetSquare
(defun keeper-move-fn (targetSquare) (
	cond
	(
		(= targetSquare blank)
			keeper
	)
	(
		(= targetSquare star)
			keeperstar
	)
))

(defun transition-move-fn (targetSquare) (
	cond
	(
		(or (= targetSquare keeperstar) (= targetSquare boxstar)) 
			star
	)
	(
		(or (= targetSquare keeper) (= targetSquare box)) 
			blank
	)
))

;; What type of square should we get if the KEEPER moves on top of
;; a square of type targetSquare
(defun box-move-fn (targetSquare) (
	cond
	(
		(= targetSquare blank)
			box
	)
	(
		(= targetSquare star)
			boxstar
	)
))

(defun getNth (n l) (
	if (< n 0)
		nil
	(
		car (nthcdr n l)
	)
))

(defun get-square (s row col)(
	let*
	(
		(val (getNth col (getNth row s)))
	)
	(
		if (equal nil val)
			wall
			val
	)
))

;; Set value of square at position targetPos to value targetVal
(defun set-square (s targetPos targetVal) (
	set-square-helper s (first targetPos) (second targetPos) targetVal
))

(defun set-square-helper (s row col targetVal) (
	if (equal s nil)
		nil
	(
		if (= row 0)
			(cons (set-square-col-helper (car s) col targetVal) (cdr s))
			(cons (car s) (set-square-helper (cdr s) (- row 1) col targetVal))
	)
))

(defun set-square-col-helper (r col targetVal) (
	if (equal r nil)
		nil
	(
		if (= col 0)
			(cons targetVal (cdr r))
			(cons (car r) (set-square-col-helper (cdr r) (- col 1) targetVal))
	)
))

;; Get value of square that is steps steps away from pos in direction d
(defun fetch-square (s pos d steps) (
	let*
	(
		(new-coords (move-coords pos d steps))
		(x2 (first new-coords))
		(y2 (second new-coords))
	)
	(
		get-square s x2 y2
	)
))

;; The coordinates that are steps steps away from pos in direction d
(defun move-coords (pos d steps) (
	let*
	(
		(x (first pos))
	    (y (second pos))	
		(dx (* (first d) steps))
		(dy (* (second d) steps))
		(x2 (+ x dx))
		(y2 (+ y dy))
	)
	(
		list x2 y2
	)
))

; EXERCISE: Modify this function to compute the trivial 
; admissible heuristic.
;
(defun h0 (s)
	0
)

; EXERCISE: Modify this function to compute the 
; number of misplaced boxes in s.
; Yes this is admissible
(defun h1 (s)
	(if (null s)
		0
		(+ (count box (car s)) (h1 (cdr s)))
	)
)

;; ; EXERCISE: Change the name of this function to h<UID> where
;; ; <UID> is your actual student ID number. Then, modify this 
;; ; function to compute an admissible heuristic value of s. 
;; ; 
;; ; This function will be entered in the competition.
;; ; Objective: make A* solve problems as fast as possible.
;; ; The Lisp 'time' function can be used to measure the 
;; ; running time of a function call.
;; ;
(defun h805167463 (s)
	(let* 
		((keeper-loc (getKeeperPosition s 0)))
		(if (corner-box s s 0)
			999
			(h1 s)
		)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Returns t if box in corner, nil otherwise
(defun corner-box (s original-s r)
	(if (null s)
		nil
		(or (corner-box-row (car s) original-s r 0) (corner-box (cdr s) original-s (+ r 1)))
	)
)

; helper function for corner-box
(defun corner-box-row (row original-s r c)
	(if (equal row nil)
		nil
		(if (isBox (first row))
			(let* 
				(
					(pos (list row col))
					(right-val (fetch-square original-s pos '(0 1) 1))
					(left-val (fetch-square original-s pos '(0 -1) 1))
					(up-val (fetch-square original-s pos '(-1 0) 1))
					(down-val (fetch-square original-s pos '(1 0) 1))
					(vert-check (or (isWall up-val) (isWall down-val)))
					(horiz-check (or (isWall right-val) (isWall left-val)))
				)
				(if (and vert-check horiz-check)
					t
					nil
				)
			)
			(corner-box-row (cdr row) original-s r (+ c 1))
		)
	)
)

#|
 | Some predefined problems.
 | Each problem can be visualized by calling (printstate <problem>). For example, (printstate p1).
 | Problems are ordered roughly by their difficulties.
 | For most problems, we also provide a number which indicates the depth of the optimal solution.
 | These numbers are located at the comments of the problems. For example, the first problem below has optimal solution depth 6.
 | As for the solution depth, any admissible heuristic must make A* return an optimal solution. So, the depths of the optimal solutions provided could be used for checking whether your heuristic is admissible.
 |
 | Warning: some problems toward the end are quite hard and could be impossible to solve without a good heuristic!
 | 
 |#
;(6)
(setq p1 '((1 1 1 1 1 1)
	   (1 0 3 0 0 1)
	   (1 0 2 0 0 1)
	   (1 1 0 1 1 1)
	   (1 0 0 0 0 1)
	   (1 0 4 0 4 1)
	   (1 1 1 1 1 1)))

;(15)
(setq p2 '((1 1 1 1 1 1 1)
	   (1 0 0 0 0 0 1) 
	   (1 0 0 0 0 0 1) 
	   (1 0 0 2 1 4 1) 
	   (1 3 4 0 1 0 1)
	   (1 1 1 1 1 1 1)))

;(13)
(setq p3 '((1 1 1 1 1 1 1 1 1)
	   (1 0 0 0 1 0 0 0 1)
	   (1 0 0 0 2 0 3 4 1)
	   (1 0 0 0 1 0 0 0 1)
	   (1 0 4 0 1 0 0 0 1)
	   (1 1 1 1 1 1 1 1 1)))

;(17)
(setq p4 '((1 1 1 1 1 1 1)
	   (0 0 0 0 0 1 4)
	   (0 0 0 0 0 0 0)
	   (0 0 1 1 1 0 0)
	   (0 0 1 0 0 0 0)
	   (0 2 1 0 0 4 0)
	   (0 3 1 0 0 0 0)))

;(12)
(setq p5 '((1 1 1 1 1 1)
	   (1 1 0 0 1 1)
	   (1 0 0 0 0 1)
	   (1 4 2 2 4 1)
	   (1 0 0 0 4 1)
	   (1 1 3 1 1 1)
	   (1 1 1 1 1 1)))

;(13)
(setq p6 '((1 1 1 1 1 1 1 1)
	   (1 0 0 0 0 0 4 1)
	   (1 4 0 0 2 2 3 1)
	   (1 0 0 1 0 0 4 1)
	   (1 1 1 1 1 1 1 1)))

;(47)
(setq p7 '((1 1 1 1 1 1 1 1 1 1)
	   (0 0 1 1 1 1 4 0 0 3)
	   (0 0 0 0 0 1 0 0 0 0)
	   (0 0 0 0 0 1 0 0 1 0)
	   (0 0 1 0 0 1 0 0 1 0)
	   (0 2 1 0 0 0 0 0 1 0)
	   (0 0 1 0 0 0 0 0 1 4)))

;(22)
(setq p8 '((1 1 1 1 1 1)
	   (1 4 0 0 4 1)
	   (1 0 2 2 0 1)
	   (1 2 0 1 0 1)
	   (1 3 4 0 4 1)
	   (1 1 1 1 1 1)))

;(34)
(setq p9 '((1 1 1 1 1 1 1 1 1) 
	   (1 1 1 0 0 1 1 1 1) 
	   (1 0 0 0 0 0 2 0 1) 
	   (1 0 1 0 0 1 2 0 1) 
	   (1 0 4 4 4 1 3 0 1) 
	   (1 1 1 1 1 1 1 1 1)))

;(59)
(setq p10 '((1 1 1 1 1 0 0)
	    (1 4 0 0 1 1 0)
	    (1 3 2 0 0 1 1)
	    (1 1 0 2 0 0 1)
	    (0 1 1 0 2 0 1)
	    (0 0 1 1 0 0 1)
	    (0 0 0 1 1 4 1)
	    (0 0 0 0 1 4 1)
	    (0 0 0 0 1 4 1)
	    (0 0 0 0 1 1 1)))

;(?)
(setq p11 '((0 0 1 0 0 0 0)
	    (0 2 1 4 0 4 0)
	    (0 2 0 4 0 0 0)	   
	    (3 2 1 1 1 4 0)
	    (0 0 1 4 0 0 0)))

;(?)
(setq p12 '((1 1 1 1 1 0 0 0)
	    (1 0 0 4 1 0 0 0)
	    (1 2 1 0 1 1 1 1)
	    (1 4 0 0 0 0 0 1)
	    (1 0 0 5 0 5 0 1)
	    (1 0 5 0 1 0 1 1)
	    (1 1 1 0 3 0 1 0)
	    (0 0 1 1 1 1 1 0)))

;(?)
(setq p13 '((1 1 1 1 1 1 1 1 1 1)
	    (1 3 0 0 1 0 0 4 4 1)
	    (1 0 2 0 2 0 0 4 4 1)
	    (1 0 2 2 2 1 1 4 4 1)
	    (1 0 0 0 0 1 1 4 4 1)
	    (1 1 1 1 1 1 0 0 0 0)))

;(?)
(setq p14 '((0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0)
	    (0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0)
	    (1 1 1 1 1 0 0 0 0 0 0 1 1 1 1 1)
	    (0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0)
	    (0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0)
	    (0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0)
	    (0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0)
	    (0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0)
	    (1 1 1 1 1 0 0 0 0 0 0 1 1 1 1 1)
	    (0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0)
	    (0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0)
	    (0 0 0 0 1 0 0 0 0 0 4 1 0 0 0 0)
	    (0 0 0 0 1 0 2 0 0 0 4 1 0 0 0 0)	    
	    (0 0 0 0 1 0 2 0 0 0 4 1 0 0 0 0)
	    ))

;(?)
(setq p15 '((0 0 1 1 1 1 1 1 1 0)
	    (1 1 1 0 0 1 1 1 1 0)
	    (1 0 0 2 0 0 0 1 1 0)
	    (1 3 2 0 2 0 0 0 1 0)
	    (1 1 0 2 0 2 0 0 1 0)
	    (0 1 1 0 2 0 2 0 1 0)
	    (0 0 1 1 0 2 4 0 1 0)
	    (0 0 0 1 1 1 1 0 1 0)
	    (0 0 0 0 1 4 1 0 0 1)
	    (0 0 0 0 1 4 4 4 0 1)
	    (0 0 0 0 1 0 1 4 0 1)
	    (0 0 0 0 1 4 4 4 0 1)
	    (0 0 0 0 1 1 1 1 1 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
 | Utility functions for printing states and moves.
 | You do not need to understand any of the functions below this point.
 |#

;
; Helper function of prettyMoves
; from s1 --> s2
;
(defun detectDiff (s1 s2)
  (let* ((k1 (getKeeperPosition s1 0))
	 (k2 (getKeeperPosition s2 0))
	 (deltaX (- (car k2) (car k1)))
	 (deltaY (- (cadr k2) (cadr k1)))
	 )
    (cond ((= deltaX 0) (if (> deltaY 0) 'DOWN 'UP))
	  (t (if (> deltaX 0) 'RIGHT 'LEFT))
	  );end cond
    );end let
  );end defun

;
; Translates a list of states into a list of moves.
; Usage: (prettyMoves (a* <problem> #'goal-test #'next-states #'heuristic))
;
(defun prettyMoves (m)
  (cond ((null m) nil)
	((= 1 (length m)) (list 'END))
	(t (cons (detectDiff (car m) (cadr m)) (prettyMoves (cdr m))))
	);end cond
  );

;
; Print the content of the square to stdout.
;
(defun printSquare (s)
  (cond ((= s blank) (format t " "))
	((= s wall) (format t "#"))
	((= s box) (format t "$"))
	((= s keeper) (format t "@"))
	((= s star) (format t "."))
	((= s boxstar) (format t "*"))
	((= s keeperstar) (format t "+"))
	(t (format t "|"))
	);end cond
  )

;
; Print a row
;
(defun printRow (r)
  (dolist (cur r)
    (printSquare cur)    
    )
  );

;
; Print a state
;
(defun printState (s)
  (progn    
    (dolist (cur s)
      (printRow cur)
      (format t "~%")
      )
    );end progn
  )

;
; Print a list of states with delay.
;
(defun printStates (sl delay)
  (dolist (cur sl)
    (printState cur)
    (sleep delay)
    );end dolist
  );end defun
