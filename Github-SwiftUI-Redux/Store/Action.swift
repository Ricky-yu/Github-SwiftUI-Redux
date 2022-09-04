//
//  Action.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//

import Foundation

protocol Action { }

struct searchRepository: Action {
    var nameRepositroy: String
    var page: Int = 0
}

enum RepositoryListViewAction: Action {
    case updateRepositories([GithubRepository])
    case search(text: String)
    case showAlertMessage(message: String)

}
