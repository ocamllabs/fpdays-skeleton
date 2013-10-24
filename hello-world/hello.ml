open Cmdliner

(* Improvements:

     1. Greet the person by name instead of using a generic greeting.
   
     2. Add a positional flag to customize the greeting, so we're not
        just stuck with "hello".

     3. Use the ANSITerminal package available on OPAM to add colours
        to the greeting.  You might like to add an argument to select
        the colour.
*)

let say_hello name =
  (** For details about printf, see
      https://realworldocaml.org/beta3/en/html/imperative-programming-1.html#formatted-output-with-printf
  *)
  Printf.printf "hello!\n"

(** The description of a positional argument indicating the name of
    the person to greet *)
let person = Arg.(value & pos 0 string "world" & info [])

(** The Cmdliner library parses the input by evaluating expressions in
    a little language of "terms".  Terms are either pure values and
    functions (built with pure), written like this:

           pure foo

    or terms applied to other terms, written like this:

           term1 $ term2

    "Pure" is a relative term, of course.  A value is considered pure
    in the term language if it doesn't have any effect on argument parsing.

    This term applies the function "say_hello" to the result of
    parsing the argument described by "person".
*)
let say_hello_term = Term.(pure say_hello $ person)

(** The name and version number of the program *)
let info = Term.info "hello" ~version:"1.0"

let () =
  (** Evaluate the term and exit successfully or otherwise depending
      on the result. *)
  match Term.eval (say_hello_term, info) with
  | `Error _ -> exit 1
  | _ -> exit 0

