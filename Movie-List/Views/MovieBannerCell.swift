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
    @IBOutlet weak var playButton: BaseButton!
    @IBOutlet weak var myListButton: BaseButton!

    @IBOutlet weak var posterImage: UIImageView!
    // MARK: - IBActions
    @IBAction func playMovie(_ sender: BaseButton) {

    }

    @IBAction func AddToMyList(_ sender: BaseButton) {

    }


    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        layer.cornerRadius = 6.0
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
