//
//  Environment.swift
//  MoviehubFramework
//
//  Created by Oskar Ek on 2019-05-31.
//  Copyright © 2019 Oskar Ek. All rights reserved.
//

import Foundation
import RxMoya
import Moya

public var Current = Environment()

public struct Environment {
  var provider = MoyaProvider<TheMovieDB>(plugins: [NetworkLoggerPlugin(verbose: true)])
}

extension Environment {
  var mock: Environment {
    return .init(
      provider: MoyaProvider<TheMovieDB>(stubClosure: MoyaProvider.immediatelyStub)
    )
  }
}
