///ListViewModel to implement all business logic
protocol NewsListViewModel {
    func viewDidLoad()
    func listCount() -> Int
    func getCellViewModelAt(index: Int) -> NewsCellViewModel
}

class NewsListViewModelImpl: NewsListViewModel {

    private var service: NewsService
    private var listView: NewsListView
    private var cellViewModels: [NewsCellViewModel] = []
    private var period = "7"

    init(service: NewsService,
         listView: NewsListView) {
        self.service = service
        self.listView = listView
    }
    
    func viewDidLoad() {
        fetchNews()
    }
    
    func getCellViewModelAt(index: Int) -> NewsCellViewModel {
        cellViewModels[index]
    }
    
    func listCount() -> Int {
        cellViewModels.count
    }

    //MARK: - Private Methods
    private func fetchNews() {
        listView.sendState(listViewUIState: .loading)
        service.fetchNews(period: period) { result in
            switch result {
            case .success(let news):
                let mapper = NewsDomainToUIMapperImpl()
                self.cellViewModels = news.results.map { mapper.map(article: $0) }
                self.listView.sendState(listViewUIState: .reloadTable)
            case .failure(let error):
                self.listView.sendState(listViewUIState: .error(error.localizedDescription))
            }
        }
    }
}
