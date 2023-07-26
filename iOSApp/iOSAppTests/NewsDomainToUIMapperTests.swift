import XCTest
@testable import iOSApp

final class NewsDomainToUIMapperTests: XCTestCase {
    
    private var sut: NewsDomainToUIMapperImpl!
    
    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_NewsDomainToUIMapper_ShouldMapArticle() {
        let article = Article(uri: "",
                           url: "",
                           id: 0,
                           assetId: 0,
                           source: "",
                           publishedDate: "",
                           updated: "",
                           section: "",
                           subsection: "",
                           nytdSection: "",
                           column: "",
                           byline: "",
                           type: "",
                           title: "",
                           abstract: "",
                           media: [],
                           etaId: 0)
        let articleViewModel = sut.map(article: article)
        XCTAssertEqual(articleViewModel.title, article.title)
    }
    
}
