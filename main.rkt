#lang racket

(provide pre-installer post-installer)

(require pkg-watcher 
         "./raco-util.rkt")


(define (pre-installer path)
  ;Some of our older installations used the racket package server.
  ;   Here, we make sure all installations come from git.
  ;Otherwise, they won't get updates immediately when we push to git.


  ;For some reason, this causes our install to fail if it isn't up-to-date.  See ticket: https://github.com/97jaz/gregor/issues/29  
  ;  Specifying these in info.rkt causes the error
  ;  This is basically a hack where we install these ourselves to avoid the wrong thing that raco seems to be doing. 
  (install-or-update!
     "tzinfo" 
     "gregor") 


  ;This is to switch anything from catalog to source.
  (update-if-installed! 
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
    "https://github.com/thoughtstem/TS-Languages.git?path=survival"))

;Gets called by raco automatically after setup
(define (post-installer path)
  (remove-callback! 'kata-installer/main) ;Old...
  (add-callback! 'kata-installer/update-backend) ;New...

  (watch! 'pkg-watcher)    ;Meta, watch pkg-watcher itself
  (watch! 'kata-installer) ;Meta, watch this very package too.

  (watch! 'ratchet)
  (watch! 'racket-chipmunk)
  (watch! 'game-engine)
  (watch! 'game-engine-rpg)
  (watch! 'game-engine-demos-common)

  (watch! 'battlearena-avengers)
  (watch! 'battlearena-fortnite)
  (watch! 'battlearena-starwars)
  (watch! 'battlearena)
  (watch! 'fundamentals)
  (watch! 'k2)
  (watch! 'survival-minecraft)
  (watch! 'survival-pokemon)
  (watch! 'survival))


