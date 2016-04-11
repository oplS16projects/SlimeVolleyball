#lang racket
(require racket/gui/base)
(require (file "classes.rkt"))

(define frame (new frame% [label "Slime Volleyball"] [width windowXbound] [height windowYbound]))

(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-event event)
      ;(send msg set-label "Canvas mouse")
      1
      )
    ; Define overriding method to handle keyboard events
    (define/override (on-char event)
      (cond
        [(eq? (send event get-key-code) 'left)
         ((Slime1 'set_pos) (- (car (Slime1 'get_pos)) 4) (cdr (Slime1 'get_pos)))]
        [(eq? (send event get-key-code) 'right)
         ((Slime1 'set_pos) (+ (car (Slime1 'get_pos)) 4) (cdr (Slime1 'get_pos)))]
        [(eq? (send event get-key-code) #\space)
         (if (= windowYbound (cdr (Slime1 'get_pos))) ((Slime1 'set_vel) 0 -70) 0)]
      )  
      ;(define (char-label (send event get-key-code)))
    )
    ; Call the superclass init, passing on all init args
    (super-new)))

(define bitmap1 (make-object bitmap% 100 100))
(send bitmap1 load-file "greenslime.png")

(define mycanvas (new my-canvas%
                    [parent frame]
                    [paint-callback
                     (lambda (canvas dc)
                       
                       (send dc set-pen "white" 4 'solid)
                       ;(send dc set-background (make-object color% 0 0 155 .99))
                       (send dc clear)
                       (send dc draw-line (/ windowXbound 2) (- windowYbound 20) (/ windowXbound 2) windowYbound)
                       (send dc draw-bitmap bitmap1 (car (Slime1 'get_pos)) (cdr (Slime1 'get_pos)))
                       )]))
(send (send mycanvas get-dc) set-background (make-object color% 0 0 155 .99))
(send frame show #t)


(define (loop)
  (Slime1 'move) ;moves the slime based on velocity and acceleration
  ;(send mycanvas set-canvas-background (make-object color% 0 0 190 .9))
  (send mycanvas on-paint)
  (sleep/yield 0.02)
  (loop))

;(send mycanvas set-canvas-background (make-object color% 0 0 190 .9))
(loop)