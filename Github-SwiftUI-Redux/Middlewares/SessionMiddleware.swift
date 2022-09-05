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
            switch action {
            case .search(let searchText):
                Task {
                    let result = Task { () -> Action in
                        do {
                            let result = try await network.searchGithubRepository(repositroyName: searchText)
                            return RepositoryListViewAction.setRepositories(result.items)
                        } catch APIError.responseError {
                            return RepositoryListViewAction.showAlertMessage(message: APIError.responseError.message)
                        } catch APIError.jsonParseError {
                            return RepositoryListViewAction.showAlertMessage(message: APIError.jsonParseError.message)
                        } catch {
                            return RepositoryListViewAction.showAlertMessage(message: APIError.unknownError.message)
                        }
                    }
                    let action = await result.value
                    await MainActor.run {
                        dispatch(action)
                    }
                }
            case .nextPage:
                Task {
                    let result = Task { () -> Action in
                        let page = state.currentPage
                        let searchText = state.searchText
                        do {
                            let result = try await network.searchGithubRepository(repositroyName: searchText, page: page)
                            return RepositoryListViewAction.addRepositories(result.items)
                        } catch APIError.responseError {
                            return RepositoryListViewAction.showAlertMessage(message: APIError.responseError.message)
                        } catch APIError.jsonParseError {
                            return RepositoryListViewAction.showAlertMessage(message: APIError.jsonParseError.message)
                        } catch {
                            return RepositoryListViewAction.showAlertMessage(message: APIError.unknownError.message)
                        }
                    }
                    let action = await result.value
                    await MainActor.run {
                        dispatch(action)
                    }
                }
            }
        default:
            break
        }
    }
}
