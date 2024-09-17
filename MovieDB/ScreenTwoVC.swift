import UIKit
import Kingfisher

class ScreenTwoVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var backdropIV: UIImageView!
    
    var movie: Movie?
    var genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        voteLabel.text = "\(movie.vote_average)"
        overviewLabel.text = "About movie:\n\n\(movie.overview)"
        dateLabel.text = movie.release_date
        
        if let posterPath = movie.poster_path {
            let posterURL = URL(string: "\(Constants.imageBaseURL)\(posterPath)")
            posterIV.kf.setImage(with: posterURL)
        }
        
        if let backdropPath = movie.backdrop_path {
            let backdropURL = URL(string: "\(Constants.imageBaseURL)\(backdropPath)")
            backdropIV.kf.setImage(with: backdropURL)
        }
        
        let genreNames = movie.genre_ids.compactMap { genreID in
            genres.first { $0.id == genreID }?.name
        }
        genreLabel.text = genreNames.joined(separator: ", ")
    }
}


