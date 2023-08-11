//
//  NewsListViewModel.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 05.08.2023.
//

import Foundation

@MainActor
class NewsListViewModel: ObservableObject {
    @Published var newsList = [NewsListDisplayModel]()
    @Published var sortBy = NewsSortTypes.publishedAt
    @Published var searchKeyWord = ""
    
    private let newsAPI: NewsAPIManager
    private var articles = [Article]()
    
    init(newsApiManager: NewsAPIManager) {
        newsAPI = newsApiManager
    }
    
    func fetchNews() async {
        do {
            let arguments: Dictionary<NewsRequestArgumentsTypes, String> = [.keyWord : searchKeyWord, .sortedBy: sortBy.rawValue]
            articles = try await newsAPI.fetchNews(arguments: arguments)
            newsList = createDisplayModel(articles: articles)
        } catch {
            print(error)
        }
    }
    
    private func createDisplayModel(articles: [Article]) -> [NewsListDisplayModel] {
        var list = [NewsListDisplayModel]()
        for art in articles {
            list.append(NewsListDisplayModel(id: UUID(),
                                             title: art.title ?? "No title for this article",
                                             description: art.description ?? "No description for this article"))
        }
        return list
    }
    
    func didTapCell(_ index: Int) -> Article {
        articles[index]
    }
}

struct NewsListDisplayModel: Identifiable {
    let id: UUID
    let title: String
    let description: String
}
