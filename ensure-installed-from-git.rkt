#lang racket

(require pkg/name pkg/lib pkg)

(provide update-if-installed!)

(define (installed? s)
  (define name (package-source->name s)) 
  (pkg-directory name))

(define (update-if-installed! . sources)
  (define to-update
    (filter installed? sources))

  (for ([u to-update])
    (pkg-update-command u #:deps 'search-auto)))


