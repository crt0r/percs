#|
  percs

MIT License

Copyright (c) 2022 Timofey Chuchkanov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

|#

#lang racket/base

(require levenshtein
         racket/contract/base)

(provide (contract-out [strings-equality-percentage
                        (-> string? string? inexact?)]))

;; strings-equality-percentage: string? string? -> inexact?
;; Compare two strings using the Levenshtein distance and calculate the percentage of their equality.
(define (strings-equality-percentage string-a string-b)
  (let*
      ([STR-A-LENGTH    (string-length string-a)]
       [STR-B-LENGTH    (string-length string-b)]
       [MAX-LENGTH      (max STR-A-LENGTH STR-B-LENGTH)]
       [LEVENSHTEIN     (string-levenshtein string-a string-b)]
       [HUNDRED-PERCENT 100])
    (exact->inexact
     (if (and (= STR-A-LENGTH 0)  ; To avoid raising the division by zero,
              (= STR-B-LENGTH 0)) ; we need to return 100% if both strings are empty.
         HUNDRED-PERCENT
         (- HUNDRED-PERCENT
            (* (/ LEVENSHTEIN MAX-LENGTH) HUNDRED-PERCENT))))))

(module+ test
  (require rackunit)

  (check-pred (lambda (result)
                (> result 75))
              (strings-equality-percentage "Example S. T." "Example S.T."))

  (check-equal? (strings-equality-percentage "We are the same" "We are the same")
                100.0)

  (check-equal? (strings-equality-percentage "" "")
                100.0)

  (check-equal? (strings-equality-percentage "1234" "4321")
                0.0)

  (check-equal? (strings-equality-percentage "" "I'm not empty")
                0.0)

  (check-equal? (strings-equality-percentage "I'm not empty" "")
                0.0))