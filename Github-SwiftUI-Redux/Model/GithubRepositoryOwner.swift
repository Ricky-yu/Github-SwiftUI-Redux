//
//  GithubRepositoryOwner.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import Foundation

struct GithubRepositoryOwner: Codable {
    let repositoryImageUrl: String

    enum CodingKeys: String, CodingKey {
        case repositoryImageUrl = "avatar_url"
    }
}
