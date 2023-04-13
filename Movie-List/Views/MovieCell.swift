//
//  MovieCell.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/11/23.
//

import UIKit

class MovieCell: UICollectionViewCell {

    static let reuseId = "MovieCell"

    @IBOutlet weak var posterImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func update(_ movie: Movie) {

    }

}
