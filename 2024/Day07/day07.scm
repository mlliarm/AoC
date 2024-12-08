;; Day 05 Dec. 2024
;; Mi. Lia.

(load "../util/io.scm")
(import srfi-69)
(import srfi-1)
(import (math base))


;; 1. Generate all N numbers from 1 to N where N is the length of a list of numbers -1

;; 2. Turn a number from dec to binary.

;; 3. Turn list of 1..N numbers to a list of binary numbers

;; 4. Turn each binary number to a list of binary digits

;; 5. Create a function that applies * if to a pair of data if flag is 1 and + if flag is 0
(define multi-or-add
  (lambda (flag pair)
    (cond
     ((equal? flag 1) (eval (flatten '(* pair))))
     ((equal? flag 0) (eval (flatten '(+ pair))))
     (else
      (print "Input Error !")))))



;; ================================== Main program ==============================================
;;
;; Input data as lolos
(define data-test
   (read-input-file "test.dat"))

(define data-full
   (read-input-file "full.dat"))

;; Split by sep
(define conv-to-lolos-general
  (lambda (los sep)
    (map (lambda (x) (string-split x sep)) los)))

(define data-split-i
  (lambda (data)
    (map los-to-loi (conv-to-lolos-general data " :"))))

(define data-test-i
  (data-split-i data-test))

(define data-full-i
  (data-split-i data-full))

