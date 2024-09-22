import SwiftUI
import Kingfisher

struct LocalNewsView: View {
    @ObservedObject var localNews: LocalNewsList
    @State private var selectedNews: LocalNews?  

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("News")
                    .font(.system(size: 24))
                    .padding(.top, 20)
                    .padding(.horizontal, 14)
                
                if let firstNews = localNews.localNews.first {
                    VStack(alignment: .leading) {
                        KFImage(URL(string: firstNews.image ?? ""))
                            .resizable()
                            .placeholder {
                                Image(systemName: "photo") 
                            }
                            .padding(.horizontal, 20)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .clipped()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(firstNews.source ?? "Unknown Source")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text(timeAgoSinceDate(from: firstNews.datetime))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                            
                            Text(firstNews.headline ?? "No headline available")
                                .font(.headline)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.leading)
                        .onTapGesture {
                            selectedNews = firstNews 
                        }
                        .sheet(item: $selectedNews) { news in
                            SelectedNewsView(news: news)
                        }
                    }
                }
                Divider()
            

                
                ForEach(localNews.localNews.dropFirst().prefix(19), id: \.self) { newsItem in
                    HStack{
                        VStack(alignment: .leading, spacing: 4) {
                            HStack{
                                Text(newsItem.source ?? "Unknown Source")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text(timeAgoSinceDate(from: newsItem.datetime))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                            //                            HStack{
                            //                                Text(timeAgoSinceDate(from: firstNews.datetime))
                            //                                    .font(.subheadline)
                            //                                    .foregroundColor(.gray)
                            
                            Text(newsItem.headline ?? "No headline available")
                                .font(.headline)
                                .lineLimit(2) 
                                .fixedSize(horizontal: false, vertical: true)
                            //                            }
                        }
                        .padding(.leading)
                        
                        
                        KFImage(URL(string: newsItem.image ?? ""))
                            .resizable()
                            .placeholder {
                                Image(systemName: "photo")
                            }
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding([.trailing], 8)
                    }
                    .onTapGesture {
                        selectedNews = newsItem
                    }
                    .sheet(item: $selectedNews) { news in
                        SelectedNewsView(news: news)
                    }
                }
            }
            
            
        }
    }
    
//    private func timeAgoSinceDate(from timestamp: Int?) -> String {
//        guard let timestamp = timestamp else { return "Some time ago" }
//        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
//        let formatter = RelativeDateTimeFormatter()
//        formatter.unitsStyle = .abbreviated
//        return formatter.localizedString(for: date, relativeTo: Date())
//    }
    private func timeAgoSinceDate(from timestamp: Int?) -> String {
        guard let timestamp = timestamp else { return "Some time ago" }
        
        let currentDate = Date()
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date, to: currentDate)
        
        if let hours = components.hour, let minutes = components.minute {
            if hours > 0 {
                if minutes > 0 {
                    return "\(hours) hr, \(minutes) min "
                } else {
                    return "\(hours) hr "
                }
            } else if minutes > 0 {
                return "\(minutes) min "
            } else {
                return "Just now"
            }
        } else {
            return "Some time "
        }
    }

}


