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
        layer.masksToBounds = true
        layer.cornerRadius = 4.0
    }

    func update(_ movie: Movie) {
        let pathUrl = movie.posterPath
        let baseString = "https://image.tmdb.org/t/p/w185\(pathUrl)"

        DispatchQueue.global(priority: .background).async {
            guard let imageUrl = URL(string: baseString),
                  let imageData = try? Data(contentsOf: imageUrl)else {  fatalError("unable to fetch image") }

            DispatchQueue.main.async { [weak self] in
                if let image = UIImage(data: imageData) {
                    self?.posterImage.image = image
                }
            }
        }
    }

}
