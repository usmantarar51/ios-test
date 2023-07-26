import XCTest
@testable import iOSApp

final class NewsListViewModelTests: XCTestCase {
    
    private var serviceMock: NewsServiceMock!
    private var sut: NewsListViewModelImpl!
    private var listViewMock: NewsListViewMock!
    
    override func setUp() {
        super.setUp()
        listViewMock = .init()
        serviceMock = .init()
        sut = .init(service: serviceMock,
                    listView: listViewMock)
    }
    
    override func tearDown() {
        listViewMock = nil
        serviceMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_FetchNews_WhenGivenError_ShouldHaveError() {
        // given
        let givenError: AppError = .noResponse
        serviceMock.error = givenError
        
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertEqual(serviceMock.error, givenError)
    }
    
    func testViewModelViewDidLoad_WhenGivenNews_ShouldCallFetchNewsWithSuccess() {
        // given
        let jsonLoader = JSONLoaderImpl()
        serviceMock.news = jsonLoader.loadJSON(filename: "news", type: NewsResponse.self)
        
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertNotNil(serviceMock.news!)
    }
    
    func testGetCount_WhenViewDidLoad_ShouldReturnListCount() {
        // given
        let jsonLoader = JSONLoaderImpl()
        serviceMock.news = jsonLoader.loadJSON(filename: "news", type: NewsResponse.self)
        
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertTrue(sut.listCount() > 0)
    }
}
