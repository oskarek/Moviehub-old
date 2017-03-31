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

class MovieSearchView: CustomView {

  lazy var searchField: UISearchBar = {
    var searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.autocorrectionType = .no
    searchBar.keyboardAppearance = .dark
    return searchBar
  }()
  
  lazy var displayLabel: UILabel = {
    var label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .orange
    return label
  }()
  
  lazy var topLevelStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .fill
    stackView.axis = .vertical
    return stackView
  }()
  
  override func addSubviews() {
    addSubview(topLevelStackView)
  }
  
  override func setupLayout() {
    setupStackViewLayout()
  }
  
  private func setupStackViewLayout() {
    topLevelStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    topLevelStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    topLevelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    topLevelStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    // temporary filler view
    let fillerView = UIView()
    fillerView.setContentHuggingPriority(0, for: .vertical)
    
    [searchField, displayLabel, fillerView]
      .forEach { view in topLevelStackView.addArrangedSubview(view) }
  }

}

extension Reactive where Base : MovieSearchView {
  var searchQuery: ControlProperty<String?> {
    return base.searchField.rx.text
  }
  
  var movieText: UIBindingObserver<UILabel, String?> {
    return base.displayLabel.rx.text
  }
}
