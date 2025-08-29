//
//  HoldingCell.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//


import UIKit

final class HoldingCell: UITableViewCell {
    static let reuseID = "HoldingCell"

    private lazy var nameLabel: UILabel = {
        let l = UILabel(); 
        l.font = .preferredFont(forTextStyle: .headline);
        l.numberOfLines = 1
        l.setContentHuggingPriority(.defaultHigh, for: .vertical)
        l.setContentCompressionResistancePriority(.required, for: .vertical)
        return l
    }()

    private lazy var ltpLabel: UILabel = {
        let l = UILabel();
        l.numberOfLines = 1
        l.font = .preferredFont(forTextStyle: .subheadline); l.textAlignment = .right;
        l.setContentHuggingPriority(.defaultHigh, for: .vertical)
        l.setContentCompressionResistancePriority(.required, for: .vertical)
        return l
    }()

    private lazy var qtyLabel: UILabel = {
        let l = UILabel();
        l.numberOfLines = 1
        l.font = .preferredFont(forTextStyle: .footnote);
        l.textColor = .secondaryLabel;
        l.setContentHuggingPriority(.defaultHigh, for: .vertical)
        l.setContentCompressionResistancePriority(.required, for: .vertical)
        return l
    }()

    private lazy var pnlLabel: UILabel = {
        let l = UILabel();
        l.numberOfLines = 1
        l.font = .preferredFont(forTextStyle: .subheadline);
        l.textAlignment = .right;
        l.setContentHuggingPriority(.defaultHigh, for: .vertical)
        l.setContentCompressionResistancePriority(.required, for: .vertical)
        return l
    }()

    private lazy var leftStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [nameLabel, qtyLabel])
        s.axis = .vertical;
        s.spacing = 4
        s.distribution = .fill
        return s
    }()

    private lazy var rightStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [ltpLabel, pnlLabel])
        s.axis = .vertical;
        s.alignment = .trailing
        s.distribution = .fill
        s.spacing = 4
        return s
    }()

    private lazy var hStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [leftStack, rightStack])
        s.axis = .horizontal;
        s.distribution = .equalSpacing
        return s
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with vm: HoldingRowViewModel) {
        nameLabel.text = vm.name
        ltpLabel.text = vm.ltpText
        qtyLabel.text = vm.qtyText
        pnlLabel.text = vm.pnlText
        pnlLabel.textColor = vm.pnlColor
    }
}
