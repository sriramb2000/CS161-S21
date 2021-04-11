;; Utilize the TREE as a queue
;; If first element is not a list, leave it in place and BFS the tail 
;; If first element is a list, append its contents to the end of the tail and BFS
(defun bfs (TREE) (
  let 
  (
    (el1 (first TREE))
    (tail (cdr TREE))
  )
  (
    if (listp el1)
    (
      if (equal el1 nil) 
        nil
      ( 
        bfs (append tail el1)
      )
      
    )
    (
      cons el1 (bfs tail)
    )
  )   
))

;; Performs a right to left dfs of the TREE
;; Does this by performing a dfs on the head of the TREE,
;; and then APPENDING the result to the result of dfs-ing the tail 
;; of the tree
(defun dfs (TREE) (
  if (listp TREE) 
  (
    if (equal TREE nil)
      nil
    (
      append (dfs (cdr TREE)) (dfs (car TREE))
    )
  )
  (
    cons TREE nil
  )
))

;; Performs an iterative dfs up till the provided
;; max-depth. Starts at depth 1 and goes up until 
;; max-depth. Does this by performing a dfs at 
;; depth=max-depth, and then APPENDING that result 
;; to the result of calling dfid again with 
;; max-depth=max-depth - 1
(defun dfid (TREE MAX-DEPTH) (
  if (< MAX-DEPTH 2) 
  (
    dfid-helper TREE MAX-DEPTH
  )
  (
    append (dfid TREE (- MAX-DEPTH 1)) (dfid-helper TREE MAX-DEPTH)
  )
))

;; Performs a dfs only going up until the provided depth
;; Recursively calls itself on the head of the tree, decrementing
;; depth by 1, and then prepends the result of this dfs to the result
;; of calling itself on the tail of three (with the same original depth).
(defun dfid-helper (TREE DEPTH) (
  if (listp TREE)
  (
    if (or (= DEPTH 0) (equal TREE nil))
    nil
    (
      append (dfid-helper (car TREE) (- DEPTH 1)) (dfid-helper (cdr TREE) DEPTH)
    )
  )
  (
    cons TREE NIL
  )
))

; These functions implement a depth-first solver for the missionary-cannibal
; problem. In this problem, three missionaries and three cannibals are trying to
; go from the east side of a river to the west side. They have a single boat
; that can carry two people at a time from one side of the river to the
; other. There must be at least one person in the boat to cross the river. There
; can never be more cannibals on one side of the river than missionaries. If
; there are, the cannibals eat the missionaries.

; In this implementation, a state is represented by a single list
; (missionaries cannibals side). side represents which side the boat is
; currently on, and is T if it is on the east side and NIL if on the west
; side. missionaries and cannibals represent the number of missionaries and
; cannibals on the same side as the boat. Thus, the initial state for this
; problem is (3 3 T) (three missionaries, three cannibals, and the boat are all
; on the east side of the river) and the goal state is (3 3 NIL).

; The main entry point for this solver is the function MC-DFS, which is called
; with the initial state to search from and the path to this state. It returns
; the complete path from the initial state to the goal state: this path is a
; list of intermediate problem states. The first element of the path is the
; initial state and the last element is the goal state. Each intermediate state
; is the state that results from applying the appropriate operator to the
; preceding state. If there is no solution, MC-DFS returns NIL.

; To call MC-DFS to solve the original problem, one would call (MC-DFS '(3 3 T)
; NIL) -- however, it would be possible to call MC-DFS with a different initial
; state or with an initial path.

; Examples of calls to some of the helper functions can be found after the code.



; FINAL-STATE takes a single argument s, the current state, and returns T if it
; is the goal state (3 3 NIL) and NIL otherwise.
(defun final-state (s) (
  equal s '(3 3 nil)
))

; NEXT-STATE returns the state that results from applying an operator to the
; current state. It takes three arguments: the current state (s), a number of
; missionaries to move (m), and a number of cannibals to move (c). It returns a
; list containing the state that results from moving that number of missionaries
; and cannibals from the current side of the river to the other side of the
; river. If applying this operator results in an invalid state (because there
; are more cannibals than missionaries on either side of the river, or because
; it would move more missionaries or cannibals than are on this side of the
; river) it returns NIL.
;
; NOTE that next-state returns a list containing the successor state (which is
; itself a list); the return should look something like ((1 1 T)).
(defun next-state (s m c) (
  let 
  (
    (m2 (+ (- 3 (first s)) m))
    (c2 (+ (- 3 (second s)) c))
    (m3 (- (first s) m))
    (c3 (- (second s) c))
  )
  (
    if (or (> m (first s)) (> c (second s)) (and (> m2 0) (> c2 m2)) (and (> m3 0) (> c3 m3)))
      nil
    (
      cons (cons m2 (cons c2 (cons (not (third s)) nil))) nil
    )
  )
))

; SUCC-FN returns all of the possible legal successor states to the current
; state. It takes a single argument (s), which encodes the current state, and
; returns a list of each state that can be reached by applying legal operators
; to the current state.
(defun succ-fn (s) (
  let 
  (
    (n1 (next-state s 0 1))
    (n2 (next-state s 1 0))
    (n3 (next-state s 1 1))
    (n4 (next-state s 0 2))
    (n5 (next-state s 2 0))
  )
  (
    append n1 n2 n3 n4 n5
  )
))

; ON-PATH checks whether the current state is on the stack of states visited by
; this depth-first search. It takes two arguments: the current state (s) and the
; stack of states visited by MC-DFS (states). It returns T if s is a member of
; states and NIL otherwise.
(defun on-path (s states) (
  if (equal states nil)
    nil
  (
    or (equal s (car states)) (on-path s (cdr states))
  )
))

; MULT-DFS is a helper function for MC-DFS. It takes two arguments: a stack of
; states from the initial state to the current state (path), and the legal
; successor states from the current state (states).
; MULT-DFS does a depth-first search on each element of states in
; turn. If any of those searches reaches the final state, MULT-DFS returns the
; complete path from the initial state to the goal state. Otherwise, it returns
; NIL. 
; Note that the path should be ordered as: (S_n ... S_2 S_1 S_0)
(defun mult-dfs (states path) (
  if (equal states nil)
    nil
  (
    let
    (
      (first-succ (mc-dfs (first states) path))
    )
    (
      if (equal first-succ nil)
      (
        mult-dfs (cdr states) path
      )
        first-succ
    )
  )
))

; MC-DFS does a depth first search from a given state to the goal state. It
; takes two arguments: a state (S) and the path from the initial state to S
; (PATH). If S is the initial state in our search, PATH should be NIL. MC-DFS
; performs a depth-first search starting at the given state. It returns the path
; from the initial state to the goal state, if any, or NIL otherwise. MC-DFS is
; responsible for checking if S is already the goal state, as well as for
; ensuring that the depth-first search does not revisit a node already on the
; search path.
(defun mc-dfs (s path) (
  if (final-state s)
    (append path (cons s nil))
  (
    if (on-path s path) 
      nil
    (
      mult-dfs (succ-fn s) (append path (cons s nil))
    )
  )
))
