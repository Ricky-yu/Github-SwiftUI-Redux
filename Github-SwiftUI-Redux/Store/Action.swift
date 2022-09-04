//
//  Action.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//

import Foundation

public protocol Action { }

struct searchRepository: Action {
    var nameRepositroy: String
    var page: String
}

enum RepositoryListViewAction: Action {
    case updateRepositories([GithubRepository])
    case search(text: String)
    case showAlertMessage(message: String)

}
