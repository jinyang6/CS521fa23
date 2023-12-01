; You can edit this code!
; Click here and start typing.

; Lines that start with a semicolon are comments

; Define the function for which you are constructing a transformer

(define-fun f ((x Real)) Real
(ite (> x 0) x (- x))       ; absolute value function
)

; Define the transformer as two functions
; one for the lower bound of the range and one for the upper bound

(define-fun Tf_lower ((l Real) (u Real)) Real
  (ite (< u 0) (f u) (ite (< l 0) 0 l))
)

(define-fun Tf_upper ((l Real) (u Real)) Real
  (ite (< u 0) (f l) (ite (< l 0) (ite (> (f u) (f l)) (f u) (f l)) u))
)


; To state the correctness of the transformer, ask the solver if there is 
; (1) a Real number x and (2) an interval [l,u]
; that violate the soundness property, i.e., satisfy the negation of the soundness property.

(declare-const x Real)
(declare-const l Real)
(declare-const u Real)
(declare-const y Real)

; store complex expressions in intermediate variables
; output under the function
(declare-const fx Real)
(assert (= fx (f x)))
; lower bound of range interval
(declare-const l_Tf Real)
(assert (= l_Tf (Tf_lower l u)))
; upper bound of range interval
(declare-const u_Tf Real)
(assert (= u_Tf (Tf_upper l u)))



;; For all y, Tf_lower([l,u]) <= y <= Tf_upper([l,u])
;; E x such that f(x) == y, x in [l,u]


(forall  )