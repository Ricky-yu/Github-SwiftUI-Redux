//
//  Github_SwiftUI_ReduxApp.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import SwiftUI

@main
struct Github_SwiftUI_ReduxApp: App {
    var body: some Scene {
        WindowGroup {
            let appState = AppState()
            let reducer = Reducer()
            let sessionMiddleware = sessionMiddleware(network: APIClient())
            let store = Store(appState: appState, reducer: reducer, middlewares: [sessionMiddleware])

            ContentView().environmentObject(store)
        }
    }
}
