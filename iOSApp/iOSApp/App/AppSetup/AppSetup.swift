import UIKit

///AppSetup to startMainScene and Dependency injection
struct AppSetup {
    static func startMainScene(window: UIWindow) {
        let viewController = NewsListViewController.instantiate(fromAppStoryboard: .main)
        let service = NewsServiceImpl()
        let viewModel = NewsListViewModelImpl(service: service,
                                              listView: viewController)
        viewController.listViewModel = viewModel
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
