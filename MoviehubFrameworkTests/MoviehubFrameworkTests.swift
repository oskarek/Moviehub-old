//
//  MoviehubFrameworkTests.swift
//  MoviehubFrameworkTests
//
//  Created by Oskar Ek on 2019-05-29.
//  Copyright © 2019 Oskar Ek. All rights reserved.
//

import Quick
import Nimble
@testable import MoviehubFramework

class MoviehubTests: QuickSpec {
  
  override func spec() {
    describe("Movie") {
      it("works") {
        let movie = Movie(id: 1, title: "Interstellar", posterUrl: nil, overview: nil, collectionId: nil, genreIds: [], runtime: nil, releaseDate: nil)
        expect(movie.title).to(equal("Interstellar"))
      }
    }
  }
  
}
