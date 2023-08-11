//
//  NewsList.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 05.08.2023.
//
import SwiftUI

struct NewsList: View {
    @StateObject var viewModel = NewsListViewModel(newsApiManager: NewsAPIManager.shared)
    
    var body: some View {
        NavigationView {
            if viewModel.newsList.count > 0 {
                VStack {
                    Picker(selection: $viewModel.sortBy, label: Text("sort")) {
                        ForEach(NewsSortTypes.allCases, id: \.self) { sortType in
                            Text(sortType.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: viewModel.sortBy) { newValue in
                        Task {
                            await viewModel.fetchNews()
                        }
                    }

                    List(viewModel.newsList.indices, id: \.self) { index in
                        NavigationLink(destination: NewsView(article: viewModel.didTapCell(index))) {
                            NewsListCell(cellModel: viewModel.newsList[index])
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("News")
            } else {
                VStack {
                    Text("Find some news articles")
                        .font(.title.weight(.bold))
                    Text("Please eenter a key work and press search on you keyboard to start search a search")
                        .multilineTextAlignment(.center)
                }.navigationTitle("News")
            }
        }
        .searchable(text: $viewModel.searchKeyWord) {}
        .onSubmit(of: .search) {
            Task {
                await viewModel.fetchNews()
            }
        }
    }
}

struct NewsListCell: View {
    let cellModel: NewsListDisplayModel
    
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

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
