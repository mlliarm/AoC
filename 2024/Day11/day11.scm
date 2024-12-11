;; Day 05 Dec. 2024
;; Mi. Lia.
(load "../util/io.scm")
(import srfi-69)
(import srfi-1)

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

(define improperp->properp
  (lambda (pair)
    (append (list (car pair)) (list (cdr pair)))))
    

(define split-in-two
  (lambda (num)
    (define str-of-digits (number->string num))
    (define len (string-length str-of-digits))
    (define char->number
      (lambda (char)
        (- (char->integer char) 48)))
    (define list-of-digits
      (map char->number (string->list str-of-digits)))
     (define (string-join los)
          (fold-right string-append "" los))
    (define lod->number
      (lambda (lod)
        (string->number (string-join (map number->string lod)))))
   (improperp->properp
    (cons
     (lod->number (take-x list-of-digits (/ len 2)))
     (lod->number (reverse (take-x (reverse list-of-digits) (/ len 2))))))))

;; Solution
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
(print "Part 1: Started calculating first 25 blinks")
(define res1  (generate-sol-iter 0 25 data-full-loi)) ;; OK
(print (length res1))

;; Part 2
(print "Part 2: Started calculating next 25 blinks")
(define res2 (generate-sol-iter 0 25 res1)) ;; Crashes with 'out of heap' error
(print (length res2))

(print "Part 2: Started calculating last 25 blinks")
(define res3 (generate-sol-iter 0 25 res2)) ;; Doesn't even get here
(print (length res3))
