import MoviehubFramework
import PlaygroundSupport
import UIKit

let vc = MovieSearchViewController()
vc.title = "Search for a movie"
let navVc = UINavigationController(rootViewController: vc)

let tabVc = UITabBarController(nibName: nil, bundle: nil)
tabVc.setViewControllers([navVc, UIViewController()], animated: false)

PlaygroundPage.current.liveView = tabVc

