//
//  GithubRepository.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import Foundation

struct GithubRepository: Codable, Identifiable, Equatable {
    static func == (lhs: GithubRepository, rhs: GithubRepository) -> Bool {
        lhs.id == rhs.id
    }

    let id: Int
    let repositoryName: String
    let starCount: Int
    let repositoryUrl: String
    let repositoryOwner: GithubRepositoryOwner

    enum CodingKeys: String, CodingKey {
        case id
        case repositoryName = "full_name"
        case starCount = "stargazers_count"
        case repositoryUrl = "html_url"
        case repositoryOwner = "owner"
    }
}
