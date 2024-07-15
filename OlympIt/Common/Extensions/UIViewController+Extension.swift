//
//  UIViewController.swift
//  ToolKit
//
//  Created by Санжар Дауылов on 8/5/20.
//  Copyright © 2020 D. Sanzhar. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


extension UIViewController {
    
    func setupLeftNavigationBar(title: String, backButtonImage: UIImage?) {
        // Create back button
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
        if let image = backButtonImage {
            backButton.image = image
        }
        self.navigationItem.leftBarButtonItem = backButton
        
        // Create title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        titleLabel.sizeToFit()
        
        // Create title view to hold the label
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: titleLabel.frame.width, height: titleLabel.frame.height))
        titleView.addSubview(titleLabel)
        
        // Set the title view as the navigation item's title view
        self.navigationItem.titleView = titleView
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    
    func navBar(title: String) {
        navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationItem.backBarButtonItem = backButton
    }
    
    
    func setLeftAlignedNavigationItemTitle(text: String,
                                           color: UIColor,
                                           margin top: CGFloat = 16) {
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationItem.titleView = titleLabel
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        guard let containerView = self.navigationItem.titleView?.superview else { return }

        // NOTE: This always seems to be 0. Huh??
        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                             constant: (leftBarItemWidth ?? 0) + 16.0)
        ])
    }
    
    @objc func close(_ animated: Bool) {
        if let navigationController = parent as? UINavigationController, navigationController.children.count > 1 {
            navigationController.popViewController(animated: animated)
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
        } else if view.superview != nil {
            view.removeFromSuperview()
        }
    }
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func configureBackButtonItem(image: UIImage = UIImage(systemName: "chevron.left")!,
                                 title: String = "") {
        let backButton = UIBarButtonItem()
        backButton.title = title
        backButton.image = image
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    func addTwoRightBarButtonToNavigationItems(with image: [UIImage]) {
        guard image.count > 1 else {return}
        let first = UIBarButtonItem(image: image[0],
                                    style: .plain,
                                    target: self,
                                    action: #selector(moreRightBarButtonAction))
        let second = UIBarButtonItem(image: image[1],
                                     style: .plain,
                                     target: self,
                                     action: #selector(moreRightBarButtonAction))
        first.tag = 0
        second.tag = 1
        navigationItem.rightBarButtonItems = [first, second]
    }
    func addRightBarButtonToNavigationItem(with image: UIImage) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonAction))
    }
    func addLeftBarButtonToNavigationItem(with image: UIImage) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(leftBarButtonAction))
    }
    func addRightBarButtonToNavigationItem(with title: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonAction))
    }
    func showLoadingAnimation(backgroundColor: UIColor = .white, position: CGPoint? = nil, size: CGSize? = nil) {
        if let activityView = self.view.viewWithTag(12345) as? NVActivityIndicatorView {
            self.view.bringSubviewToFront(activityView)
            activityView.startAnimating()
            return
        }
        let bounds = view.bounds
        let activityView = NVActivityIndicatorView(
            frame: bounds,
            type: .circleStrokeSpin,
            color: .green,
            padding: bounds.width * 0.4
        )
        activityView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        activityView.tag = 12345
        DispatchQueue.main.async {
            self.view.addSubview(activityView)
            self.view.bringSubviewToFront(activityView)
            activityView.startAnimating()
        }
    }
    
    func hideLoadingAnimation() {
        DispatchQueue.main.async { [weak self] in
            (self?.view.viewWithTag(12345) as? NVActivityIndicatorView)?.stopAnimating()
        }
    }
    func disableLargeTitle() {
        navigationItem.largeTitleDisplayMode = .never
    }
    @objc public func moreRightBarButtonAction(sender: UIBarButtonItem) {
        
    }
    @objc public func rightBarButtonAction() {
        
    }
    @objc public func leftBarButtonAction() {
        
    }
    func hideKeyboard() {
        view.endEditing(true)
    }
    // Make the navigation bar background clear
    @objc func makeNavigationBarTransparent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    // Restore the navigation bar to default
    func restoreNavigationBarAfterTransparency() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    
    func configureNavigationBar(backgroundColor: UIColor = .white) {
        navigationController?.navigationBar.backgroundColor = backgroundColor
    }
    var topbarHeight: CGFloat {
        return statusBarHeight + navBarHeight
    }
    var navBarHeight: CGFloat {
        let navBarHeight = (self.navigationController?.navigationBar.frame.minY ?? 0.0)
        return navBarHeight
    }
    var statusBarHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }
    
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}


extension UIViewController {
    
    /// Sugar syntax for displaying Alert
    /// - Parameters:
    ///   - title: default value is "Error"
    ///   - message: body of alert, could be nil
    ///   - actionButtons: Array of action button, initialized with title, by default button with "OK" title
    ///   - cancelButton: Cancel button, by default is nil
    ///   - handler: handler all of buttons
    func alert(title: String? = "Attention",
               message: String?,
               actionButtons: [String] = ["OK"],
               cancelButton: String? = nil,
               cancelButtonStyle: UIAlertAction.Style = .cancel,
               handler: ((UIAlertAction) -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        for button in actionButtons {
            alert.addAction(UIAlertAction(title: button, style: cancelButton == nil && actionButtons.count == 1 ? .cancel : .default, handler: handler))
        }

        if let button = cancelButton {
            alert.addAction(UIAlertAction(title: button, style: cancelButtonStyle, handler: handler))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func alert(title: String? = "Attention",
               message: String?,
               actionButtonTitle: String? = nil,
               cancelButtonTitle: String? = nil,
               cancelButtonStyle: UIAlertAction.Style = .cancel,
               actionHandler: ((UIAlertAction) -> Void)?,
               cancelHandler: ((UIAlertAction) -> Void)?)
    {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        if let button = actionButtonTitle {
            alert.addAction(UIAlertAction(title: button, style: .default, handler: actionHandler))
        }

        if let button = cancelButtonTitle {
            alert.addAction(UIAlertAction(title: button, style: cancelButtonStyle, handler: cancelHandler))
        }
        self.present(alert, animated: true, completion: nil)
    }
    /// Remove UIViewController by index from UINavigationController
    /// - Parameter number: index of removing UIViewController
    func removeSelfFromNavigationBy(_ number: Int) {
        guard let navigationController = navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        if navigationArray.count - number > 0 {
            navigationArray.remove(at: navigationArray.count - number) // To remove previous UIViewController
            self.navigationController?.viewControllers = navigationArray
        }
    }
    /// Removes all UIViewController from UINavigationController exept first one
    func removeTillRoot() {
        guard let navigationController = navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        for i in 1..<navigationArray.count {
            navigationArray.remove(at: i) // To remove previous UIViewController
        }
        self.navigationController?.viewControllers = navigationArray
    }
    
    func pushIfPossibleOrPresentWithNavigation(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navCont = self.navigationController {
            navCont.pushViewController(viewController, animated: animated)
        } else {
            let navCont = UINavigationController(rootViewController: viewController)
            navCont.modalPresentationStyle = .overFullScreen
            navCont.hidesBottomBarWhenPushed = true
            present(navCont, animated: animated, completion: completion)
        }
    }
    
    func pushIfPossibleOrPresent(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navCont = self.navigationController {
            navCont.pushViewController(viewController, animated: animated)
        } else {
            present(viewController, animated: animated, completion: completion)
        }
    }
    
    func popIfPossibleOrDissmiss(animated: Bool, completion: (() -> Void)?) {
        if let navCont = self.navigationController, navCont.viewControllers.count > 1 {
            navCont.popViewController(animated: animated)
            completion?()
        } else {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    func removeLastVCsFromNavigation(amount: Int,
                                     andPushViewController viewController: UIViewController,
                                     animatedPush: Bool = true,
                                     completion: (() -> Void)?) {
        guard let navigationController = self.navigationController else { return }
        for _ in 0..<amount {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: false)
            }
        }
        navigationController.pushViewController(viewController, animated: animatedPush)
    }
    func popByRemovingLastViewControllers(amount: Int,
                                          animated: Bool = true,
                                          completion: (() -> Void)?) {
        guard let navigationController = self.navigationController else { return }
        for _ in 0..<amount {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: animated)
            }
        }
    }
}

