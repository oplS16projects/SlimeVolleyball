#lang racket
(require racket/gui/base)
(require (file "classes.rkt"))
(define player1score 0)
(define player2score 0)
(define lastToscore #f) ;false if player 1, true if player 2

(define frame (new frame% [label "Slime Volleyball"] [width windowXbound] [height (+ windowYbound 100)]))
(define dialog (instantiate dialog% ("Select Game Mode")))
(define beginpanel (new horizontal-panel% [parent dialog] [min-width 200] [min-height 100] [alignment '(center center)]))
(new button% [parent beginpanel]
             [label "One Player"]
             [callback (lambda (button event)
                         (begin (set! oneplayer #t) (send dialog show #f) (send gamecanvas focus) (gameloop)))])
(new button% [parent beginpanel]
             [label "Two Player"]
             [callback (lambda (button event)
                         (begin (set! oneplayer #f) (send dialog show #f) (send gamecanvas focus) (gameloop)))])
(define oneplayer #t)


(define bitmap1 (make-object bitmap% 100 100))
(send bitmap1 load-file "greenslime.png")
(define bitmap2 (make-object bitmap% 100 100))
(send bitmap2 load-file "redslime.png")

;background info:
;each scoreboard outline is top-left located at (x,y) = (20 + 60 * pointval, 20) has inner diameter of 35, and boarder of 4px (not included in diameter).
;this is repeated with the right side, except: (x,y) = (580 - 60 * pointval, 20)
;(send dc draw-rectangle (- (/ windowXbound 2) 3) (- windowYbound 70) 6 70) was used for the center rectangle.
(define background (make-object bitmap% 100 100))
(send background load-file "background.png")
(define game-canvas%
  (class canvas%
    
    ; Define overriding method to handle keyboard events
    (define/override (on-char event)(begin
                                      (print (send event get-key-code))
                                      (display "\n")
      (cond
        [(and (= 0 (car (Slime1 'get_vel))) (eq? (send event get-key-code) #\a ))
         ((Slime1 'set_vel) -6 (cdr (Slime1 'get_vel)) )]
        [(and (= 0 (car (Slime1 'get_vel))) (eq? (send event get-key-code) #\d))
         ((Slime1 'set_vel) 6 (cdr (Slime1 'get_vel)) )]
        [(and (not (Slime1 'get_jump)) (eq? (send event get-key-code) #\w)) ((Slime1 'set_jump) #t)] 
        [(eq? (send event get-key-code) 'release)
         (cond ((eq? (send event get-key-release-code) 'left) ((Slime2 'set_vel) 0 (cdr (Slime2 'get_vel))) )
               ((eq? (send event get-key-release-code) 'right) ((Slime2 'set_vel) 0 (cdr (Slime2 'get_vel))) )
               ((eq? (send event get-key-release-code) #\a) ((Slime1 'set_vel) 0 (cdr (Slime1 'get_vel))) )
               ((eq? (send event get-key-release-code) #\d) ((Slime1 'set_vel) 0 (cdr (Slime1 'get_vel))) )
               ((eq? (send event get-key-release-code) #\w) ((Slime1 'set_jump) #f))
               ((eq? (send event get-key-release-code) 'up) ((Slime2 'set_jump) #f)))]

        [(and (= 0 (car (Slime2 'get_vel))) (eq? (send event get-key-code) 'left))
         ((Slime2 'set_vel) -6 (cdr (Slime2 'get_vel)) )]
        [(and (= 0 (car (Slime2 'get_vel))) (eq? (send event get-key-code) 'right))
         ((Slime2 'set_vel) 6 (cdr (Slime2 'get_vel)) )]
        [(and (not (Slime2 'get_jump)) (eq? (send event get-key-code) 'up)) ((Slime2 'set_jump) #t)] 
        [(and (= (cdr (ball 'get_pos)) (- windowYbound 18)) (eq? (send event get-key-code) #\space))
         (begin ((Slime1 'set_pos) (/ windowXbound 4) (- windowYbound 68)) ((Slime2 'set_pos) (* 3(/ windowXbound 4)) (- windowYbound 68))
                ((ball 'set_vel) 0 0) ((ball 'set_pos) (- (+ (car ((if lastToscore Slime2 Slime1) 'get_pos)) ((if lastToscore Slime2 Slime1) 'get_rad)) 18) (/ windowYbound 4)) (gameloop))]

      )  )
      ;(define (char-label (send event get-key-code)))
    )
    ; Call the superclass init, passing on all init args
    (super-new)))

(define gamecanvas (new game-canvas%
                    [parent frame]
                    [paint-callback
                     (lambda (canvas dc)
                       
                       
                       ;(send dc set-background (make-object color% 0 0 155 .99))
                       
                       (send dc clear)


                       ;(send dc set-pen (make-object color% 0 0 0 .99) 3 'solid)
                       ;(send dc set-brush (make-object color% 0 0 0 0) 'solid)
                       
                       
                       ;(send dc set-pen (make-object color% 112 138 144 .99) 1 'solid)
                       ;(send dc set-brush (make-object color% 112 138 144 .99) 'solid)
                       ;(send dc draw-rectangle 0 windowYbound windowXbound (+ windowYbound 100))
                       ;(send dc set-pen "white" 1 'solid)
                       ;(send dc set-brush "white" 'solid)
                       ;(send dc draw-rectangle (- (/ windowXbound 2) 3) (- windowYbound 70) 6 70)
                       (send dc draw-bitmap background 0 0)
                       (send dc draw-bitmap bitmap1 (car (Slime1 'get_pos)) (cdr (Slime1 'get_pos)))
                       (send dc draw-bitmap bitmap2 (car (Slime2 'get_pos)) (cdr (Slime2 'get_pos)))
                       (send dc set-pen (make-object color% 0 0 0 .99) 9 'solid)
                       (send dc draw-line
                             (+ (car (Slime1 'get_pos)) 114 (* -5 (/ (- (+ (car (Slime1 'get_pos)) (Slime1 'get_rad)) (+ (car (ball 'get_pos)) (ball 'get_rad))) (distance Slime1 ball))))
                             
                             (+ (cdr (Slime1 'get_pos)) 40 (* -5 (/ (- (+ (cdr (Slime1 'get_pos)) (Slime1 'get_rad)) (+ (cdr (ball 'get_pos)) (ball 'get_rad))) (distance Slime1 ball))))
                             
                             (+ (car (Slime1 'get_pos)) 114 (* -5 (/ (- (+ (car (Slime1 'get_pos)) (Slime1 'get_rad)) (+ (car (ball 'get_pos)) (ball 'get_rad))) (distance Slime1 ball))))
                             
                             (+ (cdr (Slime1 'get_pos)) 40 (* -5 (/ (- (+ (cdr (Slime1 'get_pos)) (Slime1 'get_rad)) (+ (cdr (ball 'get_pos)) (ball 'get_rad))) (distance Slime1 ball)))))
                       (send dc draw-line
                             (+ (car (Slime2 'get_pos)) 22 (* -5 (/ (- (+ (car (Slime2 'get_pos)) (Slime2 'get_rad)) (+ (car (ball 'get_pos)) (ball 'get_rad))) (distance Slime2 ball))))
                             
                             (+ (cdr (Slime2 'get_pos)) 40 (* -5 (/ (- (+ (cdr (Slime2 'get_pos)) (Slime2 'get_rad)) (+ (cdr (ball 'get_pos)) (ball 'get_rad))) (distance Slime2 ball))))
                             
                             (+ (car (Slime2 'get_pos)) 22 (* -5 (/ (- (+ (car (Slime2 'get_pos)) (Slime2 'get_rad)) (+ (car (ball 'get_pos)) (ball 'get_rad))) (distance Slime2 ball))))
                             
                             (+ (cdr (Slime2 'get_pos)) 40 (* -5 (/ (- (+ (cdr (Slime2 'get_pos)) (Slime2 'get_rad)) (+ (cdr (ball 'get_pos)) (ball 'get_rad))) (distance Slime2 ball)))))
                                (send dc set-pen (make-object color% 255 255 0 .99) 1 'solid)
                       (send dc set-brush (make-object color% 255 255 0 .99) 'solid)
                       (send dc draw-ellipse (car (ball 'get_pos)) (cdr (ball 'get_pos)) 36 36)
                       (define (iter dc i score1 score2)
                         (if (= 7 i)
                             0
                             (begin
                               (if (< i score1) (send dc draw-ellipse (+ 25 (* 60 i)) 24 27 27) #f)
                               (if (< i score2) (send dc draw-ellipse (- (- windowXbound 50)  (* 60 i)) 25 27 27) #f)
                               (iter dc (+ i 1) score1 score2)
                             ))
                         )
                       (iter dc 0 player1score player2score)
                        ) ]))
(send (send gamecanvas get-dc) set-background (make-object color% 0 0 0 .99));155
(send frame show #t)


(define (gameloop)
  (Slime1 'move) ;moves the slime based on velocity and acceleration
  (Slime2 'move) ;moves the slime based on velocity and acceleration
  ;(print (distance Slime1 ball))
  ((ball 'collision) Slime1)
  ((ball 'collision) Slime2)
  (ball 'move)
  (ball 'wall)
  (send gamecanvas on-paint)
  (sleep/yield 0.008)
  (if (equal? (cdr (ball 'get_pos)) (- windowYbound 18))
      (begin 
        (if (< ( + (ball 'get_rad) (car (ball 'get_pos))) (/ windowXbound 2) )
            (begin (set! player2score (+ 1 player2score)) (set! lastToscore #t)
                   (send (send gamecanvas get-dc) set-font (make-object font% 40 'default))
                   (send (send gamecanvas get-dc) set-text-foreground (make-object color% 255 255 255 .99))
                   (send (send gamecanvas get-dc) draw-text "Player 2 Scores!" 300 100)
                   (send (send gamecanvas get-dc) set-font (make-object font% 20 'default))
                   (send (send gamecanvas get-dc) draw-text "Press Space to Continue" 350 160))
            (begin (set! player1score (+ 1 player1score)) (set! lastToscore #f)
                   (send (send gamecanvas get-dc) set-font (make-object font% 40 'default))
                   (send (send gamecanvas get-dc) set-text-foreground (make-object color% 255 255 255 .99))
                   (send (send gamecanvas get-dc) draw-text "Player 1 Scores!" 300 100)
                   (send (send gamecanvas get-dc) set-font (make-object font% 20 'default))
                   (send (send gamecanvas get-dc) draw-text "Press Space to Continue" 350 160))))
      (gameloop)))

(send dialog show #t)


;;main