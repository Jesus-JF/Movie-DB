protocol MoviesViewModelProtocol: AnyObject{
    var delegate: MoviesDelegate? {get set}
    var moviesRouter: MoviesRouter {get set}
    var movies: [Movie] {get}
    var genres: [Genre] {get}
    func getPopularMovies()
    func getGenres()
    func getMovieByIndex(index:Int) -> Movie
    func getGenreNames(for movie: Movie) -> String
    func goToDetail(index:Int)
    
}

protocol MoviesDelegate: AnyObject {
    func didGetMovies()
    func didGetGenres()
}

class MoviesViewModel : MoviesViewModelProtocol {
    
    weak var delegate: MoviesDelegate?
    
    var moviesRouter = MoviesRouter()
    var moviesUseCase = MoviesUseCase()
    
    var movies: [Movie] = []
    var genres: [Genre] = []
   
    func getPopularMovies() {
        moviesUseCase.delegate = self
        moviesUseCase.fetchPopularMovies()
    }
    
    func getGenres() {
        moviesUseCase.delegate = self
        moviesUseCase.fetchGenres()
    }
    
    func getMovieByIndex(index:Int)-> Movie {
        return movies[index]
    }
    
    func getGenreNames(for movie: Movie) -> String {
        let genreNames = movie.genre_ids.compactMap { genreID in
            genres.first { $0.id == genreID }?.name
        }
        return genreNames.joined(separator: ", ")
    }
    
    func goToDetail(index:Int){
        moviesRouter.goToMovieDetail(movie: movies[index], genres: genres)
    }
}

extension MoviesViewModel: MoviesUseCaseDelegate {
    func didFetchMovies(_ movies: [Movie]) {
        self.movies = movies
        self.delegate?.didGetMovies()
    }
    
    func didFetchGenres(_ genres: [Genre]) {
        self.genres = genres
        self.delegate?.didGetGenres()
    }
}
