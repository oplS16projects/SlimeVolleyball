#lang racket
(require racket/gui/base)
(require (file "classes.rkt"))

(define frame (new frame% [label "Frame"] [width windowXbound] [height windowYbound]))

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
         ((Slime1 'set_vel) 0 -70)]
        [(eq? (send event get-key-code) 'a)
         ((Slime2 'set_pos) (- (car (Slime2 'get_pos)) 4) (cdr (Slime2 'get_pos)))]
        [(eq? (send event get-key-code) 'd)
         ((Slime2 'set_pos) (+ (car (Slime2 'get_pos)) 4) (cdr (Slime2 'get_pos)))]
        [(eq? (send event get-key-code) 'w)
         ((Slime2 'set_vel) 0 -70)]
      )  
      ;(define (char-label (send event get-key-code)))
    )
    ; Call the superclass init, passing on all init args
    (super-new)))

(define bitmap1 (make-object bitmap% 100 100))
(send bitmap1 load-file "semicircle.jpg")
(define bitmap2 (make-object bitmap% 100 100))
(send bitmap2 load-file "semicircle.jpg")

(define canvas (new my-canvas% [parent frame]
                    [paint-callback
                     (lambda (c dc)
                       
                       (send dc set-pen "red" 4 'solid)
                       (send dc clear)
                       (send dc draw-bitmap bitmap1 (car (Slime1 'get_pos)) (cdr (Slime1 'get_pos)))
                       (send dc draw-bitmap bitmap1 (car (Slime2 'get_pos)) (cdr (Slime2 'get_pos)))

                       )]))
(send frame show #t)


(define (loop)
  (Slime1 'move) ;moves the slime based on velocity and acceleration
  (Slime2 'move)
  (send canvas on-paint)
  (sleep/yield 0.02)
  (loop))

(loop)