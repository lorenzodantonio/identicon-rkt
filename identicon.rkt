#lang racket

(require file/md5)
(require "svg.rkt")

(provide identicon)

(define unit-len 25)
(define image-len (* unit-len 5))

(define (with-index enumerable index)
  (if (null? enumerable)
      '()
      (cons (list (car enumerable) index)
            (with-index (cdr enumerable) (+ 1 index)))))

(define (chunk enum step)
  (if (< (length enum) step)
      '()
      (cons (take enum step)
            (chunk (drop enum step) step))))

(define (hash-input string)
  (bytes->list (md5 string)))

(define (pick-color hash-list)
  (define (normalize c) (+ 80 (modulo c 176)))
  (list->vector (map normalize (take hash-list 3))))

(define (mirror-h row)
  (let* (
    [one (first row)]
    [two (second row)]
    [three (third row)])
    (list one two three two one)))

(define (build-grid hash-list)
  (let* ([lst (chunk hash-list 3)]
         [lst (map mirror-h lst)]
         [lst (flatten lst)]
         [indexed (with-index lst 0)])
    (filter (lambda (x) (even? (first x))) indexed)))

(define (build-svg grid color)
    (svg-content image-len image-len
      (apply string-append
        (map (lambda (p)
              (svg-rect (* unit-len (modulo (second p) 5))
                        (* unit-len (quotient (second p) 5))
                        unit-len unit-len
                        color))
            grid))))

(define (save-to-file svg-content file-name output-dir)
  (let ([img-path (build-path output-dir (string-append file-name ".svg"))])
    (call-with-output-file* img-path
      (lambda (out) (display svg-content out))
      #:exists 'truncate/replace)))

(define (identicon string output-dir)
  (let* ([img (hash-input string)]
         [color (pick-color img)]
         [img (build-grid img)]
         [svg (build-svg img color)])

    (save-to-file svg string output-dir)))
