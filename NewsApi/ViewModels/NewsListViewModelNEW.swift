//
//  NewsListViewModelNEW.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 14.08.2023.
//

import Foundation

class NewsListViewModelNEW: ObservableObject {
    var newsList = [NewsListDisplayModelNEW]()
    private var articles = [Article]()
    
    init(articles: [Article]) {
        self.articles = articles
        newsList = createDisplayModel(articles: articles)
    }
    
    private func createDisplayModel(articles: [Article]) -> [NewsListDisplayModelNEW] {
        var list = [NewsListDisplayModelNEW]()
        for art in articles {
            list.append(NewsListDisplayModelNEW(id: UUID(),
                                             title: art.title ?? "No title for this article",
                                             description: art.description ?? "No description for this article"))
        }
        return list
    }
    
    func didTapCell(_ index: Int) -> Article {
        articles[index]
    }
}

struct NewsListDisplayModelNEW: Identifiable {
    let id: UUID
    let title: String
    let description: String
}

