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


     ;Specifying #master because I read in the docs that it can speed things up when fetching from github.  https://docs.racket-lang.org/pkg/Package_Concepts.html#%28tech._package._source%29

     "https://github.com/jeapostrophe/lux.git#master"
     "https://github.com/jeapostrophe/mode-lambda.git#0858b6d"

     "https://github.com/thoughtstem/pkg-watcher.git#master" 
     "https://github.com/thoughtstem/ratchet.git#master"
     "https://github.com/thoughtstem/racket-chipmunk.git#4a0198a"
     "https://github.com/thoughtstem/TS-Kata-Collections.git?path=ts-kata-util"
     
     "https://github.com/thoughtstem/game-engine.git#master"
     "https://github.com/thoughtstem/game-engine-rpg.git#master"
     "https://github.com/thoughtstem/game-engine-demos.git?path=game-engine-demos-common#master"
     
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=battlearena#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=battlearena-avengers#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=battlearena-fortnite#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=battlearena-starwars#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=survival#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=survival-minecraft#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=survival-pokemon#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=adventure#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=adventure-harrypotter#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=adventure-mario#master"

     "https://github.com/thoughtstem/TS-GE-Languages.git?path=k2#master"

     "https://github.com/thoughtstem/TS-K2-Languages.git?path=clicker-cartoon-collect#master"
     "https://github.com/thoughtstem/TS-K2-Languages.git?path=clicker-cartoon-avoid#master"
     "https://github.com/thoughtstem/TS-K2-Languages.git?path=clicker-cartoon-special#master"
     
     "https://github.com/thoughtstem/TS-K2-Languages.git?path=healer-animal-foods#master"
     "https://github.com/thoughtstem/TS-K2-Languages.git?path=healer-animal-friends#master"
     "https://github.com/thoughtstem/TS-K2-Languages.git?path=healer-animal-enemies#master"

     "https://github.com/thoughtstem/TS-VR-Languages.git?path=3d-exploration#master"
     
     "https://github.com/thoughtstem/TS-MISC-Languages.git?path=data-sci#master"
     "https://github.com/thoughtstem/TS-MISC-Languages.git?path=fundamentals#master"
     )
  
  (displayln "BUILDING DOCS FOR STUDENT LANGUAGES")
  (fast-setup #:slow-mode? #t ;Builds the docs, which is not the default.
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=battlearena-avengers#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=battlearena-fortnite#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=battlearena-starwars#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=survival#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=survival-minecraft#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=survival-pokemon#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=adventure#master"         
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=adventure-harrypotter#master"
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=adventure-mario#master"
     
     "https://github.com/thoughtstem/TS-MISC-Languages.git?path=data-sci#master"
     "https://github.com/thoughtstem/TS-MISC-Languages.git?path=fundamentals#master"
     
     "https://github.com/thoughtstem/TS-GE-Languages.git?path=k2#master"
     ) 
        
)

;Gets called by raco automatically after setup
(define (post-installer path)
  ;Here we define our policy for which packages should be updated every time DrRacket opens, and which shall be explicitly updated (with `raco update-watched-packages`).

  ;Also, we set up a callback for watching the updates and reporting to our backend.  But that really ought to be moved to a different package that kata-installer installs (i.e. add it to the package source list above)
  (add-callback! 'kata-installer/update-backend) ;New...

  (priority-watch! 'pkg-watcher)    ;Meta, watch pkg-watcher itself
  (priority-watch! 'kata-installer) ;Meta, watch this very package too.

  (watch! 'ratchet)
  (watch! 'racket-chipmunk)
  (watch! 'ts-kata-util)
  
  (watch! 'game-engine)
  (watch! 'game-engine-rpg)
  (watch! 'game-engine-demos-common)

  (watch! 'battlearena-avengers)
  (watch! 'battlearena-fortnite)
  (watch! 'battlearena-starwars)
  (watch! 'battlearena)
  (watch! 'survival-minecraft)
  (watch! 'survival-pokemon)
  (watch! 'survival)
  (watch! 'adventure-harrypotter)
  (watch! 'adventure-mario)
  (watch! 'adventure)
  
  (watch! 'k2) ;remove after Fall 2019
  
  (watch! 'data-sci)
  (watch! 'fundamentals)
  
  (watch! 'clicker-cartoon-collect)
  (watch! 'clicker-cartoon-avoid)
  (watch! 'clicker-cartoon-special)
     
  (watch! 'healer-animal-foods)
  (watch! 'healer-animal-friends)
  (watch! 'healer-animal-enemies)

  (watch! '3d-exploration)
  
  
  )


