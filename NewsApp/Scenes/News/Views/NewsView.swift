import SwiftUI

struct NewsView: View {

    enum Constants {
        static let alertTitle = "Failed to fetch articles"
        static let buttonRetryTitle = "Retry"
        static let buttonCancelTitle = "Cancel"
    }

    @ObservedObject var newsViewModel: NewsViewModel
    @State private var showAlert = false

    var body: some View {
        ZStack {
            switch newsViewModel.state {
            case .loading:
                ProgressView()
                    .task {
                        await fetchArticles()
                    }

            case .success:
                ScrollView {
                    LazyVStack {
                        ForEach(newsViewModel.articles) { article in
                            ArticleView(article: article)
                                .padding(.vertical, 8)
                        }
                    }
                }

            case .failure(let message):
                Text(message)
                    .foregroundColor(.red)
                    .onAppear {
                        showAlert = true
                    }
            }
        }
        .alert(Constants.alertTitle, isPresented: $showAlert) {
            Button(Constants.buttonRetryTitle) {
                Task {
                    await fetchArticles()
                }
            }
            Button(Constants.buttonCancelTitle, role: .cancel) {}
        }
    }

    private func fetchArticles() async {
        await newsViewModel.fetchArticles()
    }
}
