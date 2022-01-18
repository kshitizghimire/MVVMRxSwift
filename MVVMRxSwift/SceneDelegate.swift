import RxSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let viewModel = ViewModel(modelLoader: ModelLoader())
        let viewController = ViewController(viewModel: viewModel)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}

struct ModelLoader: ModelLoading {
    func load<T>(for _: URL, with _: T.Type) -> Observable<T> where T: Decodable {
        .empty()
    }
}
