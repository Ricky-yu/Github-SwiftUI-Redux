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

    func searchGithubRepository(repositroyName: String) async throws -> SearchRepositoryResponse {
        let pathURL = URL(string: "/search/repositories", relativeTo: baseURL)!
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            .init(name: "q", value: repositroyName.trimmingCharacters(in: .whitespacesAndNewlines))
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                throw APIError.unknownError
        }
        if httpResponse.statusCode == 422 { throw APIError.responseError }
        do {
            let list = try JSONDecoder().decode(SearchRepositoryResponse.self, from: data)
            return list
        } catch {
            throw APIError.jsonParseError
        }
    }
}
