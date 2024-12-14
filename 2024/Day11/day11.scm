;; Day 11 Dec. 2024
;; Mi. Lia.

(load "../util/io.scm")
(import srfi-1)
(import srfi-69)
(import (chicken string))

;; Helper functions
(define transform-number
  (lambda (num)
    (cond
     ((equal? num 0) 1)
     ((even? (num-of-digits num)) (split-in-two num))
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
    (let ((left (floor (/ num (expt 10 (/ len 2))))))
     (cons
      left
      (cons (- num (* left (expt 10 (/ len 2)))) '()))))))
     

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
(define generate-sol-iter-cach
  (lambda (counter limit res h)
    (if (equal? counter limit)
        res
        (cond
         ((hash-table-exists? h res) (hash-table-ref h res))
         (else
          (let ((value (solution res)))
            (hash-table-set! h res value)
            (generate-sol-iter-cach (add1 counter)
                                    limit
                                    value
                                    h)))))))
    

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
(define h (make-hash-table))
(print "Part 1: Started calculating first 25 blinks")
(define res1  (generate-sol-iter-cach 0 25 data-full-loi h)) ;; OK
(print (length-iter res1 0))

;; ;; ;; Part 2
(print "Part 2: Started calculating next 25 blinks")
(define res2 (generate-sol-iter-cach 0 25 res1 h)) ;; Crashes with 'out of heap' error
(print (length-iter res2 0))

(print "Part 2: Started calculating last 25 blinks")
(define res3 (generate-sol-iter-cach 0 25 res2 h)) ;; Doesn't even get here
(print (length-iter res3 0))

;;
;; (print "Part 2:")
;; (print (length-iter (generate-sol-iter-cach 0 75 data-full-loi h) 0))
