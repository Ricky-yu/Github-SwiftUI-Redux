//
//  ContentView.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var store: Store
    
    var body: some View {
        NavigationView {
            VStack {
                List(store.appState.items) { item in
                    GithubItemView(repo: item)
                        .onAppear() {
                            if store.appState.items.last == item { // 画面の一番下へ到達した
                                store.dispatch(RepositoryListViewAction.onBottomOfList)

                                store.debounceTimer?.invalidate() // スロットリング
                                store.debounceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                    store.dispatch(SearchRepositoryAction.nextPage)
                                }
                            }
                        }
                }
                .overlay {
                    if store.appState.isLoading { // 真ん中のロード画面
                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                            .tint(.cyan)
                    }
                }
                if store.appState.onBottomOfList {// 下のロード画面
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .tint(.gray)
                }
            }
            .navigationTitle(Text("Github Repository"))
        }
        .searchable(text: $store.appState.searchText)
        .onChange(of: store.appState.searchText) { newSearchText in // インクリメンタルサーチ
            store.debounceTimer?.invalidate() // スロットリング
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

        RepositoryListView(store: store)
    }
}
