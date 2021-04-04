(defun TREE-CONTAINS (N TREE)
    (
        if (listp TREE) 
        (
            ;; If TREE is of form (L m R), compare to m, then recurse on L and R
            if (= (second TREE) N) 
                t 
                (
                    or 
                        (TREE-CONTAINS N (first TREE))
                        (TREE-CONTAINS N (third TREE))
                )
        ) 
        (
            ;; If TREE is of form n, compare to n
            = TREE N
        )
    )
)

(defun TREE-MIN (TREE)
    (
        if (listp TREE) 
        (
            ;; Minimum element will be the leftmost element for tree of form (L m R), so we recurse on L
            TREE-MIN (first TREE)
        )
        ;; Minimum element of tree of form n will always be n 
        TREE
    )
)

(defun TREE-ORDER (TREE)
    (
        if (listp TREE) 
        (
            ;; If Tree of form (L m R), get m, then recurse on and append L and R
            append (TREE-ORDER (second TREE)) (TREE-ORDER (first TREE)) (TREE-ORDER (third TREE))
        )
        ;; If Tree of form n, then return (n) 
        (cons TREE nil)
    )
)

;; Recurse by taking the tail of L until START index becomes 0
;; Then build result list by taking the head element, decrementing LEN, and recursing on the tail of L
(defun SUB-LIST (L START LEN)
    (
        if L 
        (
            if (= START 0)
            (
                ;; If START=0, begin building result list
                if (= LEN 0)
                    ;; If LEN=0, we're done building result list, return nil
                    nil
                (
                    ;; Prepend current head to result of recursive call on the tail of L
                    cons (car L) (SUB-LIST (cdr L) START (- LEN 1))
                )
            )
            (
                ;; Keep taking the tail of L till we get to START=0
                SUB-LIST (cdr L) (- START 1) LEN
            )
        )
        ;; If list is empty, return nil 
        nil
    )
)

(defun SPLIT-LIST (L)
    (
        if (= (length L) 0)
            '(nil nil)
        (
            if (evenp (length L))
            (
                let 
                (
                    (half (/ (length L) 2))
                ) 
                (
                    ;; Make 2 sublists, each of the same length, split down the middle
                    cons (SUB-LIST L 0 half) (cons (SUB-LIST L half half) nil)
                )
            )
            (
                let 
                (
                    ;; Take tail of list (to make list length even), split down middle
                    (lists (SPLIT-LIST (cdr L)))
                ) 
                (
                    ;; Prepend first element of L to the first list returned from SPLIT-LIST call
                    cons (cons (car L) (first lists)) (cons (second lists) nil)
                )
            )
        )
    )
)

(defun BTREE-HEIGHT (TREE)
    (
        if (listp TREE) 
        (
           let
           (
               (lHeight (BTREE-HEIGHT (first TREE)))
               (rHeight (BTREE-HEIGHT (second TREE)))
           )
           (
                ;; Add 1 to represent internal node, then add max height of L and R subtree
               + 1 (if (> lHeight rHeight) lHeight rHeight)
           )
        )
            ;; Distance from root to leaf node is 0 when TREE is a leaf node 
            0
    )
)

(defun LIST2BTREE (LEAVES)
    (
        if (> (length LEAVES) 1) 
        (
            if (= (length LEAVES) 2)
                ;; If length=2, we can treat LEAVES as an internal node of form (L R)
                LEAVES
            (
                let
                (
                    ;; Split LEAVES in half, with a maximum length difference of 1
                    (halves (SPLIT-LIST LEAVES))
                )
                (
                    ;; Recursively construct BTREE from each half of the list and join them together
                    cons (LIST2BTREE (first halves)) (cons (LIST2BTREE (second halves)) nil)
                )
                
            )
        ) 
        (
            ;; If length=1, then return head of list as leaf node
            car LEAVES
        )   
    )
)

(defun BTREE2LIST (TREE)
    (
        if (listp TREE) 
        (
            ;; If internal node, recurse on L and R subtrees and append the results together
            append (BTREE2LIST (first TREE)) (BTREE2LIST (second TREE)) 
        ) 
        (
            ;; If leaf node, create a list from the leaf node
            cons TREE nil
        )   
    )
)

(defun IS-SAME (E1 E2)
    (
        if (= (length E1) (length E2))
        (
            if (= (length E1) 0)
                ;; If both lists are empty, then we've recursed through both lists with no issue
                t
            (
                let
                (
                    (el1 (first E1))
                    (tail1 (cdr E1))
                    (el2 (first E2))
                    (tail2 (cdr E2))
                )
                (
                    if (and (listp el1) (listp el2))
                    (
                        ;; If both of the first elements are lists, then recursively compare the first elements
                        ;; And then recursively compare the rest of the expression
                        and (IS-SAME el1 el2) (IS-SAME tail1 tail2)
                    )
                    (
                        if (and (numberp el1) (numberp el2))
                        (
                            ;; If both of the first elements are numbers, directly compare the numbers then recursively
                            ;; compare the rest of the expression
                            and (= el1 el2) (IS-SAME tail1 tail2)
                        )
                            ;; If both of the first elements are of different types, then they cannot be equal
                            nil
                    )
                )
            )
        )
            ;; If expressions don't have the same length, they can't be equal
            nil  
    )
)