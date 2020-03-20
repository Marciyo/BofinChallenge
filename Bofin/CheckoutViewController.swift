//
//  ViewController.swift
//  Bofin
//
//  Created by Marcel Mierzejewski on 19/03/2020.
//  Copyright © 2020 marcelmierzejewski. All rights reserved.
//

import UIKit
import Combine

final class CheckoutViewController: UIViewController {
    private lazy var dataSource = makeDataSource()
    private let viewModel = CheckoutViewModel()
    private var cancellable: AnyCancellable?

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var totalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.dataSource = dataSource

        cancellable = viewModel.$products.sink { products in
            self.totalLabel.text = self.viewModel.prepareTotalString(from: products)
            self.updateTableView(with: products)
        }
    }

    // MARK: - Button Actions
    @IBAction func appleButtonTapAction(_ sender: Any) {
        viewModel.addProduct(type: .apple)
    }

    @IBAction func orangeButtonTapAction(_ sender: Any) {
        viewModel.addProduct(type: .orange)
    }
}

/// MARK: - TableViewDataSource
private extension CheckoutViewController {
    enum Section {
        case checkout
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, Product> {
        UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, contact in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: UITableViewCell.self),
                    for: indexPath
                )

                cell.textLabel?.text = "\(contact.name)"

                return cell
        }
        )
    }

    func updateTableView(with products: [Product], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.checkout])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}
