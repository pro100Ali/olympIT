//
//  SelecteableBottomSheet.swift
//  OlympIt
//
//  Created by Nariman on 08.05.2024.
//

import UIKit
import PanModal

protocol SelectableBottomSheetDelegate: AnyObject {
    func didSelect(type: LessonType)
}

final class SelectableBottomSheet: UIViewController {
    weak var delegate: SelectableBottomSheetDelegate?
    
    private lazy var theoryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(theoryDidTap), for: .touchUpInside)
        button.backgroundColor = ._252527
        button.setTitle("Теория", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var practiceButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(practiceDidTap), for: .touchUpInside)
        button.backgroundColor = ._252527
        button.setTitle("Практика", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    init(delegate: AnyObject) {
        self.delegate = delegate as? SelectableBottomSheetDelegate
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

private extension SelectableBottomSheet {
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

private extension SelectableBottomSheet {
    @objc func theoryDidTap() {
        delegate?.didSelect(type: .theory)
    }
    
    @objc func practiceDidTap() {
        delegate?.didSelect(type: .practice)
    }
}

extension SelectableBottomSheet: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(284)
    }
}
