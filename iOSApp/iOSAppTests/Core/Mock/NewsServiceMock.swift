import Foundation
@testable import iOSApp

final class NewsServiceMock: NewsService {
    var error: AppError?
    var isFetchNewsCalled = false
    var news: NewsResponse?
    
    func fetchNews(period: String, completion: @escaping (Result<NewsResponse, AppError>) -> Void) {
        isFetchNewsCalled = true
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(news ?? NewsResponse(status: "200",
                                                     copyright: "Mock Copy Rights",
                                                     numResults: 0,
                                                     results: []))
            )
        }
    }
}
