protocol MoviesDelegate: AnyObject {
    func didGetMovies()
    func didGetGenres()
}

class MoviesViewModel {
    
    var movieService = MovieService()
    var movies: [Movie] = []
    var genres: [Genre] = []
    
    weak var delegate: MoviesDelegate?
    
    func getPopularMovies() {
        movieService.getPopularMovies { [weak self] movies in
            guard let self = self else { return }
            if let movies {
                self.movies = movies
                self.delegate?.didGetMovies()
            }
        }
    }
    
    func getGenres() {
        movieService.getGenres { [weak self] genres in
            guard let self = self else { return }
            if let genres {
                self.genres = genres
                self.delegate?.didGetGenres()
            }
        }
    }
    
    func getGenreNames(for movie: Movie) -> String {
        let genreNames = movie.genre_ids.compactMap { genreID in
            genres.first { $0.id == genreID }?.name
        }
        return genreNames.joined(separator: ", ")
    }
}
