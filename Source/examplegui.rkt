#lang racket
(require racket/gui/base)

(define x1 250)
(define y1 0)
(define x2 250)
(define y2 0)
(define xb 250)
(define yb 300)
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
        [(eq? (send event get-key-code) 'left) (set! x1 (remainder (- x1 4) 500))]
        [(eq? (send event get-key-code) 'right) (set! x1 (remainder (+ x1 4) 500))]
        [(eq? (send event get-key-code) #\space) (set! y1 (remainder (+ y1 4) 500))]
      )  
      ;(define (char-label (send event get-key-code)))
    )
    ; Call the superclass init, passing on all init args
    (super-new)))

(define bitmap1 (make-object bitmap% 200 200))
(send bitmap1 load-file "semicircle.png")

(define canvas (new my-canvas% [parent frame]
                    [paint-callback
                     (lambda (c dc)
                       
                       (send dc set-pen "red" 4 'solid)
                       (send dc clear)
                       (send dc draw-bitmap bitmap1 x1 y1)
                       ;(send dc draw-line x1 250 x1 250)
                       )]))
(send frame show #t)


(define (loop)
  (send canvas on-paint)
  ;  (set! x1 (remainder (+ x1 1) 500))
  (sleep/yield 0.02)
  (loop))

(loop)