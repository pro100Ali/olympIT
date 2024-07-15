import Foundation
import SwiftUI
import UIKit

extension View {
    func convertSwiftUIToHosting() -> UIHostingController<Self>{
        return UIHostingController(rootView: self)
    }
    public func bridge() -> UIHostingController<Self> {
        RestrictedUIHostingController(rootView: self).apply { vc in
            vc.view.backgroundColor = .clear
        }
    }
}

final public class RestrictedUIHostingController<Content>: UIHostingController<Content> where Content: View {

    /// The hosting controller may in some cases want to make the navigation bar be not hidden.
    /// Restrict the access to the outside world, by setting the navigation controller to nil when internally accessed.
    public override var navigationController: UINavigationController? {
        nil
    }
}


public protocol InlineConfigurable {}

extension NSObject: InlineConfigurable {}

public extension InlineConfigurable {
    @discardableResult
    func apply(_ configurator: (Self) -> Void) -> Self {
        configurator(self)
        return self
    }
}


extension UIViewController {
    func setupSwiftUI(_ hostingController: UIViewController) {
        addChild(hostingController)
        view.backgroundColor = .red
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        hostingController.didMove(toParent: self)
    }
}

typealias Bridged = UIViewController
