#lang racket

;this provide condition makes it so you can require this file
;in anther file and all of these definitions will be usable.
(provide (all-defined-out))

;for boundary checking
(define windowXbound 500)
(define windowYbound 500)

(define (make_object pos_x pos_y vel_x vel_y)
  (define (dispatch op)
    (cond ((eq? op 'get_pos) (cons pos_x pos_y))
          ((eq? op 'get_vel) (cons vel_x vel_y))
          ((eq? op 'set_pos) (lambda (x y)
                               (if (and (> x 0) (< x windowXbound))
                                   (set! pos_x x)
                                   (values));does nothing
                               (if (and (> y 0) (< y windowYbound))
                                   (set! pos_y y)
                                   (values))))
          ((eq? op 'set_vel) (lambda (x y)
                               (set! vel_x x)
                               (set! vel_y y)))
          ((eq? op 'get_accel) -10)
          (else (error "Unknown op: " op))))
  dispatch)
