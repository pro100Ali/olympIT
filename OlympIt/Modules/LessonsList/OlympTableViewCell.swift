import UIKit

class OlympTableViewCell: UITableViewCell, ReusableView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ._252527
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = ._252527
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 5
        view.distribution = .fill
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._727274
        label.font = .systemFont(ofSize: 9, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: OlympModel) {
        titleLabel.text = model.year
        descriptionLabel.text = model.description
    }
}

extension OlympTableViewCell {
    func setupViews() {
        layer.cornerRadius = 12
        backgroundColor = ._37343B
        contentView.addSubview(containerView)
        
        containerView.addSubview(stackView)
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.bottom.equalToSuperview().inset(7)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        [titleLabel, descriptionLabel].forEach { stackView.addArrangedSubview($0)}
    }
}
