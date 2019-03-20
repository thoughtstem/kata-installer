#lang info
(define collection "kata-installer")
(define deps '("base" 
               "gregor"
               "simple-http"
               "https://github.com/thoughtstem/pkg-watcher.git" 
               "https://github.com/thoughtstem/ratchet.git"
               "https://github.com/thoughtstem/racket-chipmunk.git"
               "https://github.com/thoughtstem/game-engine.git"
               "https://github.com/thoughtstem/game-engine-rpg.git"
               "https://github.com/thoughtstem/game-engine-demos.git?path=game-engine-demos-common"
               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-avengers"
               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-fortnite"
               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-starwars"
               "https://github.com/thoughtstem/TS-Languages.git?path=battlearena"
               "https://github.com/thoughtstem/TS-Languages.git?path=fundamentals"
               "https://github.com/thoughtstem/TS-Languages.git?path=k2"
               "https://github.com/thoughtstem/TS-Languages.git?path=survival-minecraft"
               "https://github.com/thoughtstem/TS-Languages.git?path=survival-pokemon"
               "https://github.com/thoughtstem/TS-Languages.git?path=survival"
               ))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/kata-installer.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(thoughtstem))

(define pre-install-collection 
  "./main.rkt")

(define post-install-collection 
  "./main.rkt")
