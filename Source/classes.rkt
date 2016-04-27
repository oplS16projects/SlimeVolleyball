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
          ((eq? op 'net) (if (and (or (and (<= (+ pos_x radius) (- (/ windowXbound 2) 4))
                                            (> (+ pos_x vel_x radius) (- (/ windowXbound 2) 4)))
                                       (and (>= (+ pos_x radius) (+ (/ windowXbound 2) 4))
                                            (< (+ pos_x vel_x radius) (+ (/ windowXbound 2) 4))))
                                   (>= (+ pos_y vel_y radius) (- windowYbound 70))) 
                              (begin
                                (set! pos_x (- (/ windowXbound 2) (- (/ windowXbound 2) pos_x)))
                                (set! vel_x (- vel_x)))
                              (if (and  (< pos_x (- (/ windowXbound 2) 4))
                                           (> pos_x (+ (/ windowXbound 2) 4)) (<= pos_y (- windowYbound 70)) (> (+ pos_y vel_y) (- windowYbound 70)))
                                           ;(and
                                       ;(and (>= (+ pos_x vel_x) (- (/ windowXbound 2) 4))
                                        ;    (<= (+ pos_x vel_x) (+ (/ windowXbound 2) 4))))
                                       ;(= (+ pos_y vel_y) (- windowYbound 70)))
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















(define (calcXWhenBallBelow ylimit)
  (define temp (make_object (car (ball 'get_pos)) (cdr (ball 'get_pos)) (car (ball 'get_vel)) (cdr (ball 'get_vel)) (ball 'get_rad) 0 windowXbound (- windowYbound 18) #f))
  (define (helper count bll ylim)
    (bll 'move)
    ;(bll 'collisions)
    (bll 'net)
    (bll 'wall)
    (if (<= count 0)
         (car (bll 'get_pos))
         (helper (- count 1) bll ylim)))
  (+ (ball 'get_rad)
     (helper (countTillBelow (cdr (ball 'get_pos)) (cdr (ball 'get_vel)) ylimit) temp ylimit)))
        
(define (countTillBelow y vy limit)
  (define (helper count y vy limit)
    ;(display y)
    ;(display limit)
    (if (> y limit)
        count
        (helper (+ 1 count) (+ y (+ vy 1)) (+ vy 1) limit)))
  (helper 0 y vy limit))


(define (Ai slime)
  (if (slime 'get_jump)
      ((slime 'set_jump) #f)
      'done
      )
  (if (equal? (cdr (ball 'get_pos)) (- windowYbound 18))
      'done
      (let ((landing (calcXWhenBallBelow (- windowYbound 68)))) 
        (if (> landing (/ windowXbound 2))
            (cond
              ((and (< (+ (car (slime 'get_pos)) (slime 'get_rad) ) landing) (> (+ (car (slime 'get_pos)) (slime 'get_rad) -45) landing)) (begin (display "here") ((slime 'set_jump) #t) ((slime 'set_vel (car (slime 'get_vel) -18)))))
              ((< (+ (car (slime 'get_pos)) (slime 'get_rad) -5) landing) ((slime 'set_vel) 6 (cdr (slime 'get_vel))))
              ((> (+ (car (slime 'get_pos)) (slime 'get_rad) -45) landing) ((slime 'set_vel) -6 (cdr (slime 'get_vel))))
              (else (begin ((slime 'set_vel) 0 (cdr (slime 'get_vel))) (if (> (cdr (ball 'get_pos)) (- windowYbound 100)) ((slime 'set_jump) #t) 'done))))
            (cond
              ((< (+ (car (slime 'get_pos)) (slime 'get_rad)) (* windowXbound 3/4)) ((slime 'set_vel) 6 (cdr (slime 'get_vel))))
              ((> (+ (car (slime 'get_pos)) (slime 'get_rad) (slime 'get_rad)) (* windowXbound 3/4))) ((slime 'set_vel) -6 (cdr (slime 'get_vel)))
              (else ((slime 'set_vel) 0 (cdr (slime 'get_vel)))))))))



