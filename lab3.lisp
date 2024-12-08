(defun bubble-sort-functional (list)
  (labels ((bubble-pass (lst last-index)
             (cond
               ((or (null lst) (null (cdr lst))) lst)
               ((<= last-index 0) lst)
               (t
                (let ((head (first lst))
                      (tail (cdr lst)))
                  (if (> head (first tail))
                      (cons (first tail) (bubble-pass (cons head (cdr tail)) (1- last-index)))
                      (cons head (bubble-pass tail (1- last-index))))))))
           (sort-helper (lst last-index)
             (if (or (null lst) (<= last-index 0))
                 lst
                 (sort-helper (bubble-pass lst last-index) (1- last-index)))))
    (sort-helper list (1- (length list)))))

(defun bubble-sort-imperative (list)
  (let ((copied-list (copy-list list)))
    (loop with swapped = t
          with r = (1- (length copied-list))
          while swapped
          do (progn
               (setf swapped nil)

              (loop for i from 0 below r
                     do (when (> (nth i copied-list) (nth (1+ i) copied-list))
                          (rotatef (nth i copied-list) (nth (1+ i) copied-list))
                          (setf swapped t)))
               (decf r)))
    copied-list))

(defun check-bubble-sort-functional (name input expected)
  (format t "~:[FAILED~;passed~]: ~a~%" 
          (equal (bubble-sort-functional input) expected) name))

(defun check-bubble-sort-imperative (name input expected)
  (format t "~:[FAILED~;passed~]: ~a~%" 
          (equal (bubble-sort-imperative input) expected) name))

(defun test-bubble-sort ()
  (let ((test-cases '((:name "Test 1" :input (7 3 9 1 4 6 2 5) :expected (1 2 3 4 5 6 7 9))
                      (:name "Test 2" :input (5 4 3 2 1) :expected (1 2 3 4 5))
                      (:name "Test 3" :input (1 2 3 4 5) :expected (1 2 3 4 5))
                      (:name "Test 4" :input () :expected ())
                      (:name "Test 5" :input (42) :expected (42)))))
    (format t "~%Testing functional implementation:~%")
    (dolist (test test-cases)
      (check-bubble-sort-functional (getf test :name) 
                                    (getf test :input) 
                                    (getf test :expected)))
    (format t "~%Testing imperative implementation:~%")
    (dolist (test test-cases)
      (check-bubble-sort-imperative (getf test :name) 
                                    (getf test :input) 
                                    (getf test :expected)))))

(test-bubble-sort)

