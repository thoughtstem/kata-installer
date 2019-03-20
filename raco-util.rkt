#lang racket

(require pkg/name pkg/lib pkg)

(provide update-if-installed!
         install-or-update!)

(define (installed? s)
  (define name (package-source->name s)) 
  (pkg-directory name))

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

