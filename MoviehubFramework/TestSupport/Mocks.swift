//
//  Mocks.swift
//  MoviehubFramework
//
//  Created by Oskar Ek on 2019-06-03.
//  Copyright © 2019 Oskar Ek. All rights reserved.
//

import Foundation

extension MediaItem {
  public static var mock: MediaItem {
    return MediaItem(
      mediaType: .movie,
      id: 157336,
      title: "Interstellar",
      posterPath: "/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg"
    )
  }
}
