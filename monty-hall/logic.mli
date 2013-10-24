(** The game logic *)

open Types

val fresh_game : unit -> state
(** Build the state for a fresh game. *)

val initial_pick : state -> door -> state
(** The first move in the game.  The player picks a door, causing the
    transition to a new state, where one door has been opened by the
    presented, and another door is marked as picked by the player. See
    the One_open tag of the open_doors type in types.ml *)

val complete : state -> switch:bool -> (state * [ `Lose | `Win ])
(** The final move in the game.  The player must choose whether to
    switch away from his initial selection.  The second argument is
    labeled; for more about labelled arguments, see:

      https://realworldocaml.org/beta3/en/html/variables-and-functions.html#labeled-arguments 

    The function returns a pair of arguments: the updated state, and a
    flag indicating whether the player won or lost the game.  The flag
    is an example of a polymorphic variant type; see:

       https://realworldocaml.org/beta3/en/html/variants.html#polymorphic-variants
*)


val door_displays : state -> displays
(** Convert the internal game state into a description of the visible
    state of the doors.
*)
