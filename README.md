# Turtle Graphics in Racket

This project implements a turtle graphics DSL in Racket for procedural drawing.
It demonstrates concepts like recursion, higher-order functions, and state management.

## Setup

- Define your turtle commands in the `main.rkt` file.
- End the `main.rkt` with `(render-procedural commands)`
- Run `main.rkt` using the Racket IDE or terminal.

## Examples

The following commands will draw a simple square:

```rkt
;; Define procedural commands to draw a square
(define commands
  (list
   (lambda (state) 
     (draw (make-turtle (car state) (cadr state)) 100))
   (lambda (state) 
     (list (turn (make-turtle (car state) (cadr state)) 90) #f))
   (lambda (state) 
     (draw (make-turtle (car state) (cadr state)) 100))
   (lambda (state) 
     (list (turn (make-turtle (car state) (cadr state)) 90) #f))
   (lambda (state) 
     (draw (make-turtle (car state) (cadr state)) 100))
   (lambda (state) 
     (list (turn (make-turtle (car state) (cadr state)) 90) #f))
   (lambda (state) 
     (draw (make-turtle (car state) (cadr state)) 100))))
```
