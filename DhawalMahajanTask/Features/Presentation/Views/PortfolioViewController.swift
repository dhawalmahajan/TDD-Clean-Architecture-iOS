//
//  PortfolioViewController.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import UIKit

final class PortfolioViewController: UIViewController {
    private let viewModel: PortfolioViewModel
    private var rows: [HoldingRowViewModel] = []
    private var summaryHeightConstraint: NSLayoutConstraint!
    // MARK: Lazy UI
    private lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.register(HoldingCell.self, forCellReuseIdentifier: HoldingCell.reuseID)
        t.dataSource = self;
        t.delegate = self
        t.translatesAutoresizingMaskIntoConstraints = false
        t.tableFooterView = UIView()
        t.tableFooterView?.backgroundColor = .systemBackground
        return t
    }()
    

    private lazy var summaryCard: PortfolioSummaryView = {
        let v = PortfolioSummaryView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.onToggle = { [weak self] in 
            self?.summaryHeightConstraint.constant = self?.summaryCard.isExpanded ?? false ? 200 : 60
            self?.viewModel.toggleSummary()
        }
        return v
    }()

    init(viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        layout()
        viewModel.output = self
        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Print actual colors
        print("SummaryView background =", summaryCard.backgroundColor ?? .clear)
        print("TableFooter background =", tableView.tableFooterView?.backgroundColor ?? .clear)
    }
    private func layout() {
        view.addSubview(tableView)
        view.addSubview(summaryCard)
        summaryHeightConstraint = summaryCard.heightAnchor.constraint(equalToConstant: 60)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: summaryCard.topAnchor),

            summaryCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            summaryCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            summaryHeightConstraint
        ])
    }
}

extension PortfolioViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HoldingCell.reuseID, for: indexPath) as? HoldingCell else { return UITableViewCell()
        }
        cell.configure(with: rows[indexPath.row])
        return cell
    }
}



extension PortfolioViewController: PortfolioViewModelOutput {
    func render(state: PortfolioViewModel.State) {
        switch state {
        case .loading:
            // Could add loader state
            debugPrint("Loading")
        case .error(let message):
            DispatchQueue.main.async {[weak self] in
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        case .loaded(let rows, let summary, let isExpanded):
            DispatchQueue.main.async {[weak self] in
                self?.rows = rows
                self?.summaryCard.bind(summary, expanded: isExpanded)
                self?.tableView.reloadData()
                
            }
        }
    }
}
