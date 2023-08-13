//
//  SearchViewModel.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 13.08.2023.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchKeyWord: String = ""
    @Published var sortedBy: NewsSortTypes = .publishedAt
    @Published var isFromDate: Bool = false
    @Published var isToDate: Bool = false
    @Published var fromDate: Date = Date()
    @Published var toDate: Date = Date()
    @Published var articles = [Article]()
    
    private let newsAPI: NewsAPIManager
    
    init(newsAPI: NewsAPIManager) {
        self.newsAPI = newsAPI
    }
    
    func fetchNews() async{
        do {
            var arguments: Dictionary<NewsRequestArgumentsTypes, String> = [.keyWord : searchKeyWord,
                                                                            .sortedBy: sortedBy.rawValue]
            if isFromDate {
                arguments[.fromDate] = stringFromDate(date: fromDate)
            }
            
            if isToDate {
                arguments[.toDate] = stringFromDate(date: toDate)
            }
            articles = try await newsAPI.fetchNews(arguments: arguments)
        } catch {
            print(error)
        }
    }
    
    private func stringFromDate(date: Date) -> String{
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "yyyy-MM-dd"
        return dateFormetter.string(from: date)
    }
}
