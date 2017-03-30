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

class MovieSearchViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  private let viewModel = MovieSearchViewModel()
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var displayLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindUIToViewModel()
    bindViewModelToUI()
  }
  
  private func bindViewModelToUI() {
    viewModel.output.moviesResult
      .map { movies in "\(movies.first?.title ?? "") \(movies.first?.releaseDate ?? "")" }
      .drive(displayLabel.rx.text)
      .disposed(by: disposeBag)
  }
  
  private func bindUIToViewModel() {
    searchBar.rx.text.orEmpty
      .bindTo(viewModel.input.searchText)
      .disposed(by: disposeBag)
  }
  
}
