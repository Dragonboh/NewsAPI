//
//  SearchOptionsView.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 13.08.2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel(newsAPI: NewsAPIManager.shared)
    @State var isActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: NewsListNEW(articles: viewModel.articles), isActive: $isActive) {
                    EmptyView()
                }
                Text("Please eenter a key word and date and press search to see news")
                    .padding()
                TextField("Enter key word", text: $viewModel.searchKeyWord)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .font(.headline)
                    .padding(.horizontal)
                Picker(selection: $viewModel.sortedBy, label: Text("sort")) {
                    ForEach(NewsSortTypes.allCases, id: \.self) { sortType in
                        Text(sortType.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Toggle(isOn: $viewModel.isFromDate) {
                    Text("From Date")
                }.padding()
                
                if viewModel.isFromDate {
                    DatePicker("Select from date", selection: $viewModel.fromDate, displayedComponents: [.date])
                        .padding()
                }
                
                Toggle(isOn: $viewModel.isToDate) {
                    Text("To Date")
                }.padding()
                
                if viewModel.isToDate {
                    if viewModel.isFromDate {
                        DatePicker("Select to date",
                                   selection: $viewModel.toDate,
                                   in: viewModel.fromDate...viewModel.toDate,
                                   displayedComponents: [.date]
                        ).padding()
                    } else {
                        DatePicker("Select to date",
                                   selection: $viewModel.toDate,
                                   in: ...viewModel.toDate,
                                   displayedComponents: [.date]
                        ).padding()
                    }
                }
                
                Button {
                    if !viewModel.searchKeyWord.isEmpty {
                        Task {
                            await viewModel.fetchNews()
                            isActive.toggle()
                        }
                    }
                } label: {
                    Text("Search")
                        .bold()
                        .font(.title)
                        .frame(width: 300, height:  50)
                        .background(viewModel.searchKeyWord.isEmpty ? Color.gray : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
                
            }
            .navigationTitle("Search News")
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
