//
//  SceneDelegate.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 04/06/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var injectionContainer: AppDependencyContainer?

    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        injectionContainer = AppDependencyContainer(httpClient: httpClient)
        
        window?.rootViewController = injectionContainer?.makeSearchCityViewController() ?? UIViewController()

        window?.makeKeyAndVisible()
    }

}

