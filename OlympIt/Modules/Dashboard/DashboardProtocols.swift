//
//  DashboardProtocols.swift
//  OlympIt
//
//  Created Nariman on 18.02.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import Foundation

//MARK: Wireframe -
protocol DashboardWireframeProtocol: AnyObject {
    func openBottomSheet(executor: AnyObject)
    func openLessonsList(initialLessonType: InitialLessonType, type: LessonType, lessonId: String)
    func openNewsDetail(with model: NewsModel)
    func openNewsList()
}
//MARK: Presenter -
protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    var lessons: InitialLessonOutputList { get }
    var lessonType: InitialLessonType { get set }
    var news: NewsListModel { get set }
    
    func didFetchLessons(with lessons: InitialLessonOutputList)
    func didGetNews(with news: NewsListModel)
    func error(message: String)
    func didSelectItem(at index: Int)
    func didSelectItemNews(at index: Int)
    func didTappedShowMore()
}

//MARK: Interactor -
protocol DashboardInteractorProtocol: AnyObject {
    var presenter: DashboardPresenterProtocol?  { get set }
    func fetchExams(by type: InitialLessonType)
    func getNews()
}

//MARK: View -
protocol DashboardViewProtocol: AnyObject,
                                LoadableViewController {
    var presenter: DashboardPresenterProtocol?  { get set }
    func reloadCollectionView()
    func reloadTableView()
    func showAlert(message: String)
}
