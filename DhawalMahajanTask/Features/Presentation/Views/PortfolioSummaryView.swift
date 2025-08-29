//
//  PortfolioSummaryView.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import UIKit

final class PortfolioSummaryView: UIView {
    var onToggle: (() -> Void)?
    
    private(set) var isExpanded: Bool = false
    private lazy var divider: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    private lazy var currentValueRow = makeRow(title: "Current value*")
    private lazy var totalInvestmentRow = makeRow(title: "Total investment*")
    private lazy var todaysPNLRow = makeRow(title: "Today’s Profit & Loss*")
    
    private lazy var pnlTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Profit & Loss*"
        l.font = .preferredFont(forTextStyle: .body)
//        l.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return l
    }()
    private lazy var chevron: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill"))
        //arrowtriangle.down.fill
        i.tintColor = .label
        return i
    }()
    private lazy var pnlValueLabel: UILabel = {
        let l = UILabel()
        l.font = .preferredFont(forTextStyle: .body)
        l.textAlignment = .right
        return l
    }()
    
    private lazy var headerButton: UIControl = {
        let c = UIControl()
        c.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        return c
    }()
    
    private lazy var headerStack: UIStackView = {
        let left = UIStackView(arrangedSubviews: [pnlTitleLabel, chevron])
        left.axis = .horizontal
        left.spacing = 6
        let s = UIStackView(arrangedSubviews: [left, pnlValueLabel])
        s.axis = .horizontal
        s.distribution = .fill
        s.spacing = 6
        return s
    }()
    
    private lazy var containerStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [currentValueRow.stack, totalInvestmentRow.stack, todaysPNLRow.stack, divider, headerStack])
        s.axis = .vertical
        s.spacing = 10
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUserInterface()
        setExpanded(false, animated: false)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setUpUserInterface() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 14
        layer.masksToBounds = true
        addSubview(containerStack)
        addSubview(headerButton) // overlay to capture taps
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            headerButton.topAnchor.constraint(equalTo: divider.bottomAnchor),
            headerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func bind(_ vm: SummaryViewModel, expanded: Bool) {
        setRow(currentValueRow, value: vm.currentValue)
        setRow(totalInvestmentRow, value: vm.totalInvestment)
        setRow(todaysPNLRow, value: vm.todaysPNL, color: vm.todaysPNL.hasPrefix("-") ? .pnlRed : .pnlGreen)
        pnlValueLabel.text = "\(vm.totalPNL) \(vm.pnlPercentText)"
        pnlValueLabel.textColor = vm.totalPNLColor
        setExpanded(expanded, animated: false)
    }
    
    @objc private func toggle() {
        setExpanded(!isExpanded, animated: true)
        onToggle?()
    }
    
    private func setExpanded(_ expand: Bool, animated: Bool) {
        isExpanded = expand
        [currentValueRow.stack, totalInvestmentRow.stack, todaysPNLRow.stack].forEach { $0.isHidden = !expand }
        chevron.transform = expand ? CGAffineTransform(rotationAngle: .pi) : .identity
        if animated {
            UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
//                self.layoutIfNeeded()
            })
        }
    }
    
    private func setRow(_ row:
                        (title: UILabel, value: UILabel, stack: UIStackView),
                        value: String,
                        color: UIColor? = nil
    ) {
        row.value.text = value
        if let color = color { row.value.textColor = color }
    }
    
    private func makeRow(title: String) -> (title: UILabel, value: UILabel, stack: UIStackView) {
        let t = UILabel()
        t.text = title
        t.font = .preferredFont(forTextStyle: .body)
        let v = UILabel()
        v.textAlignment = .right
        v.font = .preferredFont(forTextStyle: .body)
        let s = UIStackView(arrangedSubviews: [t, v])
        s.axis = .horizontal
        s.distribution = .fill
        return (t, v, s)
    }
}
