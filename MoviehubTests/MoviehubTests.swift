//
//  MoviehubTests.swift
//  MoviehubTests
//
//  Created by Oskar Ek on 2017-02-06.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import Quick
import Nimble
@testable import Moviehub

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
