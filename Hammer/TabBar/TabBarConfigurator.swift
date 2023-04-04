//
//  TabBarConfigurator.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

import UIKit

protocol TabBarConfiguratorProtocol {
    func configure() -> UITabBarController
}

final class TabBarConfigurator: TabBarConfiguratorProtocol {
    init() {}

    func configure() -> UITabBarController {
        let mainVC = MainConfigurator()
        let mainVCVCWithNav = generateNavController(
            rootViewcontroller: mainVC.configure(),
            title: "Главная",
            image: "film",
            navBarIsHidden: false
        )

        let tabBar = setupTabBar(viewControllers: mainVCVCWithNav)
        return tabBar
    }

    private func setupTabBar(viewControllers: UIViewController...) -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = viewControllers
        tabBarVC.tabBar.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        return tabBarVC
    }

    private func generateNavController(rootViewcontroller: UIViewController,
                                       title: String,
                                       image: String,
                                       navBarIsHidden: Bool) -> UIViewController
    {
        let navigationVC = UINavigationController(rootViewController: rootViewcontroller)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: image)
        navigationVC.navigationBar.isHidden = navBarIsHidden
        return navigationVC
    }
}
