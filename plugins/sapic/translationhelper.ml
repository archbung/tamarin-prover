open Printf
open Sapic
open List
open Annotatedrule
open Annotatedsapicaction
open Annotatedsapictree
open Atomformulaaction
open Btree

let rec print_lemmas lem_list =
    match lem_list with
    | [] -> ""
    | h::t -> sprintf "%s\n\"\t%s\"\n\n" (h.header^(if (h.quantif='A') then " all-traces" else (if (h.quantif='E') then " exists-trace" else "")))
    h.formula  ^
    print_lemmas t

let rec print_restrictions res_list =
    match res_list with
    | [] -> ""
    | h::t -> sprintf "%s\n\"\t%s\"\n\n" (h.aheader) h.aformula  ^ print_restrictions t

let rec contains_lookup t = 
    match t with
      Empty -> false
    |   Node(Lookup _, left, right) -> true
    |   Node(_,left,right) -> (contains_lookup left) || (contains_lookup right)

let rec contains_locking t = 
    match t with
      Empty -> false
    |   Node(AnnotatedLock _, left, right)
    |   Node(AnnotatedUnlock _, left, right) -> true
    |   Node(_,left,right) -> (contains_locking left) || (contains_locking right)

let rec contains_eq t = 
    match t with
      Empty -> false
    |   Node(Cond(Action("eq",_)), _, _) -> true
    |   Node(_,left,right) -> (contains_eq left) || (contains_eq right)





