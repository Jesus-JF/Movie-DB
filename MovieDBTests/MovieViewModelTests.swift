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
    var moviesUseCase : MoviesUseCaseMock!
    
    override func setUpWithError() throws {
        moviesRouter = MoviesRouterMock()
        moviesUseCase = MoviesUseCaseMock()
        sut = MoviesViewModel(moviesRouter: moviesRouter, moviesUseCase: moviesUseCase)
    }

    override func tearDownWithError() throws {
        sut = nil
        moviesRouter = nil
        moviesUseCase = nil
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
    
    func test_routerPassGenders() throws {
        //Given
        let movie1 = Movie(title: "Movie 1", vote_average: 5.0, genre_ids: [1], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")
        let genre1 = Genre(id: 0, name: "Terror")
        let genre2 = Genre(id: 1, name: "Romance")
        
        sut.movies = [movie1]
        sut.genres = [genre1, genre2]
        //When
        sut.goToDetail(index: 0)
        //Then
        let movieFromRouter = try XCTUnwrap(moviesRouter.genres?[0])
        XCTAssertEqual(sut.genres[0].id, movieFromRouter.id)
    }
    
    func test_getGenreNamesForOneID() {
        //Given
        let movie1 = Movie(title: "Movie 1", vote_average: 5.0, genre_ids: [0], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")
        let movie2 =
        Movie(title: "Movie 2", vote_average: 4.0, genre_ids: [0, 1], poster_path: "path", overview: "overview", backdrop_path: "backdrop", release_date: "2024-10-04")
        let genre1 = Genre(id: 0, name: "Terror")
        let genre2 = Genre(id: 1, name: "Romance")
        sut.movies = [movie1,movie2]
        sut.genres = [genre1, genre2]

        //When
        let genreNames = sut.getGenreNames(for: movie1)
        
        //Then
        XCTAssertEqual(sut.genres[0].name, genreNames)
        
        
    }

    func test_getPopularMoviesisCalled() {
        
        // When
        sut.getPopularMovies()
        //Then
        XCTAssertEqual(moviesUseCase.didGotoPopularMovies, true)
    }
    
    func test_getGenres(){
        
        // When
        sut.getGenres()
        //Then
        XCTAssertEqual(moviesUseCase.didGotToGenres, true)
    }
}
