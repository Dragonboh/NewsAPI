//
//  NewsListNEW.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 14.08.2023.
//

import SwiftUI

struct NewsListNEW: View {
    var viewModel: NewsListViewModelNEW
    
    init(articles: [Article]) {
        viewModel = NewsListViewModelNEW(articles: articles)
    }
    
    var body: some View {
        List(viewModel.newsList.indices, id: \.self) { index in
            NavigationLink(destination: NewsView(article: viewModel.didTapCell(index))) {
                NewsListCellNEW(cellModel: viewModel.newsList[index])
            }
        }
        .listStyle(.plain)
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsListCellNEW: View {
    let cellModel: NewsListDisplayModelNEW
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(cellModel.title)
                .fontWeight(.black)
                .lineLimit(2)
            Text(cellModel.description)
                .lineLimit(4)
        }
    }
}

struct NewsListNEW_Previews: PreviewProvider {
    static var previews: some View {
        NewsListNEW(articles: [])
    }
}
