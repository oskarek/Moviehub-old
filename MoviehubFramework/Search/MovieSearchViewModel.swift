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
import RxMoya
import Argo

public func movieSearchViewModel(
  searchText: ControlProperty<String>
  ) -> (
  mediaItemsResult: Driver<[MediaItem]>,
  placeholder: Bool
  ) {
  let mediaItemsRes: Driver<[MediaItem]> = searchText.asDriver()
    .debounce(.milliseconds(300))
    .distinctUntilChanged()
    .flatMapLatest { query in
      guard !query.isEmpty else { return .just([]) }
      return Current.provider.rx
        .request(.search(type: .multi, query: query))
        .mapArray(rootKey: "results")
        .debug()
        .asDriver(onErrorJustReturn: [])
    }

  return (mediaItemsResult: mediaItemsRes, placeholder: false)
}
