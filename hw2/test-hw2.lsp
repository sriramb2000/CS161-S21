;; BFS
(format t "~A~A!~%" "BFS Test Case 1: " (if (equal (BFS '((A (B)) C (D))) '(C A D B)) "pass" "FAIL"))

(format t "~A~A!~%" "BFS Test Case 2: " (if (equal (BFS '((W X) (Y Z))) '(W X Y Z)) "pass" "FAIL"))

(format t "~A~A!~%" "BFS Test Case 3: " (if (equal (BFS '()) '()) "pass" "FAIL"))

(format t "~A~A!~%" "BFS Test Case 4: " (if (equal (BFS '(1)) '(1)) "pass" "FAIL"))

(format t "~A~A!~%" "BFS Test Case 5: " (if (equal (BFS '(1 2 (3) 4)) '(1 2 4 3)) "pass" "FAIL"))

(format t "~A~A!~%" "BFS Test Case 6: " (if (equal (BFS '(A (B C) (D) (E (F G)))) '(A B C D E F G)) "pass" "FAIL"))

(format t "~%~30~~2%")

;; DFS
(format t "~A~A!~%" "DFS Test Case 1: " (if (equal (DFS '((A (B)) C (D))) '(D C B A)) "pass" "FAIL"))

(format t "~A~A!~%" "DFS Test Case 2: " (if (equal (DFS '((W X) (Y Z))) '(Z Y X W)) "pass" "FAIL"))

(format t "~A~A!~%" "DFS Test Case 3: " (if (equal (DFS '()) '()) "pass" "FAIL"))

(format t "~A~A!~%" "DFS Test Case 4: " (if (equal (DFS '(1)) '(1)) "pass" "FAIL"))

(format t "~A~A!~%" "DFS Test Case 5: " (if (equal (DFS '(1 2 (3) 4)) '(4 3 2 1)) "pass" "FAIL"))

(format t "~A~A!~%" "DFS Test Case 6: " (if (equal (DFS '(A (B C) (D) (E (F G)))) '(G F E D C B A)) "pass" "FAIL"))

(format t "~%~30~~2%")

;; DFID
(format t "~A~A!~%" "DFID Test Case 1: " (if (equal (DFID '((A (B)) C (D)) 2) '(C A C D)) "pass" "FAIL"))

(format t "~A~A!~%" "DFID Test Case 2: " (if (equal (DFID '((A (B)) C (D)) 1) '(C)) "pass" "FAIL"))

(format t "~A~A!~%" "DFID Test Case 3: " (if (equal (DFID '((A (B)) C (D)) 0) '()) "pass" "FAIL"))

(format t "~A~A!~%" "DFID Test Case 4: " (if (equal (DFID '((A (B)) C (D)) 3) '(C A C D A B C D)) "pass" "FAIL"))

(format t "~A~A!~%" "DFID Test Case 5: " (if (equal (DFID '() 3) '()) "pass" "FAIL"))

(format t "~A~A!~%" "DFID Test Case 6: " (if (equal (DFID '(A (B C) (D) (E (F G))) 3) '(A A B C D E A B C D E F G)) "pass" "FAIL"))

(format t "~%~30~~2%")




;; Missionary-Cannibal Problem

(format t "~A~A!~%" "MCP Test Case 1: " (if (equal (FINAL-STATE '(3 3 NIL)) T) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 2: " (if (equal (FINAL-STATE '(3 3 T)) NIL) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 3: " (if (equal (NEXT-STATE '(3 3 T) 1 0) NIL) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 4: " (if (equal (NEXT-STATE '(3 3 T) 0 1) '((0 1 NIL))) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 5: " (if (equal (ON-PATH '(3 3 T) '((3 3 NIL) (3 3 T))) T) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 6: " (if (equal (ON-PATH '(3 3 T) '((3 3 NIL) (3 2 T))) NIL) "pass" "FAIL"))

;; succ-fn tests are order dependent so can be flakey
(format t "~A~A!~%" "MCP Test Case 7: " (if (equal (succ-fn '(3 3 t)) '((0 1 NIL) (1 1 NIL) (0 2 NIL))) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 8: " (if (equal (succ-fn '(1 1 t)) '((3 2 NIL) (3 3 NIL))) "pass" "FAIL"))

;; This test can be flakey - if this doesn't pass change the second to last element in this list to (0 2 NIL)
(format t "~A~A!~%" "MCP Test Case 9: " (if (equal (MC-DFS '(3 3 T) NIL) (reverse '((3 3 NIL) (0 2 T) (3 2 NIL) (0 3 T) (3 1 NIL) (2 2 T) (2 2 NIL) (3 1 T) (0 3 NIL) (3 2 T) (1 1 NIL) (3 3 T)))) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 10: " (if (equal (MC-DFS '(0 0 T) NIL) NIL) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 11: " (if (equal (MC-DFS '(3 3 NIL) NIL) '((3 3 NIL))) "pass" "FAIL"))

(format t "~A~A!~%" "MCP Test Case 12: " (if (equal (MC-DFS '(0 0 NIL) NIL) NIL) "pass" "FAIL"))