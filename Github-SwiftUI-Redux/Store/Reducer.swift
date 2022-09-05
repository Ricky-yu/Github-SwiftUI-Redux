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
        case is searchRepository:
            appState.isLoading = true
        default:
            break
        }
    }
}
