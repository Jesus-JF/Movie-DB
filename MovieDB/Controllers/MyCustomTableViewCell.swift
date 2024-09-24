import UIKit

protocol MyCustomTableViewCellDelegate: AnyObject{
    func didTappedButton(in cell:MyCustomTableViewCell)
}
class MyCustomTableViewCell: UITableViewCell {
    
    weak var delegate: MyCustomTableViewCellDelegate?

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var ticketIcon: UIImageView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundTwoIV: UIView!
    
    
    @IBAction func detailsButtonTapped(_ sender: UIButton) {
        delegate?.didTappedButton(in: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundTwoIV.layer.cornerRadius = 20
        backgroundTwoIV.layer.masksToBounds = true
    }
    
    func configure(with movie: Movie, genres: String) {
        titleLabel.text = movie.title
        voteLabel.text = "\(movie.vote_average)"
        genreLabel.text = genres
        
        if let posterPath = movie.poster_path {
            let posterURL = URL(string: "\(Constants.imageBaseURL)\(posterPath)")
            posterIV.kf.setImage(with: posterURL)
        }
    }
}

