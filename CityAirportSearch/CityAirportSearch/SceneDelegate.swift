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
    
    private lazy var rxHttpClient: RxHTTPClient = {
        URLSessionRxHTTPClient(session: URLSession(configuration: .ephemeral))
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        injectionContainer = AppDependencyContainer(httpClient: httpClient)
        
        let url = URL(string: "https://raw.githubusercontent.com/rombiddle/FRP---City-Airport-Search/master/aiports.json")!
        let loader = RemoteAirportsLoader(url: url, client: httpClient)
        let rxLoader = RemoteRxAirportsLoader(url: url, client: rxHttpClient)
        window?.rootViewController = injectionContainer?.makeSearchCityViewController(loader: rxLoader) ?? UIViewController()

        window?.makeKeyAndVisible()
    }

}

