//
//  MediaItem.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-03-30.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import Foundation
import Argo

protocol MediaItem {
  var id: Int { get }
  var title: String { get }
}

extension MediaItem where Self : Decodable {
  static func decode(_ json: JSON) -> Decoded<MediaItem> {
    return Self.decode(json)
  }
}
