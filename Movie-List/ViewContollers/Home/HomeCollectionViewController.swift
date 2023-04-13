//
//  HomeCollectionViewController.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/4/23.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {

    // MARK: Private Properties

    private var dataSource: UICollectionViewDiffableDataSource<String, [Movie]>?
    fileprivate static let headerTitleSectionKind = "headerTitleSectionKind"

    enum Section: CaseIterable {
        case topRated
        case popular
        case nowPlaying
    }

    let reuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
//        let environment = APIEnvironment(movieURL: .topRated)
//
//        let apiService = MovieAPIService(environmentAPI: environment)
//
//        apiService.getTopRatedMoves()

        let xib = UINib(nibName: MovieCell.description(), bundle: .main)
        collectionView.register(xib, forCellWithReuseIdentifier: MovieCell.reuseId)
        collectionView.collectionViewLayout = makeCollectionView()
    }

    // MARK: - Private Methods

    private func makeCollectionView() -> UICollectionViewLayout {
        let sectionProvider = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            _ = self?.dataSource?.snapshot().sectionIdentifiers[sectionIndex]

            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(150))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)


            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            let titleHeaderLayout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let titleHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleHeaderLayout, elementKind: Self.headerTitleSectionKind, alignment: .top)

            section.boundarySupplementaryItems = [titleHeader]

            return section
        }
        return sectionProvider
    }

    private func configureDataSource() {
        let xib = UINib(nibName: MovieCell.description(), bundle: .main)
        let movieCell = UICollectionView.CellRegistration<MovieCell, [Movie]>(cellNib: xib) { cell, indexPath,  movies in
            let movie = movies[indexPath.item]
            cell.update(movie)
        }
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
