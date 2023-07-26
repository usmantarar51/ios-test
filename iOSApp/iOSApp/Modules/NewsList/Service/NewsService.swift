///Procotol NewsService for sendingRequest
protocol NewsService {
    func fetchNews(period: String, completion: @escaping (Result<NewsResponse, AppError>) -> Void)
}

struct NewsServiceImpl: HTTPClient, NewsService {
    func fetchNews(period: String, completion: @escaping (Result<NewsResponse, AppError>) -> Void) {
        sendRequest(endpoint: NewsEndpoint.fetchNews(period), responseModel: NewsResponse.self) { result in
            completion(result)
        }
    }
}
