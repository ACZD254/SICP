#lang sicp
;Lets see
;Things to keep in mind - better variable names
;So I have to start with the number of coins and also type of coin
;I also have the amount that needs to be changed
;At every step, the process will be quite elementary
;For a certain type of a coin:
;We check if there amount - coin_type>0
;If it is, what do we do?
;We check if amount - coin_type can be resolved into sub_types
;But we also want to see if amount can be resolved by the independent subtypes
;Oh wait, maybe there is a way to do that

(define (type_of_coin coin_type)
  (cond ((= coin_type 5) 50)
        ((= coin_type 4) 25)
        ((= coin_type 3) 10)
        ((= coin_type 2) 5)
        ((= coin_type 1) 1)))
#|Pseudo code
at each level, find if the type of coin has more paths
find all paths for the subdenominations for that amount
|#

(define (change_counter amount coin_type)
  (cond((or (< amount 0)(= coin_type 0) 0))
       ((= amount 0) 1)
       (else(+ (change_counter amount (- coin_type 1))
                       (change_counter (- amount (type_of_coin coin_type)) coin_type)))))
(define (wrapper amount)
  (change_counter amount 5))
  
(wrapper 100)

                                                             