//
//  SessionMiddleware.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//

import Foundation

func sessionMiddleware(network: APIClient) -> Middleware<Action> {
    { state, action, dispatch in
        switch action {
        case let action as SearchRepositoryAction:
            Task {
                let result = Task { () throws -> Action in
                    switch action {
                    case .search(let searchText):
                        let result = try await network.searchGithubRepository(repositroyName: searchText)
                        return RepositoryListViewAction.setRepositories(result.items)
                    case .nextPage:
                        let page = state.currentPage
                        let searchText = state.searchText
                        let result = try await network.searchGithubRepository(repositroyName: searchText, page: page)
                        return RepositoryListViewAction.addRepositories(result.items)
                    }
                }
                do {
                    let action = try await result.value
                    await MainActor.run {
                        dispatch(action)
                    }
                } catch APIError.responseError {
                    await MainActor.run {
                        let action = RepositoryListViewAction.showAlertMessage(message: APIError.responseError.message)
                        dispatch(action)
                    }
                } catch APIError.jsonParseError {
                    await MainActor.run {
                        let action = RepositoryListViewAction.showAlertMessage(message: APIError.jsonParseError.message)
                        dispatch(action)
                    }
                } catch {
                    await MainActor.run {
                        let action = RepositoryListViewAction.showAlertMessage(message: APIError.unknownError.message)
                        dispatch(action)
                    }
                }
            }
        default:
            break
        }
    }
}
