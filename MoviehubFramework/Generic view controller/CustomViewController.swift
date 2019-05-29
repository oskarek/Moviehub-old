//
//  CustomViewController.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-03-31.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import UIKit

public class CustomViewController<T: CustomView>: UIViewController {

  var customView: T { return view as! T }
  
  override public func loadView() {
    view = T()
  }
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
