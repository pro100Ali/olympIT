import UIKit
import PanModal

final class SelectableViewController: UIViewController {
    
    var selective: (URL) -> () = {_ in}
    var final: (URL) -> () = {_ in}
    
    var model: OlympModel
    
    private lazy var theoryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(theoryDidTap), for: .touchUpInside)
        button.backgroundColor = ._252527
        button.setTitle("Отборочный", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var practiceButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(practiceDidTap), for: .touchUpInside)
        button.backgroundColor = ._252527
        button.setTitle("Заключительный", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    init(model: OlympModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension SelectableViewController {
    func setupViews() {
        view.backgroundColor = ._37343B
        view.addSubviews(theoryButton, practiceButton)
    }
    
    func setupConstraints() {
        theoryButton.snp.makeConstraints { make in
            make.top.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(56)
            make.height.equalTo(100)
        }
        
        practiceButton.snp.makeConstraints { make in
            make.top.equalTo(theoryButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(56)
            make.height.equalTo(100)
        }
    }
}

private extension SelectableViewController {
    @objc func theoryDidTap() {
        guard let final = model.final else {return}
        selective(final)
    }
    
    @objc func practiceDidTap() {
        guard let sel = model.selective else {return}
        selective(sel)
    }
}

extension SelectableViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(284)
    }
}
