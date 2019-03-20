#lang racket

(provide callback)

(require json simple-http gregor)

;Gets called by pkg-watcher automatically after updates complete
(define (callback)
  (define chromebook-file
    (build-path (find-system-path 'home-dir)
                "remote"
                "cb_id"))

  (if (file-exists? chromebook-file) 
      (log-update)
      (void)))
  

(define (log-update)
  (define time (~t (now/moment/utc) 
                   "y-MM-dd HH:mm:ss"))

  (define cb-id (string-trim
                 (file->string
                   (build-path (find-system-path 'home-dir)
                                "remote"
                                "cb_id"))))
  
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







