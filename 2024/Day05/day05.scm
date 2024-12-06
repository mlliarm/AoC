;; Day 05 Dec. 2024
;; Mi. Lia.

(load "../util/io.scm")
(import srfi-69)
(import srfi-1)



;; ================================== Main program ==============================================
;;
;; Input data as lolos
(define data-test
   (read-input-file "test.dat"))

(define data-full
   (read-input-file "full.dat"))


(define get-volos
  (lambda (lat)
      (list-of-strings-split lat "|,")))

(define get-lolos
  (lambda (lat)
    (vector->list (get-volos lat))))

(define data-test-lolos
  (get-lolos data-test))

(define data-full-lolos
  (get-lolos data-full))

(define page-updates
  (lambda (lat)
    (remove (lambda (x) (< (length x) 3)) lat)))

(define rules
  (lambda (lat)
    (remove (lambda (x) (not (< (length x) 3))) lat)))

(define rules-test
  (rules data-test-lolos))

(define page-updates-test
  (page-updates data-test-lolos))
