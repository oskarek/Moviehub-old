//
//  TVShow.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-03-30.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct TVShow {
  let id: Int
  let title: String?
}

extension TVShow: Decodable {
  static func decode(_ json: JSON) -> Decoded<TVShow> {
    return curry(TVShow.init)
      <^> json <| "id"
      <*> json <| "name"
  }
}
