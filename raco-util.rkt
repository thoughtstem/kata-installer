#lang racket

(require pkg/name pkg/lib pkg)

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


(define (install-or-update! . sources)
  (for ([s sources])
    (if (installed? s)
      (pkg-update-command s #:deps 'search-auto)
      (pkg-install-command s #:deps 'search-auto))))

(define (install-or-change-source-but-not-update! . sources)
  (for ([s sources])
    (cond [(not (installed? s))
           (pkg-install-command s #:deps 'search-auto)]
          [(not (equal? s (source-of s)))
           (pkg-update-command s #:deps 'search-auto)])))


