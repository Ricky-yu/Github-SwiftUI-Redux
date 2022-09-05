//
//  ContentView.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import SwiftUI

struct RepositoryListView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List(store.appState.items) { item in
                        GithubItemView(repo: item)
                            .onAppear() {
                                if store.appState.items.last == item {
                                    store.dispatch(RepositoryListViewAction.onBottomOfList)
                                    store.debounceTimer?.invalidate()
                                    store.debounceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                        store.dispatch(SearchRepositoryAction.nextPage)
                                    }
                                }
                            }
                    }
                    if store.appState.onBottomOfList {
                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                            .tint(.gray)
                    }
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
        .onChange(of: store.appState.searchText) { newSearchText in
            store.debounceTimer?.invalidate()
            store.debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                if !newSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    store.dispatch(SearchRepositoryAction.search(text: newSearchText))
                }
            }
        }
        .onSubmit(of: .search, {
            store.dispatch(SearchRepositoryAction.search(text: store.appState.searchText))
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

        RepositoryListView()
            .environmentObject(store)
    }
}
