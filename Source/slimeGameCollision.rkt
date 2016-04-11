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
    (define/override (on-char event)(begin
                                      (print (send event get-key-code))
                                      (display "\n")
      (cond
        [(eq? (send event get-key-code) 'left)
         ((Slime1 'set_vel) (if (= 0 (car (Slime1 'get_vel))) -4 0) (cdr (Slime1 'get_vel)) )]
        [(eq? (send event get-key-code) 'right)
         ((Slime1 'set_vel) (if (= 0 (car (Slime1 'get_vel))) 4 0) (cdr (Slime1 'get_vel)) )]
        [(eq? (send event get-key-code) #\space)
         (if (= windowYbound (cdr (Slime1 'get_pos))) ((Slime1 'set_vel) (car (Slime1 'get_vel)) -70) (values))]
        [(eq? (send event get-key-code) 'release)
         (cond ((eq? (send event get-key-release-code) 'left) ((Slime1 'set_vel) 0 (cdr (Slime1 'get_vel))))
               ((eq? (send event get-key-release-code) 'right) ((Slime1 'set_vel) 0 (cdr (Slime1 'get_vel)))))]
               
      )  )
      ;(define (char-label (send event get-key-code)))
    )
    ; Call the superclass init, passing on all init args
    (super-new)))

(define Slime1-img (make-object bitmap% 100 100))
(send Slime1-img load-file "greenslime.png")

(define ball-img (make-object bitmap% 100 100))
(send ball-img load-file "circle.jpg")

(define mycanvas (new my-canvas%
                    [parent frame]
                    [paint-callback
                     (lambda (canvas dc)
                       
                       (send dc set-pen "white" 4 'solid)
                       ;(send dc set-background (make-object color% 0 0 155 .99))
                       (send dc clear)
                       (send dc draw-line (/ windowXbound 2) (- windowYbound 20) (/ windowXbound 2) windowYbound)
                       (send dc draw-bitmap Slime1-img (car (Slime1 'get_pos)) (cdr (Slime1 'get_pos)))
                       (send dc draw-bitmap ball-img (car (ball 'get_pos)) (cdr (ball 'get_pos)))
                       )]))
(send (send mycanvas get-dc) set-background (make-object color% 0 0 155 .99))
(send frame show #t)


(define (loop)
  (Slime1 'move) ;moves the slime based on velocity and acceleration
  (ball 'move)
  ((ball 'collision) Slime1)
  (send mycanvas on-paint)
  (sleep/yield 0.02)
  (loop))

(loop)