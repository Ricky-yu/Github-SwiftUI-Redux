//
//  SearchRepositoryResponse.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import Foundation

struct SearchRepositoryResponse: Codable {
    let items: [GithubRepository]
}
