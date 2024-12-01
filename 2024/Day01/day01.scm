;; AoC 2024, Day 01

(import (chicken io)
        (chicken string)
        (chicken sort)
        (math base))

;; Reads lines into a list of strings
(define read-input-file
  (lambda (input-file)
    (string-split
     (read-string #f
                  (open-input-file input-file))
     "\n")))

;; Converts list of strings to list of lists of strings
(define conv-to-lolos
  (lambda (mydata)
    (map string-split mydata)))

;; Get from lists of pairs of strings
;; list of left elements
(define left-elems
  (lambda (l)
    (cond
     ((null? l) '())
     (else
      (cons (car (car l)) (left-elems (cdr l)))))))

;; Get from lists of pairs of strings
;; list of right elements
(define right-elems
  (lambda (l)
    (cond
     ((null? l) '())
     (else
      (cons (car (cdr (car l))) (right-elems (cdr l)))))))

;; Convert quote list of strings to list of ints
(define los-to-loi
  (lambda (ql)
    (map string->number ql)))

;; Return a list of the absolute differences of two lists of numbers
(define abs-diff-of-lists
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) '())
     (else
      (cons (absolute-error (car l1) (car l2)) (abs-diff-of-lists (cdr l1) (cdr l2)))))))

;; ==== Main program ====
;;
;; Read data into 'data variable
(define data
  (conv-to-lolos
   (read-input-file "full.dat")))

;; Convert data
(define data-l
  (left-elems data))

(define data-r
  (right-elems data))

(define data-l-sort
  (sort (los-to-loi data-l) <))

(define data-r-sort
  (sort (los-to-loi data-r) <))

;; Result

(print (sum (abs-diff-of-lists data-l-sort data-r-sort)))
