(** A command-line server that communicates with the browser using
    JSON over HTTP, receiving game events and returning a description
    of the updated display.
*)

open Cmdliner
open Lwt
open Types

let strip_leading_char s =
  s (* TODO! *)

let decode_uri request : door =
  Json_door.from_string (strip_leading_char (Uri.path (Cohttp.Request.uri request)))

let callback connection_id ?body request =
  Cohttp_lwt_body.string_of_body body >>= fun body ->
  let door = decode_uri request in
  let event_result = Lwt_main.run (Controller.process_event door) in
  let json = Json_event_result.to_string event_result in
  let headers = Cohttp.Header.init () in
  let headers = Cohttp.Header.add headers "Content-type" "text/plain" in
  let headers = Cohttp.Header.add headers "Access-Control-Allow-Origin" "*" in
  let response = Cohttp.Response.make ~headers () in
  Lwt.return (response, Cohttp_lwt_body.body_of_string (json ^ "\n"))

let run () =
  let process = 
    Cohttp_lwt_unix.Server.create ~address:"127.0.0.1" ~port:8000
      { Cohttp_lwt_unix.Server.callback=callback;
        conn_closed = fun _ () -> () }
  in Lwt_main.run process

let () = run ()
