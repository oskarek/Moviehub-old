//
//  MediaItem.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-03-30.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

public struct MediaItem {
  public enum MediaType: String, Decodable {
    case movie
    case tv
    case person
  }
  
  let mediaType: MediaType
  let id: Int?
  let title: String?
  let posterPath: String?
  
  public init(mediaType: MediaType, id: Int?, title: String?, posterPath: String?) {
    self.mediaType = mediaType
    self.id = id
    self.title = title
    self.posterPath = posterPath
  }
}

extension MediaItem: Decodable {
  public static func decode(_ json: JSON) -> Decoded<MediaItem> {
    return curry(MediaItem.init)
      <^> json <| "media_type"
      <*> json <|? "id"
      <*> json <|? "title"
      <*> json <|? "poster_path"
  }
}
