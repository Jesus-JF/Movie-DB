import UIKit
import Kingfisher

class ScreenOneVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var movieService = MovieService()
    var movies: [Movie] = []
    var genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchMoviesAndGenres()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func fetchMoviesAndGenres() {
        movieService.getPopularMovies { [weak self] movies in
            guard let self = self else { return }
            self.movies = movies ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        movieService.getGenres { [weak self] genres in
            guard let self = self else { return }
            self.genres = genres ?? []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MyCustomTableViewCell
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.voteLabel.text = "\(movie.vote_average)"
        
        if let posterPath = movie.poster_path {
            let posterURL = URL(string: "\(Constants.imageBaseURL)\(posterPath)")
            cell.posterIV.kf.setImage(with: posterURL)
        }
        
        let genreNames = movie.genre_ids.compactMap { genreID in
            genres.first { $0.id == genreID }?.name
        }
        cell.genreLabel.text = genreNames.joined(separator: ", ")
        
        cell.detailsButton.tag = indexPath.row
        cell.detailsButton.addTarget(self, action: #selector(showMovieDetails(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func showMovieDetails(_ sender: UIButton) {
        let selectedMovie = movies[sender.tag]
        
        let detailsVC = ScreenTwoVC(nibName: "ScreenTwoVC", bundle: nil)
        detailsVC.movie = selectedMovie
        detailsVC.genres = genres // Pasar los géneros
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
