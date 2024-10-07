protocol MoviesUseCaseProtocol: AnyObject{
    var delegate : MoviesUseCaseDelegate? {get set}
    func fetchPopularMovies()
    func fetchGenres()
}

protocol MoviesUseCaseDelegate: AnyObject{
    func didFetchMovies(_ movies: [Movie])
    func didFetchGenres(_ genres: [Genre])
}

class MoviesUseCase: MoviesUseCaseProtocol {
    
    weak var delegate : MoviesUseCaseDelegate?
    
    let movieService = MovieService()
    
    func fetchPopularMovies() {
        movieService.getPopularMovies { [weak self] movies in
            guard let self = self, let movies = movies else {return}
            self.delegate?.didFetchMovies(movies)
        }
    }
    
    func fetchGenres() {
        movieService.getGenres { [weak self] genres in
            guard let self = self, let genres = genres else {return}
            self.delegate?.didFetchGenres(genres)
        }
    }
}
