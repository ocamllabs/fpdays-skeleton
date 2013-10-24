(** The game logic *)

open Types

let random_choice choices =
  List.nth choices  (Random.int (List.length choices))

let all_doors = [Left; Middle; Right]

let pick_door () = random_choice all_doors

let fresh_game () : state = { 
  open_doors = All_closed;
  prize_door = pick_door ();
}

let pick_any_door ~except =
  let candidates = List.filter (fun d -> not (List.mem d except)) all_doors in
  random_choice candidates

let initial_pick : state -> door -> state =
  fun state picked_door ->
    failwith "Not implemented" (* TODO! *)

let complete : state -> switch:bool -> state * [`Win | `Lose] =
  fun state ~switch ->
    failwith "Not implemented" (* TODO! *)

let all_closed = (Closed, Closed, Closed)
let all_goats = (Goat, Goat, Goat)

let door_displays : state -> display * display * display =
  fun state ->
    failwith "Not implemented" (* TODO! *)
