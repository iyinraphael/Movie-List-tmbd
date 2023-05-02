//
//  MovieBannerViewCell.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/24/23.
//

import UIKit

class MovieBannerCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var myListButton: UIButton!

    // MARK: - IBActions
    @IBAction func playMovie(_ sender: UIButton) {
    }

    @IBAction func AddToMyList(_ sender: UIButton) {
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(_ movie: Movie) {

    }
}
