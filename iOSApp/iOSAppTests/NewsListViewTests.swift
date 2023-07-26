import XCTest
@testable import iOSApp

final class NewsListViewTests: XCTestCase {
    
    private var serviceMock: NewsServiceMock!
    private var newsViewModel: NewsListViewModelImpl!
    private var sut: NewsListViewMock!
    
    override func setUp() {
        super.setUp()
        sut = .init()
        serviceMock = .init()
        newsViewModel = .init(service: serviceMock,
                                    listView: sut)
    }
    
    override func tearDown() {
        sut = nil
        newsViewModel = nil
        serviceMock = nil
        super.tearDown()
    }
    
    func testTableViewReloaded_WhenGivenNews_ShouldLoadTableView() {
        // given
        let jsonLoader = JSONLoaderImpl()
        serviceMock.news = jsonLoader.loadJSON(filename: "news", type: NewsResponse.self)
        
        // when
        newsViewModel.viewDidLoad()
        
        // then
        XCTAssertTrue(sut.tableViewReloaded)
    }
    
    func testShimmerViewShowed_WhenGivenNews_ShouldShowShimmerView() {
        // given
        let jsonLoader = JSONLoaderImpl()
        serviceMock.news = jsonLoader.loadJSON(filename: "news", type: NewsResponse.self)
        
        // when
        newsViewModel.viewDidLoad()
        
        // then
        XCTAssertTrue(sut.shimmerViewShowed)
    }
    
    func testErrorMessage_WhenGivenNews_ShouldShowError() {
        // given
        let givenError: AppError = .noResponse
        let jsonLoader = JSONLoaderImpl()
        serviceMock.news = jsonLoader.loadJSON(filename: "news", type: NewsResponse.self)
        serviceMock.error = givenError
        
        // when
        newsViewModel.viewDidLoad()
        
        // then
        XCTAssertEqual(sut.errorMessage, givenError.localizedDescription)
    }
}
