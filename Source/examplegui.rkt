#lang racket
(require racket/gui/base)
(require (file "classes.rkt"))

(define slime_sample (make_object 250 200 0 0))

;(define x1 250)
;(define y1 0)
;(define x2 250)
;(define y2 0)
;(define xb 250)
;(define yb 300)
(define frame (new frame% [label "Frame"] [width 1000] [height 500]))


(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-event event)
      ;(send msg set-label "Canvas mouse")
      1
      )
    ; Define overriding method to handle keyboard events
    (define/override (on-char event)
      ;(send msg set-label "Canvas keyboard")
      (cond
        [(eq? (send event get-key-code) 'left) ;(set! x1 (remainder (- x1 4) 500))]
         ((slime_sample 'set_pos) (- (car (slime_sample 'get_pos)) 8) (cdr (slime_sample 'get_pos)))]
        ;((obj 'set_pos) x y) sets x y coords (obj 'get_pos) returns a cons cell with '(x.y) coords (window boundaries are checked in the set_pos function)
        
        [(eq? (send event get-key-code) 'right) ;(set! x1 (remainder (+ x1 4) 500))]
         ((slime_sample 'set_pos) (+ (car (slime_sample 'get_pos)) 8) (cdr (slime_sample 'get_pos)))]
        [(eq? (send event get-key-code) #\space) ;(set! y1 (remainder (+ y1 4) 500))] ;;; changing jump to y - 4 because coordinate system is inverted (0 at top)
         ((slime_sample 'set_pos) (car (slime_sample 'get_pos)) (- (cdr (slime_sample 'get_pos)) 8))]
      )  
      ;(define (char-label (send event get-key-code)))
    )
    ; Call the superclass init, passing on all init args
    (super-new)))

(define bitmap1 (make-object bitmap% 136 68))
(send bitmap1 load-file "greenslime.png")

(define canvas (new my-canvas% [parent frame]
                    [paint-callback
                     (lambda (c dc)
                       (send dc clear)
                       ;(send dc draw-rectangle 0 0 100 30)
                       (send dc draw-bitmap bitmap1 (car (slime_sample 'get_pos)) (cdr (slime_sample 'get_pos)));x1 y1)
                       ;(send dc draw-line x1 250 x1 250)
                       )]))
(send canvas set-canvas-background (make-object color% 0 0 155 .99))
(send frame show #t)


(define (loop)
  (send canvas set-canvas-background (make-object color% 0 0 155 .99))
  (send canvas on-paint)
  ;  (set! x1 (remainder (+ x1 1) 500))
  (sleep/yield 0.002)
  (loop))

(loop)