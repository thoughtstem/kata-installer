#lang racket

(require pkg/name pkg/lib)

(provide ensure-all-installed-from-git!)

(define (installed? s)
  (define name (package-source->name s)) 
  (pkg-directory name))

(define (ensure-all-installed-from-git! . sources)
  (define to-update
    (filter installed? sources))

  (for ([u to-update])
    (pkg-update-command u #:deps 'search-auto)))


