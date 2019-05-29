//
//  MovieSearchViewModel.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-02-07.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya
import Argo

public protocol MovieSearchViewModelInput {
  var searchText: BehaviorSubject<String> { get }
}

public protocol MovieSearchViewModelOutput {
  var moviesResult: Driver<[Movie]> { get }
}

public protocol MovieSearchViewModelType {
  var input: MovieSearchViewModelInput { get }
  var output: MovieSearchViewModelOutput { get }
}

public struct MovieSearchViewModel: MovieSearchViewModelType, MovieSearchViewModelInput, MovieSearchViewModelOutput {
  
  public init() {}
  
  private let provider = MoyaProvider<TheMovieDB>()
  
  public var searchText = BehaviorSubject<String>(value: "")
  
  public var moviesResult: Driver<[Movie]> {
    return searchText.asDriver(onErrorJustReturn: "")
      .debounce(.milliseconds(300))
      .distinctUntilChanged()
      .flatMapLatest { query -> Driver<[Movie]> in
        return self.provider.rx
          .request(TheMovieDB.search(type: .movies, query: query))
          .mapArray(rootKey: "results")
          .asDriver(onErrorJustReturn: [])
      }
  }
  
  public var input: MovieSearchViewModelInput { return self }
  public var output: MovieSearchViewModelOutput { return self }
}
