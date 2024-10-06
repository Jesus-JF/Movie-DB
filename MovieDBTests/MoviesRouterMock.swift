//
//  MoviesRouterMock.swift
//  MovieDBTests
//
//  Created by Jhonatan Chavez  on 4/10/24.
//

@testable import MovieDB
import UIKit

class MoviesRouterMock: MoviesRouterProtocol {
    var viewController: UIViewController?
    var didGoToMovieDetail: Bool = false
    var movie: Movie?
    
    func goToMovieDetail(movie: Movie, genres: [Genre]) {
        self.didGoToMovieDetail = true
        self.movie =  movie
    }
}
