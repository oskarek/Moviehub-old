//
//  SwiftStdlibExtensions.swift
//  MoviehubFramework
//
//  Created by Oskar Ek on 2019-06-03.
//  Copyright © 2019 Oskar Ek. All rights reserved.
//

import Foundation
import Prelude

extension Dictionary: Semigroup {
  public static func <> (lhs: Dictionary, rhs: Dictionary) -> Dictionary {
    return lhs.merging(rhs, uniquingKeysWith: { a,b in a })
  }
}

extension Dictionary: Monoid {
  public static var empty: Dictionary {
    return [:]
  }
}
