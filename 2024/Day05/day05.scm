;; Day 05 Dec. 2024
;; Mi. Lia.

(load "../util/io.scm")
(import srfi-69)
(import srfi-1)
(import (math base))

;; Part 1
(define before?
  (lambda (a b pair)
    (cond
     ((null? pair) #f)
     (else
      (and
       (equal? (car pair) a)
       (equal? (cadr pair) b))))))

(define before-all?
  (lambda (a b rules)
    ;(print a b rules)
    (cond
     ((null? rules) #f)
     ((before? a b (car rules)) #t)
     (else
      (before-all? a b (cdr rules))))))

(define correct-order?
  (lambda (rules update)
    (define (correct? b-index result)
      ;(print "bi: " b-index " res: " result)
      (if (or
           (= b-index (length update))
           (equal? result #f))
          result
          (correct? (add1 b-index)
                    (before-all? (list-ref update 0)
                                 (list-ref update b-index)
                                 rules)
                    )
          )
      )
    (if (not (null? update))
        (if (correct? 1 #t)
            (correct-order? rules (cdr update))
            #f)
        #t)))
      
;; ================================== Main program ==============================================
;;
;; Input data as lolos
(define data-test
   (read-input-file "test.dat"))

(define data-full
   (read-input-file "full.dat"))

;; Split lists of strings to vector of lists of strings
(define get-volos
  (lambda (lat)
      (list-of-strings-split lat "|,")))

;; Convert vector of lists of strings
;; to list of lists of strings
(define get-lolos
  (lambda (lat)
    (vector->list (get-volos lat))))

;; Convert test data to lolos
(define data-test-lolos
  (get-lolos data-test))

;; Convert full data to lolos
(define data-full-lolos
  (get-lolos data-full))

;; Remove the lists that have length less than 3
;; Keep the page updates lists
(define page-updates
  (lambda (lat)
    (remove (lambda (x) (< (length x) 3)) lat)))

;; Remove the lists that have length greater or equal to 3
;; Keep the rules lists
(define rules
  (lambda (lat)
    (remove (lambda (x) (not (< (length x) 3))) lat)))

;; Test data split in two different lists of lists of strings 
(define rules-test
  (rules data-test-lolos))

(define page-updates-test
  (page-updates data-test-lolos))

;; Full data split as the test data
(define rules-full
  (rules data-full-lolos))

(define page-updates-full
  (page-updates data-full-lolos))

;; Testing
(for-each (lambda (x) (print x ": " (correct-order? rules-test x)))
          page-updates-test)

;(for-each (lambda (x) (print x ": " (correct-order? rules-full x)))
;          page-updates-full)

;; Solutions
(define sol
  (lambda (rules page-updates)
    (remove (lambda (x) (not (correct-order? rules x))) page-updates)))

(define middle
  (lambda (lat)
    (list-ref lat (floor (/ (length lat) 2)))))

;; Solution 1

;; Test
(print (sum (map string->number (map middle (sol rules-test page-updates-test)))))

;; Full
(print (sum (map string->number (map middle (sol rules-full page-updates-full)))))
