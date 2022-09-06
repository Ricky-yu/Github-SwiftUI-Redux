//
//  Github_SwiftUI_ReduxTests.swift
//  Github-SwiftUI-ReduxTests
//
//  Created by chensinyu on 2022/09/03.
//

import XCTest
@testable import Github_SwiftUI_Redux

class Github_SwiftUI_ReduxTests: XCTestCase {

    var view: RepositoryListView!
    override func setUp() {
        super.setUp()
        let appState = AppState()
        let reducer = Reducer()
        let sessionMiddleware = sessionMiddleware(network: APIClient())
        let store = Store(appState: appState, reducer: reducer, middlewares: [sessionMiddleware])

        view = RepositoryListView(store: store)
    }

    override func tearDown() {
        view = nil
        super.tearDown()
    }

    func testViewInitSetting(state: AppState) {
        let initState = state
        XCTAssertEqual(initState.items.count, 0)
        XCTAssertEqual(initState.currentPage, 1)
        XCTAssertEqual(initState.searchText, "")
        XCTAssertEqual(initState.alertMessage, "")
        XCTAssertEqual(initState.isShowAlert, false)
        XCTAssertEqual(initState.isLoading, false)
        XCTAssertEqual(initState.onBottomOfList, false)
    }

    func testReducerAlert() {
        var initState = view.store.appState
        testViewInitSetting(state: initState)

        view.store.reducer.reduce(&initState, RepositoryListViewAction.showAlertMessage(message: "error"))
        XCTAssertEqual(initState.isShowAlert, true)
        XCTAssertEqual(initState.alertMessage, "error")

    }

    func testReducerSearch() {
        var initState = view.store.appState
        testViewInitSetting(state: initState)

        view.store.reducer.reduce(&initState, SearchRepositoryAction.search(text: "test"))
        XCTAssertEqual(initState.isLoading, true)
        XCTAssertEqual(initState.searchText, "test")

    }

    func testReducerNextPage() {
        var initState = view.store.appState
        testViewInitSetting(state: initState)

        view.store.reducer.reduce(&initState, SearchRepositoryAction.nextPage)
        XCTAssertEqual(initState.onBottomOfList, true)
        XCTAssertEqual(initState.currentPage, 2)

        view.store.reducer.reduce(&initState, SearchRepositoryAction.nextPage)
        XCTAssertEqual(initState.onBottomOfList, true)
        XCTAssertEqual(initState.currentPage, 3)
    }

    func testReducerSetRepositories() {
        var initState = view.store.appState
        testViewInitSetting(state: initState)

        let repositories = [GithubRepository(id: 0, repositoryName: "swift", starCount: 23, repositoryUrl: "test.com", repositoryOwner: GithubRepositoryOwner(repositoryImageUrl: "test/image.jpg"))]

        view.store.reducer.reduce(&initState, RepositoryListViewAction.setRepositories(repositories))
        XCTAssertEqual(initState.items.count, 1)
        XCTAssertEqual(initState.items.first?.starCount, 23)
        XCTAssertEqual(initState.items.first?.repositoryName, "swift")
    }

    func testReducerAddRepositories() {
        var initState = view.store.appState
        testViewInitSetting(state: initState)

        let repositories01 = [GithubRepository(id: 0, repositoryName: "swift", starCount: 23, repositoryUrl: "test.com", repositoryOwner: GithubRepositoryOwner(repositoryImageUrl: "test/image.jpg"))]
        let repositories02 = [GithubRepository(id: 1, repositoryName: "swift1", starCount: 33, repositoryUrl: "test1.com", repositoryOwner: GithubRepositoryOwner(repositoryImageUrl: "test/image1.jpg"))]

        view.store.reducer.reduce(&initState, RepositoryListViewAction.addRepositories(repositories01))
        XCTAssertEqual(initState.items.count, 1)
        XCTAssertEqual(initState.items.first?.starCount, 23)
        XCTAssertEqual(initState.items.first?.repositoryName, "swift")

        view.store.reducer.reduce(&initState, RepositoryListViewAction.addRepositories(repositories02))
        XCTAssertEqual(initState.items.count, 2)
        XCTAssertEqual(initState.items[1].starCount, 33)
        XCTAssertEqual(initState.items[1].repositoryName, "swift1")
    }

}
