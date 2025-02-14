//
//  NewsDetailViewController.swift
//  OlympIt
//
//  Created Nariman on 11.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class NewsDetailViewController: UIViewController, NewsDetailViewProtocol {
    var presenter: NewsDetailPresenterProtocol?
    
    let news: NewsModel
    
    private lazy var newsView: Bridged = {
        NewsDetailView(news: self.news).bridge()
    }()
    
    init(news: NewsModel) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
        self.configure(news: news)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(news: NewsModel) {
//        imageView.kf.setImage(with: news.imageUrl)
//        titleLabel.text = news.title
//        descriptionLabel.setTitle(news.description, for: .normal)
//        setLeftAlignedNavigationItemTitle(text: news.title, color: .white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
        setupSwiftUI(newsView)
        view.backgroundColor = ._37343B
        setLeftAlignedNavigationItemTitle(text: news.title, color: .white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = ._37343B
    }
//    func setupUI() {
//        view.backgroundColor = ._37343B
//
//        view.addSubviews(
//            titleLabel,
//            imageView,
//            descriptionLabel
//        )
//
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
//            make.leading.trailing.equalToSuperview().inset(16)
//        }
//
//        imageView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(16)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(200)
//        }
//
//        descriptionLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom).offset(16)
//            make.leading.trailing.equalToSuperview().inset(16)
//        }
//    }
}
