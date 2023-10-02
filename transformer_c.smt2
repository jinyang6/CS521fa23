; Lines that start with a semicolon are comments

; Define the function for which you are constructing a transformer

(define-fun f ((x Real)) Real
       ( - x (abs x) )
)

; Define the transformer as two functions
; one for the lower bound of the range and one for the upper bound

(define-fun Tf_lower ((l Real) (u Real)) Real
; Your code here
  (ite (< l 0) (- l (abs l)) 0) 
)

(define-fun Tf_upper ((l Real) (u Real)) Real
; Your code here
    (ite (< u 0) (- u (abs u)) 0)
)

(declare-const x Real)
(declare-const l Real)
(declare-const u Real)


(declare-const fx Real)
(assert (= fx (f x)))

(declare-const l_Tf Real)
(assert (= l_Tf (Tf_lower l u)))

(declare-const u_Tf Real)
(assert (= u_Tf (Tf_upper l u)))

(assert (not                         ; negation of soundness property 
  (=>  
    (and (<= l x) (<= x u))          ; if input is within given bounds
    (and (<= l_Tf fx) (<= fx u_Tf))  ; then output is within transformer bounds
  )
))

; This command asks the solver to check the satisfiability of your query
; If you wrote a sound transformer, the solver should say 'unsat'
(check-sat)
; If the solver returns 'sat', uncommenting the line below will give you the values of the various variables that violate the soundness property. This will help you debug your solution.
;(get-model)