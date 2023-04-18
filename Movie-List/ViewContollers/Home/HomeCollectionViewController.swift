//
//  HomeCollectionViewController.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/4/23.
//

import UIKit
import Combine

class HomeCollectionViewController: UICollectionViewController {

    // MARK: - Private Properties

    private var dataSource: UICollectionViewDiffableDataSource<String, [Movie]>?
    fileprivate static let headerTitleSectionKind = "headerTitleSectionKind"

    private var homeViewModel: HomeViewModel?
    private var apiEnvironment: APIEnvironment.MoviesURL?

    private var topRatedMovies: [Movie]?
    private var popularMovies: [Movie]?
    private var nowPlayingMovies: [Movie]?

    private let environment = APIEnvironment()

    private var subscription: Set<AnyCancellable> = []


    private enum Section: CaseIterable {
        case topRated
        case popular
        case nowPlaying
    }

    let reuseIdentifier = "cell"

    // MARK: - View Controller Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiService = MovieAPIService(environmentAPI: environment)
        homeViewModel = HomeViewModel(apiService: apiService)

        let xib = UINib(nibName: MovieCell.description(), bundle: .main)
        collectionView.register(xib, forCellWithReuseIdentifier: MovieCell.reuseId)
        collectionView.collectionViewLayout = makeCollectionView()

        setUpBinding()
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
        let movieCellRegistration = UICollectionView.CellRegistration<MovieCell, [Movie]>(cellNib: xib) { cell, indexPath,  movies in
            let movie = movies[indexPath.item]
            cell.update(movie)
        }
        
        let titleHeaderRegistration = UICollectionView.SupplementaryRegistration<HomeSectionHeaderView>(supplementaryNib: UINib(nibName: HomeSectionHeaderView.description(), bundle: .main), elementKind: Self.headerTitleSectionKind) { supplementaryView, elementKind, indexPath in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            supplementaryView.titleLabel.text = section
        }
        
        dataSource = UICollectionViewDiffableDataSource<String, [Movie]>(collectionView: collectionView) {(collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: movieCellRegistration, for: indexPath, item: item)
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, _, indexPath) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: titleHeaderRegistration, for: indexPath)
        }
    }


    private func setUpBinding() {
        homeViewModel?.topRatedMoviesPublisher
            .sink(receiveCompletion: { _ in
                print("error")
            }, receiveValue: { [weak self] topRatedMovies in
                self?.topRatedMovies = topRatedMovies
            }).store(in: &subscription)

        homeViewModel?.popularMoviesPublisher
            .sink(receiveCompletion: { _ in
                print("error")
            }, receiveValue: { [weak self] popularMovies in
                self?.popularMovies = popularMovies
            }).store(in: &subscription)

        homeViewModel?.popularMoviesPublisher
            .sink(receiveCompletion: { _ in
                print("error")
            }, receiveValue: { [weak self] popularMovies in
                self?.popularMovies = popularMovies
            }).store(in: &subscription)
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
