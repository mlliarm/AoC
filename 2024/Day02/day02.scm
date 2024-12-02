;; Day02 Dec. 2024
;; Mi. Lia.

(import (chicken io)
        (chicken string)
        (chicken sort))

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
     


;; ================================== Main program ==============================================
;;
;; Input data as lolos
(define data
  (conv-to-lolos
   (read-input-file "test.dat")))

;; Convert strings to integers
(define data-i
  (map los-to-loi data))


;; Part 1 solution



