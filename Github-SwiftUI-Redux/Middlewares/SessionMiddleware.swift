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
        case let action as fetchRepository:
            let result = Task { () -> Action in
                do {
                    let result = try await network.searchGithubRepository(repositroyName: action.nameRepositroy)
                    return RepositoryListAction.updateRepositories(result.items)
                } catch APIError.responseError {
                    return RepositoryListAction.showAlertMessage(message: APIError.responseError.message)
                } catch APIError.jsonParseError {
                    return RepositoryListAction.showAlertMessage(message: APIError.jsonParseError.message)
                } catch {
                    return RepositoryListAction.showAlertMessage(message: APIError.unknownError.message)
                }
            }
            return await result.value
        default:
            break
        }
        return nil
    }
}
