#lang racket

(provide render-procedural)

(require racket/gui)

;; render-procedural: Renders a list of turtle commands step by step
(define (render-procedural commands)
  ;; Window and canvas setup
  (define frame
    (new frame%
         [label "Procedural Turtle Graphics"]
         [width 800]
         [height 800]))

  (define canvas
    (new canvas%
         [parent frame]
         [paint-callback
          (lambda (canvas dc)
            ;; Draw all the lines in drawn-lines
            (send dc set-pen "black" 2 'solid)
            (for-each
             (lambda (line)
               (define x1 (+ 400 (car (car line))))
               (define y1 (+ 400 (- (cadr (car line)))))
               (define x2 (+ 400 (car (cadr line))))
               (define y2 (+ 400 (- (cadr (cadr line)))))
               (send dc draw-line x1 y1 x2 y2))
             drawn-lines)
            ;; Draw turtle's current position as a red dot
            (define tx (+ 400 (car current-pos)))
            (define ty (+ 400 (- (cadr current-pos))))
            (send dc set-pen "red" 5 'solid)
            (send dc draw-ellipse (- tx 3) (- ty 3) 6 6))]))

  ;; Initialize state
  (define drawn-lines '()) ; List of lines to be drawn
  (define current-pos '(0 0)) ; Current position of the turtle
  (define current-angle 0) ; Current turtle angle (radians)

  ;; Helper function to refresh the canvas
  (define (refresh-canvas)
    (send canvas refresh)
    (sleep/yield 0.2)) ; Delay for animation (0.2 seconds)

  ;; Execute commands step-by-step
  (for-each
   (lambda (command)
     (define result (command (list current-pos current-angle)))
     (if (pair? result)
         (let ((new-pos (car result))
               (line (cadr result)))
           (set! drawn-lines (cons line drawn-lines)) ; Add new line to drawn-lines
           (set! current-pos new-pos)
           (set! current-angle (cadr result)))
         ;; Update only the position and angle
         (let ((new-pos (car result))
               (new-angle (cadr result)))
           (set! current-pos new-pos)
           (set! current-angle new-angle)))
     (refresh-canvas))) ; Redraw the canvas after each command

  ;; Show the frame
  (send frame show #t))
