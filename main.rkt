#lang racket
(require "identicon.rkt")

(define output-dir "output")

(define (main)
  (command-line #:args (input-string)
                (unless (directory-exists? output-dir)
                  (make-directory output-dir))
                (identicon input-string output-dir)))

(main)
