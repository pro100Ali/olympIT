//
//  LessonDetailsCell.swift
//  OlympIt
//
//  Created by Nariman on 09.05.2024.
//

import UIKit

final class LessonDetailsCell: UITableViewCell, ReusableView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ._252527
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let accessoryCircleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = ._727274
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.isHidden = true
    }
    
    func configure(model: LessonOutput) {
        let accessoryBgColor: UIColor
        
        switch model.hardness {
        case .low:
            accessoryBgColor = .green
        case .medium:
            accessoryBgColor = .orange
        case .hard:
            accessoryBgColor = .red
        }
        
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        accessoryCircleView.backgroundColor = accessoryBgColor
        if let iconUrl = model.iconUrl {
            iconImage.kf.setImage(with: URL(string: iconUrl))
        } else {
            iconImage.isHidden = true
        }
    }
}

private extension LessonDetailsCell {
    func setupViews() {
        contentView.backgroundColor = ._37343B
        
        contentView.addSubviews(containerView)
        
        containerView.addSubviews(accessoryCircleView, titleLabel, descriptionLabel, iconImage)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.height.greaterThanOrEqualTo(110)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalTo(accessoryCircleView.snp.trailing).offset(4)
        }
        
        accessoryCircleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.size.equalTo(6)
            make.centerY.equalTo(titleLabel.snp.centerY).offset(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(accessoryCircleView.snp.leading)
            make.trailing.equalToSuperview().inset(16)
        }
        
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(64)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
