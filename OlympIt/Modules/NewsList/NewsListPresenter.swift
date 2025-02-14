//
//  NewsListPresenter.swift
//  OlympIt
//
//  Created Nariman on 11.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class NewsListPresenter: NewsListPresenterProtocol {
    weak private var view: NewsListViewProtocol?
    var interactor: NewsListInteractorProtocol?
    private let router: NewsListWireframeProtocol
    var news: NewsListModel = []

    init(interface: NewsListViewProtocol, interactor: NewsListInteractorProtocol?, 
         router: NewsListWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        interactor?.fetchNews()
    }
    
    func didGetNews(with news: NewsListModel) {
        self.news = news
        view?.reloadTable()
    }
    
    func didSelectItemNews(at index: Int) {
        router.openNewsDetail(with: news[index])
    }
}
