//
//  MovieViewModelTests.swift
//  MovieDBTests
//
//  Created by Jhonatan Chavez  on 4/10/24.
//

import XCTest
@testable import MovieDB

final class MovieViewModelTests: XCTestCase {
    
    var sut: MoviesViewModel!
    var moviesRouter: MoviesRouterMock!
    
    override func setUpWithError() throws {
        moviesRouter = MoviesRouterMock()
        sut = MoviesViewModel(moviesRouter: moviesRouter)
    }

    override func tearDownWithError() throws {
        sut = nil
        moviesRouter = nil
    }
    
    func test_getMovieByIndex(){
        // Given
        let movie1 = Movie(title: "Movie 1", vote_average: 5.0, genre_ids: [1], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")
        let movie2 =
        Movie(title: "Movie 2", vote_average: 4.0, genre_ids: [1 , 3], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")
        sut.movies = [movie1,movie2]
        
        // When
        let movie = sut.getMovieByIndex(index: 0)
        
        // Then
        
        XCTAssertEqual(movie1.title, movie.title)
    }
    
    func test_routerIsCalled() {
        // Given
        sut.movies = [Movie(title: "Movie 1", vote_average: 5.0, genre_ids: [1], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04"),
                      Movie(title: "Movie 2", vote_average: 4.0, genre_ids: [1 , 3], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")]
        // When
        sut.goToDetail(index: 0)
        //Then
        XCTAssertEqual(moviesRouter.didGoToMovieDetail, true)
        
    }
    
    func test_routerPassCorrectMovie() throws {
        // Given
        let movie1 = Movie(title: "Movie 1", vote_average: 5.0, genre_ids: [1], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")
        let movie2 =
        Movie(title: "Movie 2", vote_average: 4.0, genre_ids: [1 , 3], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")
        sut.movies = [movie1,movie2]
        // When
        sut.goToDetail(index: 0)
        //Then
        let moviefromRouter = try XCTUnwrap(moviesRouter.movie)
        XCTAssertEqual(sut.getMovieByIndex(index: 0).title, moviefromRouter.title)
    }
    


}
