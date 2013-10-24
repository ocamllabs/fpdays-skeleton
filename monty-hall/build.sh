#!/bin/sh
set -e
ocamlbuild -use-ocamlfind -pkgs js_of_ocaml,lwt,js_of_ocaml,js_of_ocaml.syntax,deriving,deriving.syntax,js_of_ocaml.deriving,js_of_ocaml.deriving.syntax -syntax camlp4o monty.byte
js_of_ocaml -noruntime runtime.js monty.byte 
ocamlbuild -use-ocamlfind -pkgs cmdliner,cohttp.lwt,ctypes.foreign,js_of_ocaml,lwt,js_of_ocaml.syntax,js_of_ocaml,deriving,deriving.syntax,js_of_ocaml.deriving,js_of_ocaml.deriving.syntax -syntax camlp4o server.native
