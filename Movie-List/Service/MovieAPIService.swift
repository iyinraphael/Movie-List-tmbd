//
//  MovieAPIService.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/6/23.
//

import Foundation
import Combine

class MovieAPIService: APIService {

    // MARK: - Private Properties
    @Published private(set) var topRatedMovie: MovieTMBD?
    @Published private(set) var apiServiceErrorPublisher: APIServiceError?

    private var urlSessionDataTask: URLSessionDataTask?
    private var urlSessionPublisherDataTask: URLSession.DataTaskPublisher?

    // MARK: - Public Properties
    private let environmentAPI: APIEnvironment

    // MARK: - Initialize Struct

    init(environmentAPI: APIEnvironment) {
        self.environmentAPI = environmentAPI
    }

    // MARK: - Private Methods

    private func url(for parameters: [URLQueryItem], urlPath: String ) -> URL? {
        //        let urlPath = service.baseURL

        guard let baseURL = URL(string: urlPath) else { return nil }

        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponent?.queryItems = parameters

        return urlComponent?.url
    }

    private func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch let error {
            apiServiceErrorPublisher = .decodeFailure
            print("Got decoding error: \(error)")
            throw error
        }
    }

    private func fetchMovieTMBD(_ data: Data?, response: URLResponse?, error: Error?) -> AnyPublisher<MovieTMBD, APIServiceError> {

        if let error = error {
            apiServiceErrorPublisher = .networkFailure
            print("Unable to fetch top rated movies \(error)")

            return Future { p in
                p(.failure(.networkFailure))
            }.eraseToAnyPublisher()
        }

        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            return Future { p in
                p(.failure(.networkFailure))
            }.eraseToAnyPublisher()
        }

        guard let data = data else {
            return Future { p in
                p(.failure(.noDataFailure))
            }.eraseToAnyPublisher()
        }

        return Just(data)
            .tryMap { [weak self] data in
                try self!.decode(MovieTMBD.self, from: data)
            }
            .mapError { $0 as! APIServiceError }
            .eraseToAnyPublisher()
        //
        //        if let data = data, let response = response as? HTTPURLResponse {
        //            if response.statusCode == 200 {
        //                return Just(data)
        //                    .tryMap { [weak self] data in
        //                        try self?.decode(MovieTMBD, from: data)
        //                    }
        //            }
        //        }
    }

    // MARK: - Public Methods

    func getMovies(for environment: APIEnvironment.MoviesURL) ->  AnyPublisher<[Movie], APIServiceError> {


        let apikey = self.environmentAPI.apiKey()
        let parameters = [URLQueryItem(name: "api_key", value: apikey)]

        let urlPath = environment.baseURL

        guard let url = self.url(for: parameters, urlPath: urlPath) else {
            fatalError()
        }

        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieTMBD.self, decoder: JSONDecoder())
            .mapError { _ -> APIServiceError in
                return APIServiceError.networkFailure
            }
            .map { $0.results }
            .eraseToAnyPublisher()
    }


//        urlSessionDataTask =  URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
//            self.fetchMovieTMBD(data, response: response, error: error)
//        })
//
//        urlSessionDataTask?.resume()
    }

