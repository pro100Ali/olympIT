import SwiftUI
import Kingfisher

struct NewsDetailView: View {
    let news: NewsModel
    var body: some View {
        VStack(spacing: 0) {
//                HStack {
//                    Text("4 часа назад ")
//                        .font(.system(size: 14))
//                        .foregroundColor(Color(UIColor.gray))
//                        .padding(.leading, 15)
//                        .padding(.bottom, 5)
//                    Spacer()
//                }
//                .background(Color(UIColor._727274.withAlphaComponent(0.6)))
                ScrollView {
                    
                    KFImage
                        .url(news.imageUrl)
                        .placeholder {
                            ZStack {
                                ProgressView()
                                    .scaleEffect(0.8, anchor: .center)
                            }
                        }
                        .resizable()
                        .background(Color.red)
                        .frame(height: 233)
                    ZStack(alignment: .leading) {
                        HStack {
                            Text(news.description)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 15)
                            Spacer()
                        }
                        
                    }
                    
                .background(Color(UIColor._252527))
                .cornerRadius(10)
                .clipped()
                .padding(.horizontal, 5)
            }
        }
        .background(Color(UIColor._37343B))
    }
}

#Preview {
    NewsDetailView(news: NewsModel(title: "Hellow", description: "Aksiodjs", time: "12:00", imageUrl: URL(string: "")!))
}
