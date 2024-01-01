//
//  MoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import UIKit

class MoviesTableViewCell: UITableViewCell, MovieDetailsViewModelObserver {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    var viewModel: MovieCellViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.movieTitleLabel.font = UIFont(name: "Arial-BoldMT", size: 18)
        self.movieTitleLabel.textColor = .black
        self.movieOverviewLabel.font = UIFont(name: "ArialMT", size: 14)
        self.movieOverviewLabel.textColor = .gray
        self.moviePosterImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellLabelsElement() {
        guard let viewModel else {
            return
        }
        DispatchQueue.main.async {
            self.movieTitleLabel.text = viewModel.getMovieTitle()
            self.movieOverviewLabel.text = viewModel.getMovieOverview()
        }
    }
    
    func setCellImageElement() {
        DispatchQueue.main.async {
            self.moviePosterImageView.image = UIImage(systemName: "photo")
        }
        self.viewModel?.loadMoviePoster()
    }
    
    func handlePosterLoadedNotification(wasSuccess: Bool) {
        guard let poster = self.viewModel?.getMoviePoster() else {
            return
        }
        DispatchQueue.main.async {
            self.moviePosterImageView.image = poster
        }
    }
    
}
