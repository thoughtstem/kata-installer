#lang racket

(require pkg/name pkg/lib)

(provide ensure-all-installed-from-git!)

(define (installed? s)
  (define name (package-source->name s)) 
  (pkg-directory name))

(define (ensure-all-installed-from-git! . sources)

  (define to-update
    (filter installed? sources))

  (with-pkg-lock 
    (pkg-update to-update #:dep-behavior 'search-auto)))


