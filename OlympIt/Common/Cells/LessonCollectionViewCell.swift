//
//  LessonCollectionViewCell.swift
//  OlympIt
//
//  Created by Nariman on 04.04.2024.
//

import UIKit
import Kingfisher

final class LessonCollectionViewCell: UICollectionViewCell,
                                      ReusableView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = ._252527
        layer.cornerRadius = 12
        clipsToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(lessonModel: InitialLessonOutput) {
        nameLabel.text = lessonModel.name
        iconImageView.kf.setImage(with: lessonModel.iconUrl)
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.size.equalTo(52)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
