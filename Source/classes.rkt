#lang racket
(require racket/gui/base)
;this provide condition makes it so you can require this file
;in anther file and all of these definitions will be usable.
(provide (all-defined-out))

;for boundary checking
(define windowXbound 1000)
(define windowYbound 500)
(define slimebot (- windowYbound 68))
(define dx 1000) ;temporary
(define dy 1000) ;temporary

(define (distance obj1 obj2)
  (sqrt (+ (expt (- (+ (car (obj1 'get_pos)) (obj1 'get_rad)) (+ (car (obj2 'get_pos)) (obj2 'get_rad))) 2)
           (expt (- (+ (cdr (obj1 'get_pos)) (obj1 'get_rad)) (+ (cdr (obj2 'get_pos)) (obj2 'get_rad))) 2))))

;left bound and right bound have been added to make it easier to restrict each player to half
;the screen
(define (make_object pos_x pos_y vel_x vel_y radius left_bound right_bound bottom_bound jump)
  (define (dispatch op)
    (cond ((eq? op 'get_pos) (cons pos_x pos_y))
          ((eq? op 'get_vel) (cons vel_x vel_y))
          ((eq? op 'get_rad) radius)
          ((eq? op 'set_jump) (lambda (x) (set! jump x)))
          ((eq? op 'get_jump) jump)
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
                               (if  (< y bottom_bound)
                                   (set! pos_y y)
                                   (if (>= y bottom_bound) (set! pos_y bottom_bound) (values ))))
                             (+ pos_x vel_x) (+ pos_y vel_y)))
         
                            (if (< pos_y bottom_bound) (set! vel_y (+ vel_y 0.8))  (begin (set! pos_y bottom_bound) (if jump (set! vel_y -18) (set! vel_y 0))
                            ))) ;gravity

          ((eq? op 'collision) (lambda (Slime)  (if (<= (distance Slime ball) (+ radius (Slime 'get_rad)))
                                                     (begin (set! vel_y (* -18 (/ (- (+ (cdr (Slime 'get_pos)) (Slime 'get_rad)) (+ (cdr (ball 'get_pos)) (ball 'get_rad))) (distance Slime ball))))
                                                            (set! vel_x (* -18 (/ (- (+ (car (Slime 'get_pos)) (Slime 'get_rad)) (+ (car (ball 'get_pos)) (ball 'get_rad))) (distance Slime ball)))))
                                                     #f)))
          ((eq? op 'wall) (if (< (+ pos_x vel_x) left_bound)
                              (begin
                                (set! vel_x (- vel_x))
                                (set! pos_x left_bound))
                                (if (> (+ pos_x vel_x) (- right_bound 36))
                                    (begin
                                      (set! vel_x (- vel_x))
                                      (set! pos_x (- right_bound 36)))
                                    (values))))
          ((eq? op 'net) (if (and (or (and (< pos_x (- (/ windowXbound 2) 1))
                                            (> (+ pos_x vel_x) (+ (/ windowXbound 2) 1)))
                                       (and (> pos_x (+ (/ windowXbound 2) 1))
                                            (< (+ pos_x vel_x) (- (/ windowXbound 2) 1))))
                                   (>= (+ pos_y vel_y) (- slimebot 70))) 
                              (begin
                                (set! pos_x (/ windowXbound 2))
                                (set! vel_x (- vel_x)))
                              (if (and (and (or (< pos_x (- (/ windowXbound 2) 1))
                                           (> pos_x (+ (/ windowXbound 2) 1)))
                                       (and (>= (+ pos_x vel_x) (- (/ windowXbound 2) 1))
                                            (<= (+ pos_x vel_x) (+ (/ windowXbound 2) 1))))
                                       (eqv? (+ pos_y vel_y) (- slimebot 70)))
                                  (set! vel_y (- vel_y))
                                  (values))))
                                
                             
          (else (error "Unknown op: " op))))
  dispatch)



;defines ball as an object with a radius of 30 px and starting position above player 1
;(define ball (make_object (+ (/ windowXbound 4) 50) (/ windowYbound 4) 0 0 18 0 windowXbound (- windowYbound 36)))
;slimes are defined as circular objects with radius 100, they are placed at the bottom of the viewing window,
;so the bottom half of the sphere gets clipped (this means when you jump there is actually a circle moving
;rather than a half circle, but the ball will never hit the lower half of the circle and this is easier to implement.
(define Slime1 (make_object (- (/ windowXbound 4) 68) (- windowYbound 68) 0 0 68 0 (- (/ windowXbound 2) 136) (- windowYbound 68) #f))
(define Slime2 (make_object (- (* 3(/ windowXbound 4)) 68);pos_x pos_y vel_x vel_y radius left_bound right_bound bottom_bound jump
                            (- windowYbound 68) ;pos_y
                            0;velx
                            0;vely
                            68
                            (+ (/ windowXbound 2) 2)
                            (- windowXbound 136)
                            (- windowYbound 68)
                            #f))

(define ball (make_object (- (+ (car (Slime1 'get_pos)) (Slime1 'get_rad)) 18) (/ windowYbound 4) 0 0 18 0 windowXbound (- windowYbound 18) #f))
