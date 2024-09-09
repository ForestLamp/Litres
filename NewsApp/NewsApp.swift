import SwiftUI

@main
struct NewsApp: App {

    init() {
        let currentApiKey = KeychainService.shared.getApiKey()
        if currentApiKey != Environment.apiKey {
            KeychainService.shared.saveApiKey(apiKey: Environment.apiKey)
        }
    }

    var body: some Scene {
        WindowGroup {
            NewsView(newsViewModel: NewsViewModel(networkService: NetworkService()))
        }
    }
}
