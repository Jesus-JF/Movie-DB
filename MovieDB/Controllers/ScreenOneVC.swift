import UIKit
import Kingfisher

class ScreenOneVC: UIViewController{
    
    
    let viewModel = MoviesViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        viewModel.getPopularMovies()
        viewModel.getGenres()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func setupViewModel() {
        viewModel.delegate = self
    }
    

//    @objc func showMovieDetails(_ sender: UIButton) {
//        let selectedMovie = viewModel.movies[sender.tag]
//        
//        let detailsVC = ScreenTwoVC(nibName: "ScreenTwoVC", bundle: nil)
//        detailsVC.movie = selectedMovie
//        detailsVC.genres = viewModel.genres
//        
//        navigationController?.pushViewController(detailsVC, animated: true)
//    }

}

extension ScreenOneVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MyCustomTableViewCell
        let movie = viewModel.movies[indexPath.row]
        
        cell.delegate = self
        cell.configure(with: movie, genres: viewModel.getGenreNames(for: movie))
        
        return cell
    }
}

extension ScreenOneVC: MoviesDelegate {
    func didGetMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didGetGenres() {
    }
}

extension ScreenOneVC: MyCustomTableViewCellDelegate {
    func didTappedButton(in cell: MyCustomTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let selectedMovie = viewModel.movies[indexPath.row]

        let detailsVC = ScreenTwoVC(nibName: "ScreenTwoVC", bundle: nil)
        detailsVC.movie = selectedMovie
        detailsVC.genres = viewModel.genres
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }

}

