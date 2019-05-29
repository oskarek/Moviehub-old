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

let provider = MoyaProvider<TheMovieDB>()

public func movieSearchViewModel(
  searchText: ControlProperty<String>
  ) -> (
  moviesResult: Driver<[Movie]>,
  placeholder: Bool
  ) {
  let moviesRes: Driver<[Movie]> = searchText.asDriver()
    .debounce(.milliseconds(300))
    .distinctUntilChanged()
    .flatMapLatest { query in
      provider.rx
        .request(TheMovieDB.search(type: .movies, query: query))
        .mapArray(rootKey: "results")
        .asDriver(onErrorJustReturn: [])
    }
    
  return (moviesResult: moviesRes, placeholder: false)
}
