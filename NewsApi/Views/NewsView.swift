//
//  NewsView.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 10.08.2023.
//

import SwiftUI

struct NewsView: View {
    let article: Article
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(article.title ?? "")
                    .fontWeight(.black)
                HStack {
                    Text(article.author ?? "unknown author")
                        .fontWeight(.black)
                        .foregroundColor(Color.red)
                    Spacer()
                    Text(article.publishedAt ?? "")
                        
                }
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } placeholder: {
                    ProgressView()
                }
                Text(article.description ?? "")
            }

            if let url = URL(string: article.url ?? "") {
                Link(destination: url){
                    Text("Read full article")
                        .bold()
                        .font(.title)
                        .frame(width: 300, height:  50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(article: Article.previewArticle)
    }
}
