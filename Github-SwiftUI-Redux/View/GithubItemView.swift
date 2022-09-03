//
//  GithubItemView.swift
//  Github-SwiftUI-Redux
//
//  Created by chensinyu on 2022/09/03.
//

import SwiftUI

struct GithubItemView: View {
    var repo: GithubRepository
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
                    .tint(.cyan)
            }
            .frame(width: 40, height: 40)
            .mask(RoundedRectangle(cornerRadius: 20))
            VStack(alignment: .leading, spacing: 2) {
                Text("assd")
                    .font(.body)
                Label("sddd",
                      systemImage: "star")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .symbolRenderingMode(.multicolor)
            }
        }
    }
}

struct GithubItemView_Previews: PreviewProvider {
    static var previews: some View {
        GithubItemView(repo: GithubRepository(id: 0))
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
