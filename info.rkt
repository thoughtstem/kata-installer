#lang info
(define collection "kata-installer")
(define deps '("base" 
               "simple-http"
               "https://github.com/thoughtstem/pkg-watcher.git" 

;Commenting out, so we can hackily install things ourselves.  See main.rkt.   
;               "gregor" 
;               "https://github.com/thoughtstem/ratchet.git"
;               "https://github.com/thoughtstem/racket-chipmunk.git"
;               "https://github.com/thoughtstem/game-engine.git"
;               "https://github.com/thoughtstem/game-engine-rpg.git"
;               "https://github.com/thoughtstem/game-engine-demos.git?path=game-engine-demos-common"
;               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-avengers"
;               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-fortnite"
;               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-starwars"
;               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena"
;               "https://github.com/thoughtstem/TS-Languages.git?path=fundamentals"
;               "https://github.com/thoughtstem/TS-Languages.git?path=k2"
;               "https://github.com/thoughtstem/TS-Languages.git?path=survival-minecraft"
;               "https://github.com/thoughtstem/TS-Languages.git?path=survival-pokemon"
;               "https://github.com/thoughtstem/TS-Languages.git?path=survival"
               ))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/kata-installer.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(thoughtstem))

(define compile-omit-paths
  '("update-backend.rkt") ;Because if it gets compiled, it'll require gregor, which we have to hackily install manually.  Don't want update-backend.rkt to mess up the `raco setup`
  )

(define pre-install-collection 
  "./main.rkt")

(define post-install-collection 
  "./main.rkt")


