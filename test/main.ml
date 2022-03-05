open OUnit2
open Game
open P_state


(********************************************************************
   Here are some helper functions for your testing of set-like lists.
 ********************************************************************)

(** [cmp_set_like_lists lst1 lst2] compares two lists to see whether
    they are equivalent set-like lists. That means checking two things.
    First, they must both be {i set-like}, meaning that they do not
    contain any duplicates. Second, they must contain the same elements,
    though not necessarily in the same order. *)
let cmp_set_like_lists lst1 lst2 =
  let uniq1 = List.sort_uniq compare lst1 in
  let uniq2 = List.sort_uniq compare lst2 in
  List.length lst1 = List.length uniq1
  && List.length lst2 = List.length uniq2
  && uniq1 = uniq2

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

let pp_bool bool = 
  if bool = true then 
    "true" else "false"

(** [pp_list pp_elt lst] pretty-prints list [lst], using [pp_elt] to
    pretty-print each element of [lst]. *)
let pp_list pp_elt lst =
  let pp_elts lst =
    let rec loop n acc = function
      | [] -> acc
      | [ h ] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
          if n = 100 then acc ^ "..." (* stop printing long list *)
          else loop (n + 1) (acc ^ pp_elt h1 ^ "; ") t'
    in
    loop 0 "" lst
  in
  "[" ^ pp_elts lst ^ "]"

(* These tests demonstrate how to use [cmp_set_like_lists] and [pp_list]
   to get helpful output from OUnit. *)
let cmp_demo =
  [
    ( "order is irrelevant" >:: fun _ ->
      assert_equal ~cmp:cmp_set_like_lists ~printer:(pp_list pp_string)
        [ "foo"; "bar" ] [ "bar"; "foo" ] )
    (* Uncomment this test to see what happens when a test case fails.
       "duplicates not allowed" >:: (fun _ -> assert_equal
       ~cmp:cmp_set_like_lists ~printer:(pp_list pp_string) ["foo";
       "foo"] ["foo"]); *);
  ]

(********************************************************************
   End helper functions.
 ********************************************************************)

(* You are welcome to add strings containing JSON here, and use them as
   the basis for unit tests. You can also use the JSON files in the data
   directory as tests. And you can add JSON files in this directory and
   use them, too. *)

(* You should not be testing any helper functions here. Test only the
   functions exposed in the [.mli] files. Do not expose your helper
   functions. See the handout for an explanation. *)

(* TODO: add unit tests for modules below. You are free to reorganize
   the definitions below. Just keep it clear which tests are for which
   modules. *)



let p_state_valid_move_test (name : string) state move expected_output : test =
  name >:: fun _ ->
  assert_equal expected_output (valid_move state move) ~printer:pp_bool


let p_state_tests = [ 
  p_state_valid_move_test "valid move on test state" test_p_state "cut" true; 
]

let suite =
  "test suite for camlmon"
  >::: List.flatten [ p_state_tests ]

let _ = run_test_tt_main suite
