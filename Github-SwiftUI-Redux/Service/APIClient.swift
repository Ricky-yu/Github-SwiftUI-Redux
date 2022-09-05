//
//  APIClient.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//
import Foundation

final class APIClient {

    private let baseURL: URL

    init(baseURL: URL = URL(string: "https://api.github.com")!) {
        self.baseURL = baseURL
    }

    func searchGithubRepository(repositroyName: String, page: Int = 1) async throws -> SearchRepositoryResponse {
        let pathURL = URL(string: "/search/repositories", relativeTo: baseURL)!
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            .init(name: "q", value: repositroyName),
            .init(name: "page", value: "\(page)")
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknownError
        }

        switch httpResponse.statusCode {
        case 404:
            throw APIError.responseError
        case 422:
            throw APIError.responseError
        default:
            break
        }
        
        do {
            let list = try JSONDecoder().decode(SearchRepositoryResponse.self, from: data)
            return list
        } catch {
            throw APIError.jsonParseError
        }
    }
}
