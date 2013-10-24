(** A controller that handles game events (i.e. clicks on doors).  See
    controller.mli for function documentation.
 *)

open Types

let model : state ref = ref { open_doors = All_closed; prize_door = Left }

let process_event click =
  let model', message =
    (* TODO: something better here! *)
    !model, Messages.start
  in
  model := model';
  Lwt.return (Logic.door_displays !model, message)

let initial_displays = Logic.door_displays !model
