;; Day02 Dec. 2024
;; Mi. Lia.

(import (chicken io)
        (chicken string))

;; Reads lines into a list of strings
(define read-input-file
  (lambda (input-file)
    (string-split
     (read-string #f (open-input-file input-file))
     "\n")))

;; Converts list of strings to list of lists of strings
(define conv-to-lolos
  (lambda (mydata)
    (map string-split mydata)))

;; Convert quote list of strings to list of ints
(define los-to-loi
  (lambda (los)
    (map string->number los)))

;; Monotonic increase ?
(define monotonic-inc?
  (lambda (lat)
    (apply < lat)))

;; Monotonic decrease ?
(define monotonic-dec?
  (lambda (lat)
    (apply > lat)))

;; Monotonic change (increase/decrease) ?
(define monotonic?
  (lambda (lat)
    (or
     (monotonic-inc? lat)
     (monotonic-dec? lat))))

;; Safe difference between levels?
(define diff
  (lambda (x y)
    (abs (- x y))))

(define safe-diff?
  (lambda (x y)
    (and
     (> (diff x y) 0)
     (< (diff x y) 4))))

(define safe-level-diff?
  (lambda (lat)
    (cond
     ((null? lat) #t)
     ((null? (cdr lat)) #t)
     ((safe-diff? (car lat) (cadr lat))
      (safe-level-diff? (cdr lat)))
     (else
      #f))))
     
;; Is the list of integers safe?
(define safe?
  (lambda (lat)
    (and
     (monotonic? lat)
     (safe-level-diff? lat)
     )))
     
;; Count multiples of atom in given list of atoms
(define multi
  (lambda (a lat)
    (cond
     ((null? lat) 0)
     (else
      (cond
       ((eq? (car lat) a)
        (add1 (multi a (cdr lat))))
       (else (multi a (cdr lat))))))))

;; Drop front elements after it's safe
(define my-drop
   (lambda (lat)
     (cond
      ((null? lat) '())
      ((safe? lat) lat)
      ((not (safe? lat)) (my-drop (cdr lat)))
      (else
       ;(cons (cadr lat) (my-drop (cddr lat)))))))
       ;(cons (car lat) (my-drop lat))))))
       (my-drop (cdr (cdr lat)))))))
       ;(my-drop (cdr lat))))))

;; Remove last element of list
(define pop-last
  (lambda (lat)
    (reverse (cdr (reverse lat)))))

;; Take front elements up to safe?
(define my-take
  (lambda (lat)
    (cond
     ((null? lat) '())
     ((safe? lat) lat)
     ((not (safe? lat)) (my-take (pop-last lat)))
     (else
      (my-take (pop-last (pop-last lat)))))))

;; Quasi-safe returns true if by removing one element it's safe
(define quasi-safe?
  (lambda (lat)
    (cond
     ((null? lat) #f)
     ((safe? lat) #t)
     ((safe? (append (my-take lat) (my-drop lat))) #t)
     ;((safe? (append (my-take lat) (cdr (my-drop lat)))) #t)
     ;((safe? (append (my-take lat) (pop-last (my-drop lat)))) #t)
     ;((safe? (append (pop-last (my-take lat)) (my-drop lat))) #t)
     ;((safe? (append (pop-last (my-take lat)) (cdr (my-drop lat)))) #t)
     (else #f))))

;; ================================== Main program ==============================================
;;
;; Input data as lolos
(define data-test
  (conv-to-lolos
   (read-input-file "full.dat")))

(define data-full
  (conv-to-lolos
   (read-input-file "test.dat")))

;; Convert strings to integers
(define data-test-i
  (map los-to-loi data-test))

(define data-full-i
  (map los-to-loi data-full))

;; Part 1 solution
(print "Part 1 solution: " (multi #t (map safe? data-test-i)))
(print "Part 1 full sol: " (multi #t (map safe? data-full-i)))

;; Part 2 solution
(print "Part 2 solution: " (multi #t (map quasi-safe? data-test-i)))
(print "Part 2 full sol: " (multi #t (map quasi-safe? data-full-i))) ;; 852, 849, 949, 959

;; Testing edge cases
(print "Test: " (map quasi-safe? '((1 2 3 8 9) (1 1 2 3 4) (1 2 3 3 4) (1 20 3 4 5) (1 2 8 9 4) (1 8 9 2 4))))
(print "Test: " (eq? '(map quasi-safe? '((1 2 3 8 9) (1 1 2 3 4) (1 2 3 3 4) (1 20 3 4 5) (1 2 8 9 4) (1 8 9 2 4)))
                     '(#f #t #t #t #f #f)))
