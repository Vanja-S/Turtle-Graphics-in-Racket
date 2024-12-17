#lang racket

(provide (all-defined-out))

(require racket/gui "turtle.rkt")

;; render-procedural: Renders a list of turtle commands step by step with animation
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
            (send dc set-pen "black" 2 'solid)
            (for-each
             (lambda (line)
               (define x1 (+ 400 (car (car line))))
               (define y1 (+ 400 (- (cadr (car line)))))
               (define x2 (+ 400 (car (cadr line))))
               (define y2 (+ 400 (- (cadr (cadr line)))))
               (send dc draw-line x1 y1 x2 y2))
             drawn-lines)
            
            ;; Draw the turtle
            (define tx (+ 400 (car current-pos)))
            (define ty (+ 400 (- (cadr current-pos))))
            (send dc set-pen "red" 5 'solid)
            (send dc draw-ellipse (- tx 3) (- ty 3) 6 6))]))

  ;; Initialize state
  (define drawn-lines '())
  (define current-pos '(0 0))
  (define current-angle 0)

  ;; Helper function to refresh the canvas
  (define (refresh-canvas)
    (send canvas refresh)
    (sleep/yield 0.2)) ;; Increased delay for better visibility

  ;; Show the frame first (empty window)
  (send frame show #t)

  ;; Wait a moment to show the empty window
  (sleep 0.5)

  ;; Execute commands step-by-step with animation
  (for/fold ([state (list current-pos current-angle)])
            ([command commands])
    ;; Process each command with the current state
    (define result (command state))
    ;; Handle different result types
    (let* ((new-pos (if (pair? (car result))
                        (car result)
                        (car result)))
           (line (if (and (pair? result) (cadr result))
                     (cadr result)
                     #f)))
      (when line
        (set! drawn-lines (cons line drawn-lines)))
      (set! current-pos (turtle-pos new-pos))
      (set! current-angle (turtle-angle new-pos))
      (refresh-canvas)
      (list current-pos current-angle)))

  ;; Keep the window open
  (send frame show #t))