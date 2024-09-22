//
//  SelectedNewsView.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 29/04/24.
//

import SwiftUI

struct SelectedNewsView: View {
    @Environment(\.presentationMode) var presentationMode
    var news: LocalNews

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(news.source ?? "N:A")
                    .font(.title)
                    .padding(.top, 50.0)
                //                .padding()
                Spacer()
                Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "multiply")
                                .foregroundColor(Color.black)
                        }.padding(.horizontal,30)
                        
            }
            Text(getHumanReadableTime(time: TimeInterval(news.datetime ?? 0)))
                        .font(.subheadline)
                        .fontWeight(.light)
            Divider()
            Text(news.headline ?? "N:A")
                .font(.title)
            Text(news.summary ?? "N:A")
//                .lineLimit(5)
            HStack {
                Text("For more detail click ")
                if let urlString = news.url, let url = URL(string: urlString) {
                    Link("here", destination: url)
                        .foregroundColor(.blue)
                } else {
                    Text("here")
                        .foregroundColor(.gray)
                }
            }
            HStack{
                Link(destination: URL(string: "https://twitter.com/intent/tweet?text=\(encodeURIComponent(string: news.summary ?? "N/A"))&url=\(encodeURIComponent(string: news.url ?? "N/A"))")!) {
                    HStack {
                        Image("twitter")
                            .resizable()
                            .frame(width: 35, height: 35)
                        //                           Text("Tweet This")
                    }
                }
                Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(encodeURIComponent(string: news.url ?? "N/A"))&quote=\(encodeURIComponent(string: news.summary ?? "N/A"))")!) {
                    HStack {
                        Image("facebook")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
            }
               
//
//            ScrollView {
//                Text(news.content)
//                    .padding()
//            }
        }
        .padding(.leading, 14.0)
//        .padding(.top, -115.375)
        Spacer()
    }
    func getHumanReadableTime(time: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
                 func encodeURIComponent(string: String) -> String {
                         // Encoding the string to be URL-safe
                         return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
                     }
}

struct SelectedNewsView_Previews: PreviewProvider {
    static var previews: some View {
       
        SelectedNewsView(news: LocalNews(category: "ds", datetime: 0, headline: "ds", id: 0, image: "ds", related: "ds", source: "ds", summary: "ds", url: "ds"))
    }
}
