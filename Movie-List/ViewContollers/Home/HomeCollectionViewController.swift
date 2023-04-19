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

    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>?
    fileprivate static let headerTitleSectionKind = "headerTitleSectionKind"

    private var homeViewModel: HomeViewModel?
    private var apiEnvironment: APIEnvironment.MoviesURL?

    private var topRatedMovies: [Movie]?
    private var popularMovies: [Movie]?
    private var nowPlayingMovies: [Movie]?

    private let environment = APIEnvironment()

    private var subscription: Set<AnyCancellable> = []


    private enum Section: String, CaseIterable {
        case topRated = "Top Rated"
        case popular = "Popular"
        case nowPlaying = "Now Playing"
    }

    let reuseIdentifier = "cell"

    // MARK: - View Controller Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiService = MovieAPIService(environmentAPI: environment)
        homeViewModel = HomeViewModel(apiService: apiService)

        let xib = UINib(nibName: "MovieCell", bundle: .main)
        collectionView.register(xib, forCellWithReuseIdentifier: MovieCell.reuseId)
        collectionView.collectionViewLayout = makeCollectionView()

        setUpBinding()
        configureDataSource()
    }

    // MARK: - Private Methods

    private func makeCollectionView() -> UICollectionViewLayout {
        let sectionProvider = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            _ = self?.dataSource?.snapshot().sectionIdentifiers[sectionIndex]

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous

            let titleHeaderLayout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(24))
            let titleHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleHeaderLayout, elementKind: Self.headerTitleSectionKind, alignment: .top)

            section.boundarySupplementaryItems = [titleHeader]

            return section
        }
        return sectionProvider
    }

    private func configureDataSource() {
        let xib = UINib(nibName: "MovieCell", bundle: .main)

        let movieCellRegistration = UICollectionView.CellRegistration<MovieCell, Movie>(cellNib: xib) { cell, _,  movie in
            cell.update(movie)
        }
        
        let titleHeaderRegistration = UICollectionView.SupplementaryRegistration<HomeSectionHeaderView>(supplementaryNib: UINib(nibName: "HomeSectionHeaderView", bundle: .main), elementKind: Self.headerTitleSectionKind) { supplementaryView, elementKind, indexPath in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            supplementaryView.titleLabel.text = section?.rawValue
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) {(collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: movieCellRegistration, for: indexPath, item: item)
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, _, indexPath) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: titleHeaderRegistration, for: indexPath)
        }
    }


    private func setUpBinding() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()

        homeViewModel?.topRatedMoviesPublisher
            .sink(receiveCompletion: { _ in
                print("error")
            }, receiveValue: { [weak self] topRatedMovies in
                snapshot.appendSections([.topRated])
                self?.dataSource?.apply(snapshot)
                snapshot.appendItems(topRatedMovies)
            }).store(in: &subscription)

        homeViewModel?.popularMoviesPublisher
            .sink(receiveCompletion: { _ in
                print("error")
            }, receiveValue: { [weak self] popularMovies in
                snapshot.appendSections([.popular])
                self?.dataSource?.apply(snapshot)
                snapshot.appendItems(popularMovies)
            }).store(in: &subscription)

        homeViewModel?.nowPlayingMoviesPublisher
            .sink(receiveCompletion: { _ in
                print("error")
            }, receiveValue: { [weak self] nowPlayingMovies in
                snapshot.appendSections([.nowPlaying])
                self?.dataSource?.apply(snapshot)
                snapshot.appendItems(nowPlayingMovies)
            }).store(in: &subscription)
    }
}
