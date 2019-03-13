#lang info
(define collection "kata-installer")
(define deps '("base" 
               "https://github.com/thoughtstem/pkg-watcher.git" 
               "https://github.com/thoughtstem/game-engine.git"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/kata-installer.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(thoughtstem))

(define post-install-collection 
  "./main.rkt")
