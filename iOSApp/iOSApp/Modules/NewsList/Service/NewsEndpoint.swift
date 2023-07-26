import Foundation
enum NewsEndpoint {
    case fetchNews(String)
}

extension NewsEndpoint: Endpoint {
    private struct Constants {
        static let apiKey = "N2aS69zh2KEuCbHCnspwGKfOiU5fxgze"
    }
    var path: String {
        switch self {
        case .fetchNews(let period):
            return "/svc/mostpopular/v2/mostviewed/all-sections/\(period).json"
        }
    }

    var method: RequestMethod {
        switch self {
        case .fetchNews:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .fetchNews:
            return [URLQueryItem(name: "api-key", value: "\(Constants.apiKey)")]
        }
    }
}
