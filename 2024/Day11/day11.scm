;; Day 05 Dec. 2024
;; Mi. Lia.

(load "../util/io.scm")
(import srfi-69)
(import srfi-1)
(import (math base))


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

(define solution-1
  (lambda (data)
    (flatten (map transform-number data))))

(define generate-sols1-SLOW
 (lambda (data limit res)
   (cond
    ((equal? (length res) limit) res)
    (else
     (generate-sols1-SLOW data limit (append '() (solution-1 data)))))))

(define generate-sols1-iter
  (lambda (counter limit res)
    (if (equal? counter limit)
        res
        (generate-sols1-iter (add1 counter)
                             limit
                             (solution-1 res)))))

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

;;(print (length (generate-sols1-iter 0 25 data-test-loi)))
;;(print (generate-sols1-iter 0 25 data-test-loi))

;; Full data result
;;(print (length (generate-sols1-iter 0 25 data-full-loi)))

(print (length (generate-sols1-iter 0 75 data-full-loi)))
