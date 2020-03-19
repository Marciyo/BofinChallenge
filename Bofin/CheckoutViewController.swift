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

    @IBOutlet weak private var orangeButton: UIButton!
    @IBOutlet weak private var appleButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        tableView.register(UITableViewCell.self,
                   forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = dataSource

        cancellable = viewModel.$products.sink { products in
            self.update(with: products)
        }
    }

    // MARK: - Button Actions
    @IBAction func appleButtonAction(_ sender: Any) {
        viewModel.addProduct(type: .apple)
    }

    @IBAction func orangeButtonAction(_ sender: Any) {
        viewModel.addProduct(type: .orange)
    }
}

private extension CheckoutViewController {
    enum Section {
        case shoppingList
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, Product> {

        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, contact in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "UITableViewCell",
                    for: indexPath
                )

                cell.textLabel?.text = "\(contact.name). \(contact.price)p"

                return cell
            }
        )
    }

    func update(with products: [Product], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.shoppingList])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}
