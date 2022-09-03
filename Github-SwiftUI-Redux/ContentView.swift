//
//  ContentView.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            ZStack {
                List(store.appState.items) { item in
                    GithubItemView(repo: item)
                }
                if store.appState.isLoading {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .tint(.cyan)
                }
            }
            .navigationTitle(Text("Github Repository"))
        }
        .searchable(text: $store.appState.searchText)
        .onSubmit(of: .search, {

        })
        .alert(isPresented: $store.appState.isShowAlert) {
            Alert(
                title: Text("エラー"),
                message: Text(store.appState.alertMessage),
                dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let reducer = Reducer()
        let store = Store(appState: appState, reducer: reducer)

        ContentView()
            .environmentObject(store)
    }
}
