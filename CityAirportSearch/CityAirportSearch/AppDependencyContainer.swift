//
//  AppDependencyContainer.swift
//  CityAirportSearch
//
//  Created by Romain Brunie on 16/06/2021.
//

import UIKit

final class AppDependencyContainer {
    
    // Long-lived dependencies
    let httpClient: HTTPClient
    let nav: UINavigationController = {
        let nav = UINavigationController()
        nav.navigationBar.barTintColor = .systemRed
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        nav.navigationBar.tintColor = .white
        return nav
    }()

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func makeSearchCityViewController() -> UIViewController {
        let url = URL(string: "https://raw.githubusercontent.com/rombiddle/FRP---City-Airport-Search/master/aiports.json")!
        let loader = RemoteAirportsLoader(url: url, client: httpClient)
                        
        let searchCityViewController = SearchCityViewController.make()
        searchCityViewController.viewModel = SearchCityViewModel(client: loader, citySelection: showAirports)
        searchCityViewController.title = "Airports"
        nav.setViewControllers([searchCityViewController], animated: true)
        return nav
    }
    
    private func showAirports(for airports: [Airport]) {
        let airportsViewController = AirportsViewController.make()
        airportsViewController.airports.accept(airports)
        nav.pushViewController(airportsViewController, animated: true)
    }
}

private extension SearchCityViewController {
    static func make() -> SearchCityViewController {
        let bundle = Bundle(for: SearchCityViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let searchCityViewController = storyboard.instantiateInitialViewController() as! SearchCityViewController
        return searchCityViewController
    }
}

private extension AirportsViewController {
    static func make() -> AirportsViewController {
        let bundle = Bundle(for: AirportsViewController.self)
        let storyboard = UIStoryboard(name: "Airports", bundle: bundle)
        let airportsViewController = storyboard.instantiateInitialViewController() as! AirportsViewController
        return airportsViewController
    }
}
