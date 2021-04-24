(load "hw4.lsp")

(time (solve-cnf "cnfs/f1/sat_f1.cnf"))
(format t "~A!~%" "Testcase f1")

(time (solve-cnf "cnfs/f2/sat_f2.cnf"))
(format t "~A!~%" "Testcase f2")

(time (solve-cnf "cnfs/f3/sat_f3.cnf"))
(format t "~A!~%" "Testcase f3")

(time (solve-cnf "cnfs/f4/sat_f4.cnf"))
(format t "~A!~%" "Testcase f4")

(time (solve-cnf "cnfs/f5/sat_f5.cnf"))
(format t "~A!~%" "Testcase f5")