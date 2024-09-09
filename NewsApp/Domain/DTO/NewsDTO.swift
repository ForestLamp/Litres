struct NewsDTO: Codable {
    let status: String
    let totalResults: Int
    let results: [Article]
}

struct Article: Identifiable, Codable {
    let articleId: String
    let title: String?
    let imageUrl: String?

    var id: String {
        articleId
    }
}
