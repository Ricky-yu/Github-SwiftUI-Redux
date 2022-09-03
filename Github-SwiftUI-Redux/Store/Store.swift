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

}

class Reducer {

}

class Store: ObservableObject {
    var reducer: Reducer
    @Published var appState: AppState

    init(appState: AppState, reducer: Reducer) {
        self.appState = appState
        self.reducer = reducer
    }
}
