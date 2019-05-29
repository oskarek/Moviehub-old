//
//  MovieSearchViewController.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-02-06.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class MovieSearchViewController: CustomViewController<MovieSearchView> {
  
  private let disposeBag = DisposeBag()
  
  public override init() { super.init() }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("this view controller can't be used with Storyboards")
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }
  
  private func bindViewModel() {
    let (moviesResult, _) = movieSearchViewModel(searchText: customView.rx.searchQuery.orEmpty)
    
    moviesResult
      .map { "\($0.first?.title ?? "") \($0.first?.releaseDate ?? "")" }
      .drive(customView.rx.movieText)
      .disposed(by: disposeBag)
  }

}
