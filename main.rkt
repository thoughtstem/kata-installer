#lang racket

(provide pre-installer post-installer)

(require pkg-watcher 
         "./raco-util.rkt")


;Gets called by raco automatically after setup
(define (pre-installer path)
  ;I know it looks like we're managing dependencies here -- which Racket could do for us.
  
  ;However, this gives us more fine-grained control over how and when these packages update.

  ;One annoyance is that you'll need to make sure these dependencies are topologically sorted according to their dependency graph.  That is: If B depends on A, it must come after A in the list.  Other than that constraint, it can be ordered however you want.
  (install-or-change-source-but-not-update!
     "tzinfo" 
     "gregor" 

     "https://github.com/thoughtstem/pkg-watcher.git" 
     "https://github.com/thoughtstem/ratchet.git"
     "https://github.com/thoughtstem/racket-chipmunk.git"
     "https://github.com/thoughtstem/game-engine.git"
     "https://github.com/thoughtstem/game-engine-rpg.git"
     "https://github.com/thoughtstem/game-engine-demos.git?path=game-engine-demos-common"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-avengers"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-fortnite"
     "https://github.com/thoughtstem/TS-Languages.git?path=battlearena-starwars"
     "https://github.com/thoughtstem/TS-Languages.git?path=fundamentals"
     "https://github.com/thoughtstem/TS-Languages.git?path=k2"
     "https://github.com/thoughtstem/TS-Languages.git?path=survival"
     "https://github.com/thoughtstem/TS-Languages.git?path=survival-minecraft"
     "https://github.com/thoughtstem/TS-Languages.git?path=survival-pokemon"
     
     ))

;Gets called by raco automatically after setup
(define (post-installer path)
  ;Here we define our policy for which packages should be updated every time DrRacket opens, and which shall be explicitly updated (with `raco update-watched-packages`).

  ;Also, we set up a callback for watching the updates and reporting to our backend.  But that really ought to be moved to a different package that kata-installer installs (i.e. add it to the package source list above)
  (add-callback! 'kata-installer/update-backend) ;New...

  (priority-watch! 'pkg-watcher)    ;Meta, watch pkg-watcher itself
  (priority-watch! 'kata-installer) ;Meta, watch this very package too.

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


