(load "hw3.lsp")
(load "a-star.lsp")

;; goal-test
(format t "~A~A!~%" "goal-test Test Case 1: " (if (equal (goal-test 
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0))) 
            T) "pass" "FAIL"))

(format t "~A~A!~%" "goal-test Test Case 2: " (if (equal (goal-test 
            '((1 1 1 1 1 1)
            (1 0 3 0 0 1)
            (1 0 2 0 0 1)
            (1 1 0 1 1 1)
            (1 0 0 0 0 1)
            (1 0 4 0 4 1)
            (1 1 1 1 1 1))) 
            NIL) "pass" "FAIL"))

(format t "~%~30~~2%")

;; get-square
(format t "~A~A!~%" "get-square Test Case 1: " (if (equal (get-square
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0)) 3 7) 
            4) "pass" "FAIL"))

(format t "~A~A!~%" "get-square Test Case 2: " (if (equal (get-square
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0)) 20 7) 
            1) "pass" "FAIL"))

(format t "~%~30~~2%")

;; set-square
(format t "~A~A!~%" "set-square Test Case 1: " (if (equal (set-square
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0)) '(3 7) 5) 
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 5 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0))) "pass" "FAIL"))

(format t "~A~A!~%" "set-square Test Case 2: " (if (equal (set-square
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0)) '(20 7) 5) 
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0))) "pass" "FAIL"))

(format t "~%~30~~2%")

(format t "~A~A!~%" "move-coords Test Case 1: " (if (equal (move-coords '(1 6) '(0 1) 1) '(1 7)) "pass" "FAIL"))

(format t "~%~30~~2%")

(format t "~A~A!~%" "try-move Test Case 1: " (if (equal (try-move
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 3 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0)) '(1 6) '(1 0)) 
             '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 3 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0))) "pass" "FAIL"))


(format t "~A~A!~%" "try-move Test Case 2: " (if (equal (try-move
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 6 5 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0)) '(1 6) '(0 1)) 
             '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 4 6 5 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0))) "pass" "FAIL"))

(format t "~A~A!~%" "try-move Test Case 3: " (if (equal (try-move
            '((1 1 1 1 1 1 1 1 1 1)
            (1 6 0 0 1 0 3 4 4 1)
            (1 0 5 0 5 0 2 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 0)) '(1 6) '(1 0)) 
             nil) "pass" "FAIL"))

(format t "~A~A!~%" "try-move Test Case 4: " (if (equal (try-move
            '((1 1 1 1 1 1 1 1 1 1)
            (1 0 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 3 0)) '(5 8) '(-1 0)) 
             '((1 1 1 1 1 1 1 1 1 1)
            (1 0 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 6 1)
            (1 1 1 1 1 1 0 0 0 0))) "pass" "FAIL"))

(format t "~A~A!~%" "try-move Test Case 5: " (if (equal (try-move
            '((1 1 1 1 1 1 1 1 1 1)
            (1 0 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 3 0)) '(5 8) '(0 -1)) 
             '((1 1 1 1 1 1 1 1 1 1)
            (1 0 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 3 0 0))) "pass" "FAIL"))

(format t "~A~A!~%" "try-move Test Case 6: " (if (equal (try-move
            '((1 1 1 1 1 1 1 1 1 1)
            (1 0 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 3 0)) '(5 8) '(0 1)) 
             '((1 1 1 1 1 1 1 1 1 1)
            (1 0 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 0 3))) "pass" "FAIL"))

(format t "~A~A!~%" "try-move Test Case 7: " (if (equal (try-move
            '((1 1 1 1 1 1 1 1 1 1)
            (1 0 0 0 1 0 0 4 4 1)
            (1 0 5 0 5 0 0 4 4 1)
            (1 0 5 5 5 1 1 4 4 1)
            (1 0 0 0 0 1 1 4 4 1)
            (1 1 1 1 1 1 0 0 3 0)) '(5 8) '(1 0)) 
             nil) "pass" "FAIL"))

(format t "~A~A!~%" "try-move Test Case 8: " (if (equal (try-move
            '((1 1 1 1 1 1)
            (1 0 3 0 0 1)
            (1 0 2 0 0 1)
            (1 1 0 1 1 1)
            (1 0 0 0 0 1)
            (1 0 4 0 4 1)
            (1 1 1 1 1 1)) '(1 2) '(1 0)) 
             '((1 1 1 1 1 1)
            (1 0 0 0 0 1)
            (1 0 3 0 0 1)
            (1 1 2 1 1 1)
            (1 0 0 0 0 1)
            (1 0 4 0 4 1)
            (1 1 1 1 1 1))) "pass" "FAIL"))


(format t "~%~30~~2%")

;; sokoban
(format t "~A~A!~%" "sokoban Test Case 1: " (if (equal (length (sokoban
            p1 #'h1))
            7) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 2: " (if (equal (length (sokoban
            p2 #'h1))
            16) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 3: " (if (equal (length (sokoban
            p3 #'h1))
            14) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 4: " (if (equal (length (sokoban
            p4 #'h1))
            18) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 5: " (if (equal (length (sokoban
            p5 #'h1))
            13) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 6: " (if (equal (length (sokoban
            p6 #'h1))
            14) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 7: " (if (equal (length (sokoban
            p7 #'h1))
            48) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 8: " (if (equal (length (sokoban
            p8 #'h1))
            23) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 9: " (if (equal (length (sokoban
            p9 #'h1))
            35) "pass" "FAIL"))

(format t "~A~A!~%" "sokoban Test Case 10: " (if (equal (length (sokoban
            p10 #'h1))
            60) "pass" "FAIL"))