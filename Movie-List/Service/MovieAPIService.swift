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
    @Published private(set) var topRatedMovie: TopRatedMovie?
    @Published private(set) var apiServiceErrorPublisher: APIServiceError?

    private var urlSessionDataTask: URLSessionDataTask?

    // MARK: - Public Properties
    private let environmentAPI: APIEnvironment

    // MARK: - Initialize Struct

    init(environmentAPI: APIEnvironment) {
        self.environmentAPI = environmentAPI
    }

    // MARK: - Private Methods

    private func url(for parameters: [URLQueryItem], service: APIEnvironment.MoviesURL) -> URL? {
        let urlPath = service.baseURL

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

 func fetchTopRatedMovies(_ data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            apiServiceErrorPublisher = .networkFailure
            print("Unable to fetch top rated movies \(error)")
        }

        if let data = data, let response = response as? HTTPURLResponse {
                  if response.statusCode == 200 {

                      self.topRatedMovie = try? self.decode(TopRatedMovie.self, from: data)
            }
        }
    }

    // MARK: - Public Methods

    func getTopRatedMoves() {
        let apikey = self.environmentAPI.apiKey()
        let parameters = [URLQueryItem(name: "api_key", value: apikey)]

        guard let url = self.url(for: parameters, service: .topRated) else { return }

        urlSessionDataTask =  URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            self.fetchTopRatedMovies(data, response: response, error: error)
        })

        urlSessionDataTask?.resume()
    }
}
