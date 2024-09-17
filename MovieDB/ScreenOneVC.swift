import UIKit
import Kingfisher

class ScreenOneVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel = MoviesViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getPopularMovies()
    }
    
    func setupTableView() {
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MyCustomTableViewCell
        let movie = viewModel.movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.voteLabel.text = "\(movie.vote_average)"
        
        if let posterPath = movie.poster_path {
            let posterURL = URL(string: "\(Constants.imageBaseURL)\(posterPath)")
            cell.posterIV.kf.setImage(with: posterURL)
        }
        
        /*let genreNames = movie.genre_ids.compactMap { genreID in
            genres.first { $0.id == genreID }?.name
        }
        cell.genreLabel.text = genreNames.joined(separator: ", ")*/
        
        cell.detailsButton.tag = indexPath.row
        //cell.detailsButton.addTarget(self, action: #selector(showMovieDetails(_:)), for: .touchUpInside)
        
        return cell
    }
    
}

extension ScreenOneVC: moviesDelegate {
    func didGetMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
