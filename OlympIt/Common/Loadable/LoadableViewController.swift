//
//  LoadableViewController.swift
//  OlympIt
//
//  Created by Nariman on 18.02.2024.
//

import UIKit

protocol LoadableViewController: AnyObject {
    func hideLoading()
    func showLoading()
}

extension LoadableViewController where Self: UIViewController {
    func hideLoading() {
        hideLoadingAnimation()
    }
    func showLoading() {
        showLoadingAnimation()
    }
}

