#lang racket/base

(provide post-installer)

(require pkg-watcher)

(define (post-installer path)
  (watch! 'pkg-watcher)    ;Meta, watch pkg-watcher itself
  (watch! 'kata-installer) ;Meta, watch this very package

;  (watch! 'ratchet)
;  (watch! 'racket-chipmunk)
  (watch! 'game-engine)
;  (watch! 'game-engine-rpg)
;  (watch! 'game-engine-demos-common)
;  (watch! 'battlearena)
;  (watch! 'survival)
 
  ;TODO: More here
  ;
  ;TODO: Consider whether we need to topologically sort anything.  If so, add that to pkg-watcher
  )


