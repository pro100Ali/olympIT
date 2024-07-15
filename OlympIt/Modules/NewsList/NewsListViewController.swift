import UIKit
import SnapKit

final class NewsListViewController: UIViewController, NewsListViewProtocol {
    
	var presenter: NewsListPresenterProtocol?
    
    var filteredData: [NewsModel] = []

    private lazy var emptyCase: UILabel = {
        let label = UILabel()
        label.text = "Ничего не найдено"
        label.textColor = .gray
        label.isHidden = true
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = ._727274
        return view
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = .white
        searchBar.searchBarStyle = .minimal
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.font = .systemFont(ofSize: 15)
            searchTextField.textColor = .white
            searchTextField.backgroundColor = .clear
            searchTextField.leftView?.tintColor = .white
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Поиск",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        }
        searchBar.delegate = self
        return searchBar
    }()

    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(InitialNewsTableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.layer.masksToBounds = true
        table.layer.borderColor = UIColor._727274.cgColor
        table.layer.borderWidth = 0
        table.layer.cornerRadius = 30
        table.clipsToBounds = true
        return table
    }()
    
    func addTopAndBottomBorders() {
       let thickness: CGFloat = 2.0
       let topBorder = CALayer()
       let bottomBorder = CALayer()
       topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.tableView.frame.size.width, height: thickness)
       topBorder.backgroundColor = UIColor.red.cgColor
       bottomBorder.frame = CGRect(x:0, y: self.tableView.frame.size.height - thickness, width: self.tableView.frame.size.width, height:thickness)
       bottomBorder.backgroundColor = UIColor.red.cgColor
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setLeftAlignedNavigationItemTitle(text: "Новости", color: .white)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    private func setupUI() {
        view.backgroundColor = ._37343B
        tableView.backgroundColor = ._37343B
        let uiview = UIView()
        backView.addSubviews(uiview)
        view.addSubview(emptyCase)
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }

        view.addSubviews(backView)
        backView.addSubviews(tableView)
        uiview.backgroundColor = ._37343B
        tableView.bringSubviewToFront(view)
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        emptyCase.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(50)
        }
        
        uiview.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(1)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalToSuperview().inset(2)
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            guard let news = self?.presenter?.news else {return}
            self?.filteredData = news
            self?.tableView.reloadData()
        }
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InitialNewsTableViewCell
        if !filteredData.isEmpty {
            cell.configure(news: filteredData[indexPath.row], isDashboard: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItemNews(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

extension NewsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let news = presenter?.news else {return}
        filteredData = news

        if !searchText.isEmpty {
            filteredData = news.filter({ $0.title.contains(searchBar.text ?? "") })
        }
        if filteredData.isEmpty {
            emptyCase.isHidden = false
            backView.isHidden = true
        } else {
            emptyCase.isHidden = true
            backView.isHidden = false
        }
        tableView.reloadData()
    }
}
