(** Monty Hall game interface *)

module Html = Dom_html
let js = Js.string
let document = Html.window##document
open Lwt
open Types

(** A convenient wrapper around getElementById, which fails
    catastrophically if the element is not found. *)
let get_element_by_id id = 
  Js.Opt.get (document##getElementById(js id))
    (fun () -> assert false)  

(** Display a message in the message area of the screen. *)
let display_message message =
  (get_element_by_id "messages")##innerHTML <- js message

(** Map a display description to a URL for the corresponding image *)
let picture_url _  ="images/goat.jpg" (* TODO! *)

let render_door door div =
  div##innerHTML <- js(Printf.sprintf "<img src=\"%s\"></img>" (picture_url door))

let render_model displays divs = () (* TODO! *)

let handle_click click divs =
  Controller.process_event click >>= fun (displays, msg) ->
  begin
    display_message msg;
    render_model displays divs;
    Lwt.return ()
  end

let onload _ =
  (* Set up the screen, install event handlers, and start the first game *)
  let main = get_element_by_id "main" in
  let one = document##createElement (js"span") in
  let two = document##createElement (js"span") in
  let three = document##createElement (js"span") in
  let divs = (one, two, three) in
  one##onclick <- Html.handler
    (fun _ -> Lwt.ignore_result (handle_click Left divs); Js._false);
  two##onclick <- Html.handler
    (fun _ -> Lwt.ignore_result (handle_click Middle divs); Js._false);
  three##onclick <- Html.handler
    (fun _ -> Lwt.ignore_result (handle_click Right divs); Js._false);
  Dom.appendChild main one;
  Dom.appendChild main two;
  Dom.appendChild main three;
  Dom.appendChild main (document##createElement (js"br"));
  display_message Messages.start;
  render_model (Controller.initial_displays) divs;
  Js._false

let _ = Html.window##onload <- Html.handler onload
