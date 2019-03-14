#lang racket

(provide post-installer)

(require pkg-watcher json simple-http gregor)

(define (post-installer path)
  (watch! 'pkg-watcher)    ;Meta, watch pkg-watcher itself
  (watch! 'kata-installer) ;Meta, watch this very package

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
  (watch! 'survival)
 

  ;TODO: Contacting our backend...
    ;Done, but not quite the right place...
    ; Should trigger when pkg-watcher does its thing...
    ; dynamic-require some path stored in pkg-watcher's dot file?


  (define cb-file
    (build-path (find-system-path 'home-dir)
                              "remote"
                              "cb_id"))
  
  (if (file-exists? cb-file)
      (log-update)
      (void)))

;TODO: Protect this, only run on our CBs.  Keep kata-installer relatively general.

(define (log-update)
  (define time (~t (now/moment/utc) "y-m-d hh:mm:ss 'UTC'"))

  (define cb-id (string-trim
                 (file->string
                  build-path (find-system-path 'home-dir)
                              "remote"
                              "cb_id")))
  
  (define local-config (file->string 
                         (build-path (find-system-path 'home-dir)
                                     "remote"
                                     "sessions"
                                     "config.json")))

  (define config-json (string->jsexpr local-config))
  
  (define api-key (hash-ref config-json 'api_key))
  
  (define secure-thoughtstem-com
    (update-ssl
      (update-host json-requester "secure.thoughtstem.com") #t))
  
  (define response (put secure-thoughtstem-com
                        (~a "/computers/" cb-id ".json?api_key=" api-key)
                        #:data
                        (jsexpr->string
                         (hash 'computer
                               (hash 'software_version time)))))

  (void))


