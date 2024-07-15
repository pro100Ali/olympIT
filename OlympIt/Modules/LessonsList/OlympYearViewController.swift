import UIKit

final class OlympYearViewController: UIViewController, UISearchControllerDelegate {
    
    var completion: (OlympModel) -> () = {_ in}
    
    let viewModel: OlympViewModel
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OlympTableViewCell.self)
        return tableView
    }()
    
//    private var searchController: UISearchController = {
//        let viewController = UISearchController(searchResultsController: nil)
//        return viewController
//    }()
    
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
    
    init(viewModel: OlympViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        viewModel.getOlymp()
        viewModel.completion = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = ._37343B
        tableView.backgroundColor = ._37343B
        view.addSubview(tableView)
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
//        navigationItem.searchController = searchController
//        searchController.delegate = self
//        searchController.searchBar.delegate = self
//        searchController.searchBar.searchTextField.placeholder = "Что вы хотите найти?"
//        searchController.searchBar.searchTextField.tintColor = .white
//        searchController.searchBar.barStyle = .black
//        searchController.searchBar.searchTextField.textColor = .white
    }
    
    private func setupConstraints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(5)
        }
    }
}

extension OlympYearViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OlympTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let olymp = viewModel.filteredData[indexPath.row]
        cell.configure(model: olymp)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion(viewModel.lessons[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
}

extension OlympYearViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredData = viewModel.lessons

        if !searchText.isEmpty {
            viewModel.filteredData = viewModel.lessons.filter({ $0.year!.contains(searchText) })
        }
        print(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        presenter?.search(searchText: "")
    }
}
