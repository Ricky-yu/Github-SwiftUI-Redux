//
//  Action.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//

import Foundation

protocol Action { }

enum SearchRepositoryAction: Action {
    case search(text: String)
    case nextPage
}

enum RepositoryListViewAction: Action {
    case setRepositories([GithubRepository])
    case addRepositories([GithubRepository])
    case onBottomOfList
    case showAlertMessage(message: String)

}
