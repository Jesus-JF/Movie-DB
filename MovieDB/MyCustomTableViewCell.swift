import UIKit

class MyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var ticketIcon: UIImageView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundTwoIV: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundTwoIV.layer.cornerRadius = 20
        backgroundTwoIV.layer.masksToBounds = true
    }


}
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//    
//    func configure(with movie: Movie, genres: [String]) {
//        titleLabel.text = movie.title
//        voteLabel.text = "\(movie.voteAverage)"
//        
//        let movieGenres = movie.genreIDs.compactMap { genreMap[$0] }
//        genreLabel.text = movieGenres.joined(separator: ", ")
//
//        if let posterPath = movie.posterPath {
//            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
//            posterIV.kf.setImage(with: imageUrl)
//        }
//    }
//}
