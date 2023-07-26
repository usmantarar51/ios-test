import Foundation

/// HTTPClient protocol for sending request
protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type,
                                   completion: @escaping (Result<T, AppError>) -> Void)
}

///HTTPClient implementation using URLSession
extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type,
                                   completion: @escaping (Result<T, AppError>) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            DispatchQueue.main.async {
                completion(.failure(.noIntenet))
            }
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems  = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noResponse))
                }
                return
            }
            
            do {
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(responseModel.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    DispatchQueue.main.async {
                        print(error)
                        completion(.failure(.decode))
                    }
                }
            }
        }
        task.resume()
    }
}
