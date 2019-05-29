//
//  CustomView.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-03-31.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import UIKit

public class CustomView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews()
    setupLayout()
  }
  
  required init() {
    super.init(frame: .zero)
    addSubviews()
    setupLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("this view can't be used with Storyboards")
  }
  
  func addSubviews() {
    // should be overridden
  }
  
  func setupLayout() {
    // should be overridden
  }

}
