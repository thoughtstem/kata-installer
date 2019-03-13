#lang racket

(provide post-installer)

(require pkg-watcher json simple-http racket/date)

(define (post-installer path)
  (watch! 'pkg-watcher)    ;Meta, watch pkg-watcher itself
  (watch! 'kata-installer) ;Meta, watch this very package

;  (watch! 'ratchet)
;  (watch! 'racket-chipmunk)
  (watch! 'game-engine)
  (watch! 'game-engine-rpg)
;  (watch! 'game-engine-demos-common)
;  (watch! 'battlearena)
;  (watch! 'survival)
 
  ;TODO: More here
  ;
  ;TODO: Consider whether we need to topologically sort anything.  If so, add that to pkg-watcher


  ;TODO: Contacting our backend...


  (log-update)
  )

;TODO: Protect this, only run on our CBs.  Keep kata-installer relatively general.

(define (log-update)
  (define cb-id (file->string
		  (build-path (find-system-path 'home-dir)
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

  ; Query params for the request
  (define params (list (cons 'api_key api-key)))

  ; Make a GET to https://httpbin.org/get?foo=12&bar=hello
  (define response (put secure-thoughtstem-com (~a "/computers/" cb-id ".json") #:params params #:data (hash 'software_version (current-milliseconds))))

  (void))


