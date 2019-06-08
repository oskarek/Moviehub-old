//
//  TheMovieDBEndpoint.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-03-29.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import Foundation
import Moya
import Prelude

enum TheMovieDB {
  fileprivate static let apiKey = "c4c310d31261b52644239b9e959bd9cc"
  case search(type: SearchType, query: String)
  case movie(id: Int)
}

extension TheMovieDB {
  /// The type of media to search for
  enum SearchType {
    case movies, people, tv, multi
    
    /// The string representation of this type in the url
    var urlString: String {
      switch self {
      case .movies: return "movie"
      case .people: return "person"
      case .tv: return "tv"
      case .multi: return "multi"
      }
    }
  }
}

extension TheMovieDB: TargetType {
  var headers: [String : String]? {
      return nil
  }
  
  var baseURL: URL {
    return URL(string: "https://api.themoviedb.org/3")!
  }
  
  var path: String {
    switch self {
    case .search(let type, _):
      return "search/\(type.urlString)"
    case .movie(let id):
      return "movie/\(id)"
    }
  }
  
  var method: Moya.Method { return .get }
  
  var parameters: [String : Any] { return [ "api_key": TheMovieDB.apiKey ] <> customParams }
  
  var customParams: [String : Any] {
    switch self {
    case .search(_, let query):
      return ["query": query]
    case .movie:
      return .empty
    }
  }
  
  var sampleData: Data {
    switch self {
    case let .search(type: type, query: _):
      switch type {
      case .movies:
        return "{\"page\": 1,\"results\": [\(TheMovieDB.exampleMovie())],\"total_results\": 1,\"total_pages\": 1}".data(using: .utf8)!
      case .multi:
        return "{\"page\":1,\"results\":[\(TheMovieDB.exampleMovie(withMediaType: true))],\"name\":\"Tom Cruise\",\"popularity\":18.851208}],\"total_results\":1,\"total_pages\":1}".data(using: .utf8)!
      case .tv:
        return "{\"page\":1,\"results\":[\(TheMovieDB.exampleTVShow())],\"total_results\":1,\"total_pages\":1}".data(using: .utf8)!
      case .people:
        return "{ \"page\": 1, \"results\": [\(TheMovieDB.exampleMovie(withMediaType: true)), \(TheMovieDB.exampleTVShow(withMediaType: true))], \"name\": \"Leonardo DiCaprio\", \"popularity\": 13.372483 } ], \"total_results\": 1, \"total_pages\": 1}".data(using: .utf8)!
      }
    case .movie(_):
      return Data() // TODO: add real implementation
    }
  }

  var task: Task {
    return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
  }
}

// example json data
extension TheMovieDB {
  fileprivate static func exampleMovie(withMediaType: Bool = false) -> String {
    let mediaTypeStr = withMediaType ? "\"media_type\": \"movie\"," : ""
    
    return "{\"poster_path\": \"/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg\",\"adult\": false,\"overview\": \"Interstellar chronicles the adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.\",\"release_date\": \"2014-11-05\",\"genre_ids\": [12,18,878],\"id\": 157336,\(mediaTypeStr)\"original_title\": \"Interstellar\",\"original_language\": \"en\",\"title\": \"Interstellar\",\"backdrop_path\": \"/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg\",\"popularity\": 30.239103,\"vote_count\": 7953,\"video\": false,\"vote_average\": 8}"
  }
  
  fileprivate static func exampleTVShow(withMediaType: Bool = false) -> String {
    let mediaTypeStr = withMediaType ? "\"media_type\": \"tv\", " : ""
    
    return "{ \"poster_path\": \"/7buCWBTpiPrCF5Lt023dSC60rgS.jpg\", \"popularity\": 22.151358, \"id\": 1668, \"backdrop_path\": \"/efiX8iir6GEBWCD0uCFIi5NAyYA.jpg\", \"vote_average\": 7.78, \(mediaTypeStr)\"overview\": \"Friends is an American sitcom revolving around a group of friends in the New York City borough of Manhattan. Episodes typically depict the friends' comedic and romantic adventures and career issues, such as Joey auditioning for roles or Rachel seeking jobs in the fashion industry. The six characters each have many dates and serious relationships, such as Monica with Richard Burke and Ross with Emily Waltham. Other frequently recurring characters include Ross and Monica's parents in Long Island, Ross's ex-wife and their son, Central Perk barista Gunther, Chandler's ex-girlfriend Janice, and Phoebe's twin sister Ursula.\", \"first_air_date\": \"1994-09-22\", \"origin_country\": [ \"US\" ], \"genre_ids\": [ 35 ], \"original_language\": \"en\", \"vote_count\": 518, \"name\": \"Friends\", \"original_name\": \"Friends\" }"
  }
}
