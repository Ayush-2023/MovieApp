//
//  LoadingMoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 01/01/24.
//

import UIKit

class LoadingMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
