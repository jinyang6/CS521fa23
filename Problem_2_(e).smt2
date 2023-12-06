; You can edit this code!
; Click here and start typing.

; Lines that start with a semicolon are comments

; Define the function for which you are constructing a transformer

(define-fun f ((x Real)) Real
  (ite (>= (* x x) (* x x x)) (* x x) (* x x x))
)

; Define the transformer as two functions
; one for the lower bound of the range and one for the upper bound


(define-fun Tf_lower ((l Real) (u Real)) Real ())



(define-fun Tf_upper ((l Real) (u Real)) Real ())


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


;;NOT
;; For all y, Tf_lower([l,u]) <= y <= Tf_upper([l,u])
;; E x such that f(x) == y, x in [l,u]

(assert     (not  (forall ((y Real)) 
                            (=> 
                                (and (<= (Tf_lower l u) y)  (<= y (Tf_upper l u)) (<= l u))
                                (exists ((x Real)) (and (= (f x) y) (>= x l) (<= x u)))
                            )
                )
            )
)


; Check for the existence of such an x, l, and u, y
(check-sat)

; Optionally, get the model if the result is sat (satisfiable)
; This will give you the values of x, l, and u that violate the soundness property
;(get-model)