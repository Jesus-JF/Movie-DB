import Foundation
import UIKit

class MoviesRouter{
    var viewController: UIViewController?
    
    func goToMovieDetail(movie:Movie,genres:[Genre]){
        
        let detailsVC = ScreenTwoVC(nibName: "ScreenTwoVC", bundle: nil)
        detailsVC.movie = movie
        detailsVC.genres = genres
        //print(viewController)
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
        
        
    }
}
