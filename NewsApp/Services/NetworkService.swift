import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, 
                httpResponse.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
