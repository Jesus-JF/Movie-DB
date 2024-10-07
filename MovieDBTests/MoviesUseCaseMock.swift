//
//  MoviesUseCaseMock.swift
//  MovieDBTests
//
//  Created by Jhonatan Chavez on 6/10/24.
//

import Foundation
import UIKit
@testable import MovieDB

class MoviesUseCaseMock: MoviesUseCaseProtocol{
    var delegate: MoviesUseCaseDelegate?
    var didGotoPopularMovies : Bool = false
    var didGotToGenres : Bool = false
    var movies : [Movie]?
    var genre : [Genre]?
    
    func fetchPopularMovies() {
        self.didGotoPopularMovies = true

    }
    
    func fetchGenres() {
        didGotToGenres = true
    }
    
    
}
