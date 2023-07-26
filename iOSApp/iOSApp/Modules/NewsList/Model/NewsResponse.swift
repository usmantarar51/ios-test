import Foundation

// MARK: - NewsResponse
struct NewsResponse: Decodable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Article
struct Article: Decodable {
    let uri: String
    let url: String
    let id: Int
    let assetId: Int
    let source: String
    let publishedDate: String
    let updated: String
    let section: String
    let subsection: String
    let nytdSection: String
    let column: String?
    let byline: String
    let type: String
    let title: String
    let abstract: String
    let media: [Media]
    let etaId: Int
    
    enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case assetId = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case nytdSection = "nytdsection"
        case column
        case byline
        case type
        case title
        case abstract
        case media
        case etaId = "eta_id"
    }
}

// MARK: - Media
struct Media: Decodable {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadata
struct MediaMetadata: Decodable {
    let url: String
    let format: String
    let height: Int
    let width: Int
}
