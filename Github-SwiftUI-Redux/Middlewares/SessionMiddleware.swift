//
//  SessionMiddleware.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//

import Foundation

func sessionMiddleware(network: APIClient) -> Middleware<Action> {
    { action in
        switch action {
        case let action as searchRepository:
            let result = Task { () -> Action in
                do {
                    let result = try await network.searchGithubRepository(repositroyName: action.nameRepositroy)
                    return RepositoryListViewAction.updateRepositories(result.items)
                } catch APIError.responseError {
                    return RepositoryListViewAction.showAlertMessage(message: APIError.responseError.message)
                } catch APIError.jsonParseError {
                    return RepositoryListViewAction.showAlertMessage(message: APIError.jsonParseError.message)
                } catch {
                    return RepositoryListViewAction.showAlertMessage(message: APIError.unknownError.message)
                }
            }
            return await result.value
        default:
            break
        }
        return nil
    }
}
