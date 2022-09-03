//
//  Store.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import Foundation

struct AppState {

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
