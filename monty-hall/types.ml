(* A variant type representing the three doors in the application.  In this
   simple form, variant types are rather like C enums.  For more on variant
   types, see:

   https://realworldocaml.org/beta3/en/html/variants.html
*)
type door = 
| Left
| Middle
| Right
    (* The "deriving" syntax extension creates pretty-printers and
       serialisation functions from type definitions, much like the "with sexp"
       extension described in Real World OCaml:

       https://realworldocaml.org/beta3/en/html/data-serialization-with-s-expressions.html#idp10642928
    *)

    deriving (Show, Json)

(* A record type representing the two door picked by the player and the door
   opened by the host halfway through the game.  For more on record types, see

   https://realworldocaml.org/beta3/en/html/records.html
*)
type intermediate_state = {
  picked_door : door;
  open_door : door;
} deriving (Show, Json)


(* The "open_doors" variant type represents the visible states of the doors at
   various stages in the game: *)
type open_doors =
(* At the beginning of the game all the doors are closed *)
| All_closed
(* In the middle of the game one door is open.  The clause "of
   intermediate_state" indidcates that the One_open tag has an associated
   field of type intermediate_state. *)
| One_open of intermediate_state
(* At the end of the game all the doors are open *)
| All_open
    deriving (Show, Json)

(* The "state" record type holds the full game state, which consists of the
   visible state of the doors, and the door behind which the prize is
   concealed. *)
type state = {
  open_doors : open_doors;
  prize_door : door
} deriving (Show, Json)

(* A variant type representing the visual representation of a single door *)
type display = Closed | Goat | Car | Picked
    deriving (Show, Json)

(* A tuple type representing the visual representation of all three doors *)
type displays = display * display * display
  deriving (Show, Json)

(* The result of clicking on a door: an updated display and a message to display *)
type event_result = displays * string
  deriving (Json)
