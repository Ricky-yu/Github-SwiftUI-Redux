//
//  State.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/04.
//

import Foundation

struct AppState {
    var searchText: String = ""
    var items: [GithubRepository] = []
    var isLoading = false
    var isShowAlert = false
    var alertMessage: String = ""
}
