//
//  Store.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import Foundation

struct AppState {
    var searchText: String = ""
    var items: [GithubRepository] = []
    var isLoading: Bool = false
    var isShowAlert: Bool = false
    var alertMessage: String = ""
}

enum Action {
    case updateRepositories([GithubRepository])
    case search(text: String)
    case showAlertMessage(message: String)
}

class Reducer {
    func reduce(_ appState: inout AppState, _ action: Action) {
        switch action {
        case .updateRepositories(let repositories): break

        case .search(let repositoryName): break

        case .showAlertMessage(let errorMessage): break
    }
}

class Store: ObservableObject {
    var reducer: Reducer
    @Published var appState: AppState

    init(appState: AppState, reducer: Reducer) {
        self.appState = appState
        self.reducer = reducer
    }
}
