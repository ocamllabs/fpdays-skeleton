(** A controller implemented as a client for the command-line server. *)
open Types

val initial_displays : displays
(** The initial state of the screen *) 

val process_event : door -> (displays * string) Lwt.t
(** Process a click on a door and return an updated door display state
    and a message to display.  The Lwt.t type is the type of Light Weight
    Threads, much like the Async library described in Chapter 18 of Real
    World OCaml:

      https://realworldocaml.org/beta3/en/html/concurrent-programming-with-async.html
*)
