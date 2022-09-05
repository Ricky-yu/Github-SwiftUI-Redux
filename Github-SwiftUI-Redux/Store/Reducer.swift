//
//  Reducer.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//

import Foundation

class Reducer {
    func reduce(_ appState: inout AppState, _ action: Action) {
        appState.isLoading = false
        appState.onBottomOfList = false
        switch action {
        case RepositoryListViewAction.setRepositories(let repositories):
            appState.items = repositories
            appState.currentPage = 1
        case RepositoryListViewAction.addRepositories(let repositories):
            appState.items += repositories
            appState.currentPage += 1
        case RepositoryListViewAction.showAlertMessage(let errorMessage):
            appState.alertMessage = errorMessage
            appState.isShowAlert = true
        case RepositoryListViewAction.onBottomOfList:
            appState.onBottomOfList = true
        case let searchRepositoryAction as SearchRepositoryAction:
            switch searchRepositoryAction {
            case .search(_:):
                appState.isLoading = true
            case .nextPage:
                appState.onBottomOfList = true
            }
        default:
            break
        }
    }
}
