import Foundation
import UIKit

protocol MoviesRouterProtocol: AnyObject {
    var viewController: UIViewController? {get set}
    func goToMovieDetail(movie: Movie, genres: [Genre])
}

class MoviesRouter: MoviesRouterProtocol{
    var viewController: UIViewController?
    
    func goToMovieDetail(movie:Movie,genres:[Genre]){
        let detailsVC = ScreenTwoVC(nibName: "ScreenTwoVC", bundle: nil)
        detailsVC.movie = movie
        detailsVC.genres = genres
        //print(viewController)
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
