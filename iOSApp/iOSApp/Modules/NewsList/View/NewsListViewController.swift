import UIKit

enum ListViewUIState {
    case loading
    case error(String)
    case reloadTable
}

protocol NewsListView {
    func sendState(listViewUIState: ListViewUIState)
}

class NewsListViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var listViewModel: NewsListViewModel!
    var isLoading: Bool = true
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        listViewModel.viewDidLoad()
    }
    
    private func setupViews() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        listViewModel.viewDidLoad()
    }
}

extension NewsListViewController: NewsListView {
    func sendState(listViewUIState: ListViewUIState) {
        switch listViewUIState {
        case .loading:
            isLoading = true
        case .error(let message):
            isLoading = true
            endRefreshing()
            showError(message: message)
        case .reloadTable:
            isLoading = false
            endRefreshing()
            reloadTableView()
        }
    }
    
    func showError(message: String) {
        showAlert(with: "Error", message: message)
    }

    func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK:- UITableViewDataSource && UITableViewDelegate
extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseableIdentifier,
                                                       for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        if isLoading {
            return cell
        }
        
        let cellVM = listViewModel?.getCellViewModelAt(index: indexPath.row)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading,
                                     animate: true,
                                     viewBackgroundColor: .systemBackground)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 10
        } else {
            return listViewModel?.listCount() ?? 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVc = NewsDetailViewController.instantiate(fromAppStoryboard: .main)
        newsDetailVc.cellViewModel = listViewModel.getCellViewModelAt(index: indexPath.row)
        self.navigationController?.pushViewController(newsDetailVc, animated: true)
    }
}
