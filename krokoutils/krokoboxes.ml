(* Kroko
 * Copyright (C) 2005 Vincent Balat
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *)

open Kroko
open Krokosavable
open Krokodata

(** Authentification *)
let create_login_form = 
  (fun login password ->
     let login = string_box ~size:8 login in
     let password = string_box ~size:8 password in
     let b = button "Entrer" in
       <:xmllist< 
         Login: $login$ <br/>
         Password: $password$ <br/>
	 $b$
       >>)

let login_box_action h actionurl = 
  action_form ~id:"loginbox" ~classe:["userbox"] h actionurl create_login_form

let login_box h url = form_post h.current_url url create_login_form

let deconnect_action = 
  register_new_actionurl _unit close_session

let deconnect_box h s = action_link s h deconnect_action


(** User information *)
let connected_box h user =
  let login,name,_ = Rights.get_user_info user in
  let deconnect = deconnect_box h "d�connexion" in
    << <div id="loggedbox" class="userbox"> 
         Vous �tes connect� comme utilisateur $str:login$ <br/>
         $deconnect$
       </div>
    >>
  


(* 
   If we want to make the url a box parameter saved in the db, it is not
   easy, because we need to make a table of url in which we register
   all the url we want to be able to save. For ex:
let fold_login_box = 
  RegisterHPBoxes.register ~name:"login_box" 
    ~constructor:(fun ~box_param:urltag h -> login_box h (unfold_url urltag))

   But anyway it is not easy to propose to the user (in the web interface to
   create pages) a list of url to put as parameters of boxes.
   
*)

(*
let urltag = fold_url "mapage" url
*)

(*
let form = register_new_url (Url ["form"]) _noparam 
  (let f = form_get plop_params create_form in
  << <html> $f$ </html> >>)
*)
