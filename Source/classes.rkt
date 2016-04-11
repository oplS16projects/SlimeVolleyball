#lang racket
(require racket/gui/base)
;this provide condition makes it so you can require this file
;in anther file and all of these definitions will be usable.
(provide (all-defined-out))

;for boundary checking
(define windowXbound 1000)
(define windowYbound 500)
(define slimebot (- windowYbound 68))
(define bitmap1 (make-object bitmap% 100 100))
(send bitmap1 load-file "greenslime.png")
(define bitmap2 (make-object bitmap% 100 100))
(send bitmap2 load-file "redslime.png")

;left bound and right bound have been added to make it easier to restrict each player to half
;the screen
(define (make_object pos_x pos_y vel_x vel_y radius left_bound right_bound bottom_bound)
  (define (dispatch op)
    (cond ((eq? op 'get_pos) (cons pos_x pos_y))
          ((eq? op 'get_vel) (cons vel_x vel_y))
          ((eq? op 'set_pos) (lambda (x y)
                               (if (and (> x left_bound) (< x right_bound))
                                   (set! pos_x x)
                                   (values));does nothing
                               (if (and (> y 0) (< y bottom_bound))
                                   (set! pos_y y)
                                   (values))))
                                  ; (if (< y windowYbound) (set! pos_y windowYbound) (values )))))
          ((eq? op 'set_vel) (lambda (x y)
                               (set! vel_x x)
                               (set! vel_y y)))
          ((eq? op 'move) (begin
                            ((lambda (x y)
                               (if (and (> x left_bound) (< x right_bound))
                                   (set! pos_x x)
                                   (values));does nothing
                               (if (and (> y 0) (< y bottom_bound))
                                   (set! pos_y y)
                                   (if (>= y bottom_bound) (set! pos_y bottom_bound) (values ))))
                             (+ pos_x vel_x) (+ pos_y vel_y)))
                             
                            ;(if (and (>= windowYbound (+ pos_y vel_y)) (<= 0 (+ pos_x vel_x)))
                             ;   (+ pos_y vel_y)
                              ;  (+ pos_y 0))
                            ;(if (and (>= windowXbound (+ pos_x vel_x)) (<= 0 (+ pos_x vel_x)))
                             ;   (+ pos_x vel_x)
                              ;  (+ pos_x 0)))
                            
                            (if (< pos_y bottom_bound) (set! vel_y (+ vel_y 4)) (set! vel_y 0)
                            )) ;gravity
          (else (error "Unknown op: " op))))  dispatch)

;defines ball as an object with a radius of 30 px and starting position above player 1
(define ball (make_object (/ windowXbound 4) (/ windowYbound 4) 0 0 30 0 windowXbound (- windowYbound 36)))
;slimes are defined as circular objects with radius 100, they are placed at the bottom of the viewing window,
;so the bottom half of the sphere gets clipped (this means when you jump there is actually a circle moving
;rather than a half circle, but the ball will never hit the lower half of the circle and this is easier to implement.
(define Slime1 (make_object (/ windowXbound 4) (- windowYbound 200) 0 0 100 0 (- (/ windowXbound 2) 138) slimebot))
(define Slime2 (make_object (* 3(/ windowXbound 4)) windowYbound 0 0 100 (+ (/ windowXbound 2) 2) (- windowXbound 136) slimebot))
