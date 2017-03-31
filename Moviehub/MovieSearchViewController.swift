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

class MovieSearchViewController: CustomViewController<MovieSearchView> {
  
  private let disposeBag = DisposeBag()
  
  private let viewModel: MovieSearchViewModelType
  
  init(viewModel: MovieSearchViewModelType) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("this view controller can't be used with Storyboards")
  }
  
  override func viewDidLayoutSubviews() {
//    print("StackView: \(customView.topLevelStackView)")
//    customView.topLevelStackView.arrangedSubviews.forEach { view in print("Subview: \(view)") }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindUIToViewModel()
    bindViewModelToUI()
  }
  
  private func bindViewModelToUI() {
    viewModel.output.moviesResult
      .map { movies in "\(movies.first?.title ?? "") \(movies.first?.releaseDate ?? "")" }
      .drive(customView.rx.movieText)
      .disposed(by: disposeBag)
  }
  
  private func bindUIToViewModel() {
    customView.rx.searchQuery.orEmpty
      .bindTo(viewModel.input.searchText)
      .disposed(by: disposeBag)
  }
  
}
