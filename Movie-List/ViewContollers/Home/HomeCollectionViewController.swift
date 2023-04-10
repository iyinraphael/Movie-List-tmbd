//
//  HomeCollectionViewController.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/4/23.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {

    let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        let environment = APIEnvironment(movieURL: .topRated)

        let apiService = MovieAPIService(environmentAPI: environment)

        apiService.getTopRatedMoves()

    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)


        return cell
    }

}
