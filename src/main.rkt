#lang racket

(require "turtle.rkt" "renderer.rkt")

;; Define procedural commands to draw a square
(define commands
  (list
   (lambda (state) (draw (make-turtle (car state) (cadr state)) 100))
   (lambda (state) (turn (make-turtle (car state) (cadr state)) 90))
   (lambda (state) (draw (make-turtle (car state) (cadr state)) 100))
   (lambda (state) (turn (make-turtle (car state) (cadr state)) 90))
   (lambda (state) (draw (make-turtle (car state) (cadr state)) 100))
   (lambda (state) (turn (make-turtle (car state) (cadr state)) 90))
   (lambda (state) (draw (make-turtle (car state) (cadr state)) 100))))

;; Render procedurally
(render-procedural commands)
