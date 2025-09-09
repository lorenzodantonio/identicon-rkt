#lang racket

(provide svg-rect
         svg-content)

(provide svg-rect
         svg-content)

(define (svg-rect x y width height color)
  (let ([r (vector-ref color 0)]
        [g (vector-ref color 1)]
        [b (vector-ref color 2)])
    (format "<rect x='~a' y='~a' width='~a' height='~a' fill='rgb(~a,~a,~a)'/>"
            x
            y
            width
            height
            r
            g
            b)))

(define (svg-content width height body)
  (format "<svg version='1.1' xmlns='http://www.w3.org/2000/svg' width='~a' height='~a'>\n~a\n</svg>"
          width
          height
          body))
