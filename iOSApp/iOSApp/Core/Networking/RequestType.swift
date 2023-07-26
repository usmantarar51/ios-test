import Foundation

/// RequestMethod enum for service
enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

///AppError custom error type
enum AppError: LocalizedError {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case noIntenet
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .decode: return "Decode error"
        case .unauthorized: return "Session expired"
        case .noIntenet: return "No Internet conection"
        default: return "Unknown error"
        }
    }
}
