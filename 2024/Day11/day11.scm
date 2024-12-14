;; Day 11 Dec. 2024
;; Mi. Lia.

(load "../util/io.scm")
(import srfi-1)
(import srfi-69)
(import (chicken string))
(import generic-helpers)

;; Helper functions
(define transform-number
  (lambda (num)
    (cond
     ((equal? num 0) 1)
     ((even? (num-of-digits num)) (split-in-two num))
     (else
      (* 2024 num)))))

(define transform-number-cach
  (lambda (htable num)
    (cond
     ((equal? num 0) 1)
     ((even? (num-of-digits num)) (cond
                                   ((hash-table-exists? htable num)
                                    (hash-table-ref htable num))
                                   (else
                                    (let ((value (split-in-two num)))
                                      (hash-table-set! htable num value)
                                      value))))
     (else
      (* 2024 num)))))

(define num-of-digits
  (lambda (num)
    (string-length (number->string num))))

;; Using the following formulas to calculate left and right children of
;; number with even number of digits:
;;
;; left  = (floor (/ num (expt 10 (/ len 2))))
;; right = (num - (* left (expt 10 (/ len 2))))
(define split-in-two
  (lambda (num)
    (let ((len (num-of-digits num)))
      (let ((half-dig (/ len 2)))
        (let ((left (floor (/ num (expt 10 half-dig)))))
          (cons
           left
           (cons (- num (* left (expt 10 half-dig))) '())))))))

;; Solution 1
(define solution
  (lambda (data)
    (flatten (map transform-number data))))

(define generate-sol-iter
  (lambda (counter limit res)
    (if (equal? counter limit)
        res
        (generate-sol-iter (add1 counter)
                           limit
                           (solution res)))))

;; Solution 2
(define solution-2
  (lambda (data h-num)
    (flatten (map (lambda (d) (transform-number-cach h-num d))
                  data))))

(define generate-sol-iter-cach
  (lambda (counter limit res h-num)
    (if (equal? counter limit)
        res
        (generate-sol-iter-cach (add1 counter)
                                limit
                                (solution-2 res h-num)
                                h-num))))

;; ================================== Main program ==============================================
;;
;; Input data as lolos
(define data-test
  (read-input-file "test.dat"))

(define data-full
  (read-input-file "full.dat"))

(define data-to-loi
  (lambda (data)
    (map string->number (string-split (list-ref data 0)))))

(define data-test-loi
  (data-to-loi data-test))

(define data-full-loi
  (data-to-loi data-full))

;; Test data results
;;(print (length (generate-sol-iter 0 25 data-test-loi)))
;;(print (generate-sol-iter 0 25 data-test-loi))

;; Full data results
;; Part 1
(define h-num (make-hash-table))
(print "Part 1: Started calculating first 25 blinks")
(define res1  (generate-sol-iter-cach 0 25 data-full-loi h-num)) ;; OK
(print (length-iter res1 0))

;; ;; ;; Part 2
(print "Part 2: Started calculating next 25 blinks")
(define res2 (generate-sol-iter-cach 0 25 res1 h-num)) ;; Crashes with 'out of heap' error
(print (length-iter res2 0))

(print "Part 2: Started calculating last 25 blinks")
(define res3 (generate-sol-iter-cach 0 25 res2 h-num)) ;; Doesn't even get here
(print (length-iter res3 0))

;;
;; (print "Part 2:")
;; (print (length-iter (generate-sol-iter-cach 0 75 data-full-loi h) 0))
