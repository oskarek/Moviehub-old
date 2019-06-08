//
//  Movie.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-02-06.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

enum Genre {
  case action, adventure, animation, comedy, crime, documentary, drama, family, fantasy, history, horror, music, mystery, romance, scienceFiction, tvMovie, thriller, war, western
}

public struct Movie {
  let id: Int
  let title: String
  let posterUrl: String?
  let overview: String?
  let collectionId: Int?
  let genreIds: [Int]
  let runtime: Int?
  let releaseDate: String?
}

extension Movie: Decodable {
  public static func decode(_ json: JSON) -> Decoded<Movie> {
    return curry(Movie.init)
      <^> json <| "id"
      <*> json <| "title"
      <*> json <|? "poster_path"
      <*> json <|? "overview"
      <*> json <|? "belongs_to_collection"
      <*> (json <|| "genre_ids" <|> pure([]))
      <*> json <|? "runtime"
      <*> json <|? "release_date"
  }
}
