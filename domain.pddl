(define (domain elevators-sequencedstrips)
  (:requirements :typing :action-costs :negative-preconditions :conditional-effects)
  (:types
    elevator - object
    slow-elevator fast-elevator - elevator
    passenger - object
    teacher - passenger
    count - object
  )

  (:predicates

    (origin ?person - passenger ?floor - count)
    (dest ?person - passenger ?floor - count)
    (boarded ?person - passenger ?lift - elevator)
    (lift-at ?lift - elevator ?floor - count)
    (reachable-floor ?lift - elevator ?floor - count)
    (above ?floor1 - count ?floor2 - count)
    (passengers ?lift - elevator ?n - count)
    (can-hold ?lift - elevator ?n - count)
    (next ?n1 - count ?n2 - count)
    (contains-special ?lift - slow-elevator)
    (is-special ?person - passenger)
    (served ?person - passenger)
  )

  (:functions
    (total-cost) - number
    (travel-slow ?f1 - count ?f2 - count) - number
    (travel-fast ?f1 - count ?f2 - count) - number
  )

  (:action move-up-slow
    :parameters (?lift - slow-elevator ?f1 - count ?f2 - count)
    :precondition (and (lift-at ?lift ?f1) (above ?f1 ?f2) (reachable-floor ?lift ?f2))
    :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-slow ?f1 ?f2)))
  )

  (:action move-down-slow
    :parameters (?lift - slow-elevator ?f1 - count ?f2 - count)
    :precondition (and (lift-at ?lift ?f1) (above ?f2 ?f1) (reachable-floor ?lift ?f2))
    :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-slow ?f2 ?f1)))
  )

  (:action move-up-fast
    :parameters (?lift - fast-elevator ?f1 - count ?f2 - count)
    :precondition (and (lift-at ?lift ?f1) (above ?f1 ?f2) (reachable-floor ?lift ?f2))
    :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-fast ?f1 ?f2)))
  )

  (:action move-down-fast
    :parameters (?lift - fast-elevator ?f1 - count ?f2 - count)
    :precondition (and (lift-at ?lift ?f1) (above ?f2 ?f1) (reachable-floor ?lift ?f2))
    :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-fast ?f2 ?f1)))
  )

  (:action board-fast
    :parameters (?p - teacher ?lift - fast-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and (not (served ?p)) (lift-at ?lift ?f) (origin ?p ?f) (passengers ?lift ?n1) (next ?n1 ?n2) (can-hold ?lift ?n2))
    :effect (and (boarded ?p ?lift) (not (passengers ?lift ?n1)) (passengers ?lift ?n2))
  )

  (:action leave-fast
    :parameters (?p - teacher ?lift - fast-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and (dest ?p ?f) (lift-at ?lift ?f) (boarded ?p ?lift) (passengers ?lift ?n1) (next ?n2 ?n1))
    :effect (and (served ?p) (not (boarded ?p ?lift)) (not (passengers ?lift ?n1)) (passengers ?lift ?n2))
  )

  (:action board-slow
    :parameters (?p - passenger ?lift - slow-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and (not (served ?p)) (not(contains-special ?lift)) (lift-at ?lift ?f) (origin ?p ?f) (passengers ?lift ?n1) (next ?n1 ?n2) (can-hold ?lift ?n2))
    :effect (and
      (when(is-special ?p)
        (and (contains-special ?lift) (boarded ?p ?lift) (not (passengers ?lift ?n1)) (passengers ?lift ?n2))
      )
      (when(not(is-special ?p))
        (and (boarded ?p ?lift) (not (passengers ?lift ?n1)) (passengers ?lift ?n2))
      )
    )
  )

  (:action leave-slow-special
    :parameters (?p - passenger ?lift - slow-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and (is-special ?p) (dest ?p ?f) (lift-at ?lift ?f) (boarded ?p ?lift) (passengers ?lift ?n1) (next ?n2 ?n1))
    :effect (and (served ?p) (not (boarded ?p ?lift)) (not (passengers ?lift ?n1)) (passengers ?lift ?n2) (not(contains-special ?lift)))
  )

  (:action leave-slow-general
    :parameters (?p - passenger ?lift - slow-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and (not(contains-special ?lift)) (dest ?p ?f) (lift-at ?lift ?f) (boarded ?p ?lift) (passengers ?lift ?n1) (next ?n2 ?n1))
    :effect (and (served ?p) (not (boarded ?p ?lift)) (not (passengers ?lift ?n1)) (passengers ?lift ?n2))
  )
)