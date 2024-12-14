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

;; Tail recursive length function
(define length-iter
  (lambda (lat res)
    (if (null? lat)
        res
        (length-iter (cdr lat)
                     (add1 res)))))

(define (list-of-strings-split lat sep)
  (define len (length-iter lat 0))
  (define vec-tmp (make-vector len))
  (let loop ((i 0) (limit len))
    (when (< i limit)
      (vector-set! vec-tmp i (string-split (list-ref lat i) sep))
      (loop (add1 i) limit)))
  vec-tmp)

;; Remove last element of list
(define pop-last
  (lambda (lat)
    (reverse (cdr (reverse lat)))))

;; Take the first x elements from a list of atoms
(define first-x
  (lambda (lat x)
    (let ((tmp (length-iter lat 0)))
      (reverse (list-tail (reverse lat) (- tmp x))))))

(define take-x first-x)
