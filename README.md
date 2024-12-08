<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"> <b>Студент(-ка)</b>: <i>Гнатюк Софія Валентинівна КВ-12</i><p>
<p align="right"><b>Рік</b>: <i>2024</i><p>
  
### Загальне завдання
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку. Не допускається використання: псевдо-функцій, деструктивних операцій, циклів, функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і деструктивних функцій (псевдофункцій). Не допускається використання функцій вищого порядку або функцій для роботи зі списками послідовностями, що використовуються як функції вищого порядку. Тим не менш, оригінальний список цей варіант реалізації також не має змінювати, тому перед виконанням деструктивних змін варто застосувати функцію copy-list (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).

### Завдання за варіантом 5
Алгоритм сортування обміном №2 (із використанням прапорця) за незменшенням.

## Лістинг функції з використанням конструктивного підходу
```lisp
(defun remove-seconds (lst &optional (index 1))
  (cond
    ((null lst) nil)
    ((oddp index) (cons (car lst) (remove-seconds (cdr lst) (1+ index)))) 
    (t (remove-seconds (cdr lst) (1+ index)))))
```
### Тестові набори та утиліти
```lisp
(defun check-bubble-sort-functional (name input expected)
  (format t "~:[FAILED~;passed~]: ~a~%" 
          (equal (bubble-sort-functional input) expected) name))
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
```
### Тестування

```lisp
Testing functional implementation:
passed: Test 1
passed: Test 2
passed: Test 3
passed: Test 4
passed: Test 5
```
## Лістинг функції з використанням деструктивного підходу
```lisp
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
```
### Тестові набори та утиліти
```lisp
(defun check-bubble-sort-imperative (name input expected)
  (format t "~:[FAILED~;passed~]: ~a~%" 
          (equal (bubble-sort-imperative input) expected) name))
(defun test-bubble-sort ()
  (let ((test-cases '((:name "Test 1" :input (7 3 9 1 4 6 2 5) :expected (1 2 3 4 5 6 7 9))
                      (:name "Test 2" :input (5 4 3 2 1) :expected (1 2 3 4 5))
                      (:name "Test 3" :input (1 2 3 4 5) :expected (1 2 3 4 5))
                      (:name "Test 4" :input () :expected ())
                      (:name "Test 5" :input (42) :expected (42)))))
    (format t "~%Testing imperative implementation:~%")
    (dolist (test test-cases)
      (check-bubble-sort-imperative (getf test :name) 
                                    (getf test :input) 
                                    (getf test :expected)))))

(test-bubble-sort)
```
### Тестування
```lisp
Testing imperative implementation:
passed: Test 1
passed: Test 2
passed: Test 3
passed: Test 4
passed: Test 5
```
