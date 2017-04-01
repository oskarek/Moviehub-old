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

protocol MovieSearchViewModelInput {
  var searchText: BehaviorSubject<String> { get }
}

protocol MovieSearchViewModelOutput {
  var moviesResult: Driver<[Movie]> { get }
}

protocol MovieSearchViewModelType {
  var input: MovieSearchViewModelInput { get }
  var output: MovieSearchViewModelOutput { get }
}

struct MovieSearchViewModel: MovieSearchViewModelType, MovieSearchViewModelInput, MovieSearchViewModelOutput {
  
  private let provider = RxMoyaProvider<TheMovieDB>()
  
  var searchText = BehaviorSubject<String>(value: "")
  
  var moviesResult: Driver<[Movie]> {
    return searchText
      .debounce(0.3, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .flatMapLatest { query -> Observable<[Movie]> in
        print(query)
        guard !query.isEmpty else { return .from([]) }
        return self.provider
          .request(TheMovieDB.search(type: .movies, query: query))
          .mapArray(rootKey: "results")
          .catchError { error in .just([]) }
      }
      .asDriver(onErrorJustReturn: [])
  }
  
  var input: MovieSearchViewModelInput { return self }
  var output: MovieSearchViewModelOutput { return self }
}
