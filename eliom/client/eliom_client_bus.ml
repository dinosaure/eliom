(* Ocsigen
 * http://www.ocsigen.org
 * Copyright (C) 2010-2011
 * Raphaël Proust
 * Pierre Chambart
 * Laboratoire PPS - CNRS Université Paris Diderot
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, with linking exception;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *)

let (>|=) = Lwt.(>|=)

type 'a t =
    {
      channel : 'a Eliom_common_comet.chan_id;
      write : 'a -> unit Lwt.t;
    }

let unwrap w =
  let (channel,service) = Eliommod_cli.unwrap w in
  {
    channel;
    write = (fun x -> Eliom_client.call_service ~service () x >|= (fun _ -> ()));
  }

let stream {channel} =
  Eliom_client_comet.register channel

let write {write} = write
