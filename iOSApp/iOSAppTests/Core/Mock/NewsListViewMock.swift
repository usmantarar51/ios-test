import Foundation
@testable import iOSApp

final class NewsListViewMock: NewsListView {

    var tableViewReloaded: Bool = false
    var errorMessage: String = ""
    var shimmerViewShowed: Bool = false
    var tableViewReloadedAtIndex: Int = 0
    var tableViewInsertRowsAtIndex: Int = 0
    
    func sendState(listViewUIState: ListViewUIState) {
        switch listViewUIState {
        case .loading:
            shimmerViewShowed = true
        case .error(let message):
            errorMessage = message
        case .reloadTable:
            tableViewReloaded = true
        }
    }
}
