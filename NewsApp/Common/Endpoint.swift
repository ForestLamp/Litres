import Foundation

enum Endpoint {
    case latestNews

    var root: String {
        Environment.baseUrl
    }

    var path: String {
        switch self {
        case .latestNews:
            return "latest"
        }
    }

    var method: String {
        switch self {
        case .latestNews:
            return "GET"
        }
    }

    var apiKey: String {
        return KeychainService.shared.getApiKey() ?? ""
    }

    var url: URL? {
        var components = URLComponents(string: root + path)
        components?.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        return components?.url
    }
}
