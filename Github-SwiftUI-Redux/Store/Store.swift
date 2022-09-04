//
//  Store.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import Foundation

typealias Middleware<Action> = (Action) async -> Action?

final class Store: ObservableObject {
    @Published var appState: AppState
    var debounceTimer: Timer?
    let reducer: Reducer
    let middlewares: [Middleware<Action>]
    init(appState: AppState, reducer: Reducer, middlewares: [Middleware<Action>] = []) {
        self.appState = appState
        self.reducer = reducer
        self.middlewares = middlewares
    }

    func dispatch(_ action: Action) {
        self.reducer.reduce(&appState, action)
        Task {
            for middleware in middlewares {
                guard let action = await middleware(action) else {
                    break
                }
                await MainActor.run {
                    self.dispatch(action)
                }
            }
        }
    }
}
