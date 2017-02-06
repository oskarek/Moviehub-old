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
      let movie = Movie(title: "Interstellar", year: "2014")
      expect(movie.title).to(equal("Interstellar"))
    }
  }
    
}
