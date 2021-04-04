;; TREE-CONTAINS
(format t "~A~A!~%" "TREE-CONTAINS Test Case 1: " (if (TREE-CONTAINS 3 '((1 2 3) 7 8)) "pass" "fail"))

(format t "~A~A!~%" "TREE-CONTAINS Test Case 2: " (if (not (TREE-CONTAINS 4 '((1 2 3) 7 8))) "pass" "fail"))

(format t "~A~A!~%" "TREE-CONTAINS Test Case 3: " (if (not (TREE-CONTAINS 69 420)) "pass" "fail"))

(format t "~%~30~~2%")

;; TREE-MIN
(format t "~A~A!~%" "TREE-MIN Test Case 1: " (if (= (TREE-MIN '(-10 7 10)) -10) "pass" "fail"))

(format t "~A~A!~%" "TREE-MIN Test Case 2: " (if (= (TREE-MIN '((1 2 3) 7 8)) 1) "pass" "fail"))

(format t "~A~A!~%" "TREE-MIN Test Case 3: " (if (= (TREE-MIN 1) 1) "pass" "fail"))

(format t "~%~30~~2%")

;; TREE-ORDER

(format t "~A~A!~%" "TREE-ORDER Test Case 1: " (if (equal (TREE-ORDER 3) '(3)) "pass" "fail"))

(format t "~A~A!~%" "TREE-ORDER Test Case 2: " (if (equal (TREE-ORDER '((1 2 3) 7 8)) '(7 2 1 3 8)) "pass" "fail"))

(format t "~%~30~~2%")

;; SUB-LIST

(format t "~A~A!~%" "SUB-LIST Test Case 1: " (if (equal (SUB-LIST '(a b c d) 0 3) '(a b c)) "pass" "fail"))

(format t "~A~A!~%" "SUB-LIST Test Case 2: " (if (equal (SUB-LIST '(a b c d) 3 1) '(d)) "pass" "fail"))

(format t "~A~A!~%" "SUB-LIST Test Case 3: " (if (equal (SUB-LIST '(a b c d) 2 0) nil) "pass" "fail"))

(format t "~%~30~~2%")

;; SPLIT-LIST

(format t "~A~A!~%" "SPLIT-LIST Test Case 1: " (if (equal (SPLIT-LIST '(a b c d)) '((a b) (c d))) "pass" "fail"))

(format t "~A~A!~%" "SPLIT-LIST Test Case 2: " (if (equal (SPLIT-LIST '(a b c d e)) '((a b c) (d e))) "pass" "fail"))

(format t "~A~A!~%" "SPLIT-LIST Test Case 3: " (if (equal (SPLIT-LIST '(a b c d e f)) '((a b c) (d e f))) "pass" "fail"))

(format t "~A~A!~%" "SPLIT-LIST Test Case 4: " (if (equal (SPLIT-LIST '(a)) '((a) ())) "pass" "fail"))

(format t "~A~A!~%" "SPLIT-LIST Test Case 5: " (if (equal (SPLIT-LIST '()) '(() ())) "pass" "fail"))

(format t "~%~30~~2%")

;; BTREE-HEIGHT

(format t "~A~A!~%" "BTREE-HEIGHT Test Case 1: " (if (= (BTREE-HEIGHT 1) 0) "pass" "fail"))

(format t "~A~A!~%" "BTREE-HEIGHT Test Case 2: " (if (= (BTREE-HEIGHT '(1 2)) 1) "pass" "fail"))

(format t "~A~A!~%" "BTREE-HEIGHT Test Case 3: " (if (= (BTREE-HEIGHT '(1 (2 3))) 2) "pass" "fail"))

(format t "~A~A!~%" "BTREE-HEIGHT Test Case 4: " (if (= (BTREE-HEIGHT '((1 2) (3 4))) 2) "pass" "fail"))

(format t "~A~A!~%" "BTREE-HEIGHT Test Case 5: " (if (= (BTREE-HEIGHT '((1 (2 3)) ((4 5) (6 7)))) 3) "pass" "fail"))

(format t "~A~A!~%" "BTREE-HEIGHT Test Case 6: " (if (= (BTREE-HEIGHT '(((1 2) (3 4)) ((5 6) (7 8)))) 3) "pass" "fail"))

(format t "~%~30~~2%")

;; LIST2BTREE

(format t "~A~A!~%" "LIST2BTREE Test Case 1: " (if (equal (LIST2BTREE '(1)) 1) "pass" "fail"))

(format t "~A~A!~%" "LIST2BTREE Test Case 2: " (if (equal (LIST2BTREE '(1 2)) '(1 2)) "pass" "fail"))

(format t "~A~A!~%" "LIST2BTREE Test Case 3: " (if (equal (LIST2BTREE '(1 2 3)) '((1 2) 3)) "pass" "fail"))

(format t "~A~A!~%" "LIST2BTREE Test Case 4: " (if (equal (LIST2BTREE '(1 2 3 4)) '((1 2) (3 4))) "pass" "fail"))

(format t "~A~A!~%" "LIST2BTREE Test Case 5: " (if (equal (LIST2BTREE '(1 2 3 4 5 6 7)) '(((1 2) (3 4)) ((5 6) 7))) "pass" "fail"))

(format t "~A~A!~%" "LIST2BTREE Test Case 6: " (if (equal (LIST2BTREE '(1 2 3 4 5 6 7 8)) '(((1 2) (3 4)) ((5 6) (7 8)))) "pass" "fail"))

(format t "~%~30~~2%")

;; BTREE2LIST

(format t "~A~A!~%" "BTREE2LIST Test Case 1: " (if (equal (BTREE2LIST 1) '(1)) "pass" "fail"))

(format t "~A~A!~%" "BTREE2LIST Test Case 2: " (if (equal (BTREE2LIST '(1 2)) '(1 2)) "pass" "fail"))

(format t "~A~A!~%" "BTREE2LIST Test Case 3: " (if (equal (BTREE2LIST '((1 2) 3)) '(1 2 3)) "pass" "fail"))

(format t "~A~A!~%" "BTREE2LIST Test Case 4: " (if (equal (BTREE2LIST '((1 2) (3 4))) '(1 2 3 4)) "pass" "fail"))

(format t "~A~A!~%" "BTREE2LIST Test Case 5: " (if (equal (BTREE2LIST '(((1 2) (3 4)) ((5 6) 7))) '(1 2 3 4 5 6 7)) "pass" "fail"))

(format t "~A~A!~%" "BTREE2LIST Test Case 6: " (if (equal (BTREE2LIST '(((1 2) (3 4)) ((5 6) (7 8)))) '(1 2 3 4 5 6 7 8)) "pass" "fail"))

(format t "~%~30~~2%")

;; IS-SAME

(format t "~A~A!~%" "IS-SAME Test Case 1: " (if (IS-SAME '((1 2 3) 7 8) '((1 2 3) 7 8)) "pass" "fail"))

(format t "~A~A!~%" "IS-SAME Test Case 2: " (if (not (IS-SAME '(1 2 3 7 8) '((1 2 3) 7 8))) "pass" "fail"))

(format t "~%~30~~2%")
