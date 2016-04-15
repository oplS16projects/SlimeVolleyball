#lang racket
(require racket/gui/base)
(require (file "classes.rkt"))


(define frame (new frame% [label "Slime Volleyball"] [width windowXbound] [height (+ windowYbound 100)]))
(define bitmap1 (make-object bitmap% 100 100))
(send bitmap1 load-file "greenslime.png")
(define bitmap2 (make-object bitmap% 100 100))
(send bitmap2 load-file "redslime.png")

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
        [(eq? (send event get-key-code) 'up)
         (if (= (- windowYbound 68) (cdr (Slime1 'get_pos))) ((Slime1 'set_vel) (car (Slime1 'get_vel)) -35) (values))]
        [(eq? (send event get-key-code) 'release)
         (cond ((eq? (send event get-key-release-code) 'left) ((Slime1 'set_vel) 0 (cdr (Slime1 'get_vel))) )
               ((eq? (send event get-key-release-code) 'right) ((Slime1 'set_vel) 0 (cdr (Slime1 'get_vel))) )
               ((eq? (send event get-key-release-code) #\a) ((Slime2 'set_vel) 0 (cdr (Slime2 'get_vel))) )
               ((eq? (send event get-key-release-code) #\d) ((Slime2 'set_vel) 0 (cdr (Slime2 'get_vel))) ))]

        [(eq? (send event get-key-code) #\a)
         ((Slime2 'set_vel) (if (= 0 (car (Slime2 'get_vel))) -4 0) (cdr (Slime2 'get_vel)) )]
        [(eq? (send event get-key-code) #\d)
         ((Slime2 'set_vel) (if (= 0 (car (Slime2 'get_vel))) 4 0) (cdr (Slime2 'get_vel)) )]
        [(eq? (send event get-key-code) #\w)
         (if (= (- windowYbound 68) (cdr (Slime2 'get_pos))) ((Slime2 'set_vel) (car (Slime2 'get_vel)) -35) (values))]
      )  )
      ;(define (char-label (send event get-key-code)))
    )
    ; Call the superclass init, passing on all init args
    (super-new)))

(define mycanvas (new my-canvas%
                    [parent frame]
                    [paint-callback
                     (lambda (canvas dc)
                       
                       
                       ;(send dc set-background (make-object color% 0 0 155 .99))
                       
                       (send dc clear)


                       (send dc set-pen (make-object color% 0 0 0 .99) 3 'solid)
                       (send dc set-brush (make-object color% 0 0 0 0) 'solid)
                       
                       
                       (send dc set-pen (make-object color% 112 138 144 .99) 1 'solid)
                       (send dc set-brush (make-object color% 112 138 144 .99) 'solid)
                       (send dc draw-rectangle 0 windowYbound windowXbound (+ windowYbound 100))
                       (send dc set-pen "white" 1 'solid)
                       (send dc set-brush "white" 'solid)
                       (send dc draw-rectangle (- (/ windowXbound 2) 3) (- windowYbound 70) 6 70)
                       (send dc draw-bitmap bitmap1 (car (Slime1 'get_pos)) (cdr (Slime1 'get_pos)))
                       (send dc draw-bitmap bitmap2 (car (Slime2 'get_pos)) (cdr (Slime2 'get_pos)))
                       (send dc set-pen (make-object color% 255 255 0 .99) 1 'solid)
                       (send dc set-brush (make-object color% 255 255 0 .99) 'solid)
                       (send dc draw-ellipse (car (ball 'get_pos)) (cdr (ball 'get_pos)) 36 36))]))
(send (send mycanvas get-dc) set-background (make-object color% 0 0 155 .99))
(send frame show #t)


(define (loop)
  (Slime1 'move) ;moves the slime based on velocity and acceleration
  (Slime2 'move) ;moves the slime based on velocity and acceleration
  (ball 'move)
  (send mycanvas on-paint)
  (sleep/yield 0.02)
  (loop))

(loop)