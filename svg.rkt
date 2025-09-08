#lang racket

(provide svg-rect svg-content)

(define (svg-rect x y width height color)
  (let ([r (vector-ref color 0)]
        [g (vector-ref color 1)]
        [b (vector-ref color 2)])
    (string-append
     "<rect x='" (number->string x)
     "' y='" (number->string y)
     "' width='" (number->string width)
     "' height='" (number->string height)
     "' fill='rgb(" (number->string r) "," (number->string g) "," (number->string b) ")'/>")))

(define (svg-content width height body)
  (string-append
   "<svg version='1.1' xmlns='http://www.w3.org/2000/svg' width='" (number->string width)
   "' height='" (number->string height) "'>\n"
   body
   "\n</svg>"))
