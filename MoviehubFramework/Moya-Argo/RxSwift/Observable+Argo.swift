//
//  Observable+Argo.swift
//  Pods
//
//  Created by Sam Watts on 23/01/2016.
//
//

import Foundation
import Moya
import RxSwift
import Argo

/// Extension on ObservableTypes containing Moya responses
/// used to map to stream of objects decoded with Argo
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
  
  /**
   Map stream of responses into stream of objects decoded via Argo
   
   - parameter type:    Type used to make mapping more explicit. This isnt required, but means type needs to be specified at use
   - parameter rootKey: optional root key of JSON used for mapping
   
   - returns: returns Observable of mapped objects
   */
  func mapObject<T: Argo.Decodable>(type: T.Type, rootKey: String? = nil) -> Observable<T> where T == T.DecodedType {
    return flatMap { response -> Single<T> in
      return Single.just(try response.mapObject(rootKey: rootKey))
      }.asObservable()
  }
  
  /// Alternative for mapping object without specifying type as argument
  /// This means type needs to be specified at use
  func mapObject<T: Argo.Decodable>(rootKey: String? = nil) -> Observable<T> where T == T.DecodedType {
    return mapObject(type: T.self, rootKey: rootKey)
  }
  
  /// Convenience method for mapping object with root key, accepts non optional root key for some type checking
  func mapObjectWithRootKey<T: Argo.Decodable>(type: T.Type, rootKey: String) -> Observable<T> where T == T.DecodedType {
    return mapObject(type: type, rootKey: rootKey)
  }
  
  /**
   Map stream of responses into stream of object array decoded via Argo
   
   - parameter type:    Type used to make mapping more explicit. This isnt required, but means type needs to be specified at use
   - parameter rootKey: optional root key of JSON used for mapping
   
   - returns: returns Observable of mapped object array
   */
  func mapArray<T: Argo.Decodable>(type: T.Type, rootKey: String? = nil) -> Observable<[T]> where T == T.DecodedType {
    return flatMap { response -> Single<[T]> in
      return Single.just(try response.mapArray(rootKey: rootKey))
      }.asObservable()
  }
  
  /// Alternative for mapping object array without specifying type as argument
  /// This means type needs to be specified at use
  func mapArray<T: Argo.Decodable>(rootKey: String? = nil) -> Observable<[T]> where T == T.DecodedType {
    return mapArray(type: T.self, rootKey: rootKey)
  }
  
  /// Convenience method for mapping object array with root key, accepts non optional root key for some type checking
  func mapArrayWithRootKey<T: Argo.Decodable>(type: T.Type, rootKey: String) -> Observable<[T]> where T == T.DecodedType {
    return mapArray(type: type, rootKey: rootKey)
  }
  
}

fileprivate extension AnyObserver {
    
    /// convenience method calling either on(.Next) or on(.Error) depending if a function throws an error or returns a value
  func onNextOrError(function: () throws -> Element) {
        do {
            let value = try function()
            self.onNext(value)
        } catch {
            self.onError(error)
        }
    }
}
