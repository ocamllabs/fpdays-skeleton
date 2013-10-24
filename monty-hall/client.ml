(** A controller implemented as a client for the command-line server. 
    See client.mli for function documentation. 
*)

open Lwt
open XmlHttpRequest
open Types

let process_event click =
  let url = Printf.sprintf "http://127.0.0.1:8000/%s" (Json_door.to_string click) in
  get url >>= fun { content } ->
  Lwt.return (Json_event_result.from_string content)
  
let initial_displays = (Closed, Closed, Closed)
