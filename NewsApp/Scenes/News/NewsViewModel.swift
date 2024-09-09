import SwiftUI

@MainActor
final class NewsViewModel: ObservableObject {

    enum ViewStates {
        case loading
        case success
        case failure(String)
    }

    @Published var articles: [Article] = []
    @Published var state: ViewStates = .loading
    let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchArticles() async {
        state = .loading
        do {
            let newsResponse: NewsDTO = try await networkService.fetchData(from: Endpoint.latestNews)
            articles = newsResponse.results
            state = .success
        } catch {
            state = .failure("Error: \n\(error.localizedDescription)")
        }
    }
}
