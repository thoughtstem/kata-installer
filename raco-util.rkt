#lang racket

(require pkg/name pkg/lib pkg setup/setup)

(provide update-if-installed!
         install-or-update!
         install-or-change-source-but-not-update!)

(define (installed? s)
  (define name (package-source->name s)) 
  (pkg-directory name))

(define (source-of s)
  (define db (read-pkgs-db 'user))

  (define name (package-source->name s)) 
  (define info (hash-ref db (~a name) #f))
 
  (second (pkg-info-orig-pkg info)))

(define (update-if-installed! . sources)
  (define to-update
    (filter installed? sources))

  (for ([u to-update])
    (pkg-update-command u #:deps 'search-auto)))

(define (fast-install s)
  (pkg-install-command s #:deps 'search-auto #:no-setup #t))

(define (fast-update s)
  (pkg-update-command s #:deps 'search-auto #:no-setup #t))

(define (fast-setup . s)
  (setup #:collections (map list s) 
           ;Some things to make it faster...
           #:jobs (processor-count)
           #:make-docs? #f
           #:make-doc-index? #f))

(define (install-or-update! . sources)
  (for ([s sources])
    (if (installed? s)
      (fast-update s)
      (fast-install s))))

(define (install-or-change-source-but-not-update! . sources)
  (for ([s sources])
    (displayln (~a "INSTALLING OR CHANGING SOURCE " s))

    (with-handlers ([exn:fail? (thunk* (displayln (~a "ERRORS DURING INSTALL OF " s)))])
                   (cond [(not (installed? s))
                          (fast-install s)]
                         [(not (equal? s (source-of s)))
                          (fast-update s)])))
  
  (apply fast-setup sources))


