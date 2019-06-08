//
//  MovieSearchView.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-03-31.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Prelude
import Optics

public class MovieSearchView: CustomView {

  let searchField: UISearchBar = UISearchBar()
    |> \.translatesAutoresizingMaskIntoConstraints .~ false
    |> \.autocorrectionType .~ .no
    |> \.keyboardAppearance .~ .dark
  
  let displayLabel: UILabel = UILabel()
    |> \.translatesAutoresizingMaskIntoConstraints .~ false
    |> \.textColor .~ .orange
    |> \.numberOfLines .~ 0
  
  let topLevelStackView: UIStackView = UIStackView()
    |> \.translatesAutoresizingMaskIntoConstraints .~ false
    |> \.alignment .~ .fill
    |> \.axis .~ .vertical
  
  override func addSubviews() {
    addSubview(topLevelStackView)
  }
  
  override func setupLayout() {
    setupStackViewLayout()
  }
  
  private func setupStackViewLayout() {
    topLevelStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    topLevelStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    topLevelStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    topLevelStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    // temporary filler view
    let fillerView = UIView()
    fillerView.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .vertical)
    
    [searchField, displayLabel, fillerView]
      .forEach { view in topLevelStackView.addArrangedSubview(view) }
  }

}

extension Reactive where Base : MovieSearchView {
  var searchQuery: ControlProperty<String?> {
    return base.searchField.rx.text
  }
  
  var movieText: Binder<String?> {
    return base.displayLabel.rx.text
  }
}
