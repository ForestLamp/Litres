import SwiftUI

struct ArticleView: View {
    
    enum Constants {
        static let textPlaceholder: String = "No content"
        static let cornerRaduis: CGFloat = 8.0
    }

    let article: Article

    var body: some View {
        HStack(spacing: 8) {
            ArticleImageView(article: article, cornerRadius: Constants.cornerRaduis, textEmpty: Constants.textPlaceholder)
            Text(article.title ?? Constants.textPlaceholder)
                .font(.headline)
                .lineLimit(4)
                .padding(.vertical)
            Spacer()
        }
        .background(Color(.systemGray6))
        .cornerRadius(Constants.cornerRaduis)
        .padding(.horizontal)
    }
}

struct ArticleImageView: View {
    let article: Article
    let cornerRadius: CGFloat
    let textEmpty: String

    private var placeholder: some View {
        ImagePlaceholderView(cornerRadius: cornerRadius, placeholder: textEmpty)
    }

    var body: some View {
        ZStack {
            if let imageUrl = article.imageUrl,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .padding()
    }
}

struct ImagePlaceholderView: View {

    let cornerRadius: CGFloat
    let placeholder: String

    var body: some View {
        Text(placeholder)
            .frame(width: 100, height: 100)
            .background(.secondary)
            .cornerRadius(cornerRadius)
    }
}
