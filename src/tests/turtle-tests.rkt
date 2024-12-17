#lang racket
(require "../turtle.rkt")

;; Start with the initial turtle
(define t1 initial-turtle)
(turtle-state t1)

;; Move the turtle forward by 100 units
(define t2 (move t1 100))
(turtle-state t2)

;; Turn the turtle 90 degrees to the left
(define t3 (turn t2 90))
(turtle-state t3)

;; Draw a line 50 units forward
(define result (draw t3 50))
(define t4 (car result))    ; Extract the new turtle state
(define line (cadr result)) ; Extract the line segment

;; Print results
(turtle-state t4)
(printf "Line drawn: ~a\n" line)
