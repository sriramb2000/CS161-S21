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