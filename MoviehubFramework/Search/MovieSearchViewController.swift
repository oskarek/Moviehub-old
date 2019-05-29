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
  
  private let viewModel: MovieSearchViewModelType
  
  public init(viewModel: MovieSearchViewModelType) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("this view controller can't be used with Storyboards")
  }
  
  override public func viewDidLayoutSubviews() {
//    print("StackView: \(customView.topLevelStackView)")
//    customView.topLevelStackView.arrangedSubviews.forEach { view in print("Subview: \(view)") }
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    bindUIToViewModel()
    bindViewModelToUI()
  }
  
  private func bindViewModelToUI() {
    viewModel.output.moviesResult
      .map { movies in
        let res = "\(movies.first?.title ?? "") \(movies.first?.releaseDate ?? "")"
        print(movies)
        return res
      }
      .drive(customView.rx.movieText)
      .disposed(by: disposeBag)
  }
  
  private func bindUIToViewModel() {
    customView.rx.searchQuery.orEmpty
      .bind(to: viewModel.input.searchText)
      .disposed(by: disposeBag)
  }
  
}
