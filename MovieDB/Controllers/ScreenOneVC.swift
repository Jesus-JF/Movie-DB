import UIKit
import Kingfisher

class ScreenOneVC: UIViewController{
    
    var viewModel : MoviesViewModelProtocol
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getPopularMovies()
        viewModel.getGenres()
        self.title = "Movies"
    }
    
    init(viewModel: MoviesViewModelProtocol){
        self.viewModel = viewModel
        super.init(nibName: "ScreenOneVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init error")
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
}
//
extension ScreenOneVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MyCustomTableViewCell
        let movie = viewModel.getMovieByIndex(index: indexPath.row)
        
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
        viewModel.goToDetail(index: indexPath.row)
    }

}

