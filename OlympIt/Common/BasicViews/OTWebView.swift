//
//  OTWebView.swift
//  OlympIt
//
//  Created by Nariman on 10.05.2024.
//

import UIKit
import WebKit

class OTWebView: WKWebView {
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        let webConfiguration = WKWebViewConfiguration()
//        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        super.init(frame: frame, configuration: webConfiguration)
//        self.backgroundColor = .clear
//        self.scrollView.backgroundColor = .clear
//        self.isOpaque = false
//        self.isHidden = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
