//
//  ObservableUtils.swift
//  MoviehubFramework
//
//  Created by Oskar Ek on 2019-05-30.
//  Copyright © 2019 Oskar Ek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Prelude

public func <> <A>(_ lhs: Observable<A>, _ rhs: Observable<A>) -> Observable<A> {
  return Observable.merge(lhs, rhs)
}

public func <> <A, B>(_ lhs: SharedSequence<A, B>, _ rhs: SharedSequence<A, B>) -> SharedSequence<A, B> {
  return SharedSequence.merge(lhs, rhs)
}
