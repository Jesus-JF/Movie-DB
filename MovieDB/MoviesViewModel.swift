protocol moviesDelegate: AnyObject {
    func didGetMovies()
}


class MoviesViewModel {
    
    var movieService = MovieService()
    var movies: [Movie] = []
    
    var delegate: moviesDelegate?
    
    func getPopularMovies() {
        movieService.getPopularMovies { movies in
            if let movies {
                self.movies = movies
                self.delegate?.didGetMovies()}
        }
    }

}
