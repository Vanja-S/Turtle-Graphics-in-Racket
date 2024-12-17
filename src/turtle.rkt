#lang racket

(provide (all-defined-out))

;; Turtle structre: position (list of x and y) and angle (in radians)
(define-struct turtle (pos angle))

;; Initial state starts at (0, 0), facing to the right (0 radians)
(define initial-turtle (make-turtle '(0 0) 0))

;; move: Moves the turtle forward without drawing
(define (move turtle distance)
  (let* ((x (car (turtle-pos turtle)))
         (y (cadr (turtle-pos turtle)))
         (angle (turtle-angle turtle))
         (new-x (+ x (* distance (cos angle))))
         (new-y (+ y (* distance (sin angle)))))
    (make-turtle (list new-x new-y) angle)))

;; turn: Turns the turtle by a specified number of degrees
(define (turn turtle degrees)
  (let* ((radians (* degrees (/ pi 180))))
    (make-turtle (turtle-pos turtle) (+ (turtle-angle turtle) radians))))

;; draw: Moves the turtle forward and records the line segment
(define (draw turtle distance)
  (let* ((x (car (turtle-pos turtle)))
         (y (cadr (turtle-pos turtle)))
         (angle (turtle-angle turtle))
         (new-x (+ x (* distance (cos angle))))
         (new-y (+ y (* distance (sin angle)))))
    (list (make-turtle (list new-x new-y) angle)
          (list (list x y) (list new-x new-y)))))

;; procedural-command: Wraps a turtle command into a function
(define (procedural-command command turtle)
  (match command
    ['move (move turtle 100)]
    ['turn (turn turtle 90)]
    ['draw (draw turtle 100)]))