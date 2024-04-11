//
//  ListTableViewController.swift
//  ProjectTableView
//
//  Created by doss-zstch1212 on 09/04/24.
//

import UIKit

class ListViewController: UITableViewController {
    private var sectionData = [
        SectionData(sectionTitle: "", cellData: [
            MenuCellData(title: "Search", symbol: UIImage(systemName: "magnifyingglass")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
            MenuCellData(title: "Top Charts", symbol: UIImage(systemName: "list.number")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
            MenuCellData(title: "Browse", symbol: UIImage(systemName: "square.grid.2x2")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
            MenuCellData(title: "Home", symbol: UIImage(systemName: "house")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
        ]),
        SectionData(sectionTitle: "Library", cellData: [
            MenuCellData(title: "Latest Episodes", symbol: UIImage(systemName: "clock")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
            MenuCellData(title: "Downloaded", symbol: UIImage(systemName: "arrow.down.circle")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
            MenuCellData(title: "Saved", symbol: UIImage(systemName: "bookmark")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
            MenuCellData(title: "Shows", symbol: UIImage(systemName: "square.stack")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
            MenuCellData(title: "Recently Added", symbol: UIImage(systemName: "checkmark.circle")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
        ]),
        SectionData(sectionTitle: "Stations", cellData: [
            MenuCellData(title: "New Station", symbol: UIImage(systemName: "plus")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)),
        ]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupAndConfigureTableView()
    }
    
    private func setupAndConfigureTableView() {
        title = "Podcast"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsFocus = false
        
        
        tableView.register(MenuCustomCell.self, forCellReuseIdentifier: MenuCustomCell.reuseIdentifier)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionData[section].cellData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let headerView = UIView()  // Create a new view
        let headerLabel = UILabel(frame: CGRect(x: 114, y: 0, width: tableView.frame.width - 32, height: 32))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 26)
        headerLabel.text = sectionData[section].sectionTitle
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return UITableView.automaticDimension
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCustomCell.reuseIdentifier, for: indexPath) as! MenuCustomCell
        let cellData = sectionData[indexPath.section].cellData.reversed()[indexPath.row]
        
        let newWidth: CGFloat = 200
        cell.contentView.frame.size.width = newWidth
        // Configure the cell...
        cell.configure(title: cellData.title, symbol: cellData.symbol)
        cell.backgroundColor = .systemGray6
        let selectedBgView = UIView(frame: CGRect(x: 0, y: 0, width: cell.contentView.frame.width, height: cell.contentView.frame.height))
        selectedBgView.backgroundColor = .systemIndigo
        cell.selectedBackgroundView = selectedBgView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == sectionData[2].cellData.endIndex - 1 {
                addNewStation()
            }
        }
        
        guard let detailViewController = getViewController(for: indexPath) else { return }
        let navigationController = UINavigationController(rootViewController: detailViewController)
        splitViewController?.setViewController(navigationController, for: .secondary)
    }
}

extension ListViewController {
    private func getViewController(for indexPath: IndexPath) -> UIViewController? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return HomeViewController()
            case 1:
                return BrowseViewController()
            case 2:
                return TopChartsViewController()
            case 3:
                return SearchViewController()
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    private func addNewStation() {
        let newStationAlertController = UIAlertController(title: "New Station", message: nil, preferredStyle: .alert)
        // Add TextField
        newStationAlertController.addTextField { textField in
            textField.placeholder = "Title"
        }
        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        newStationAlertController.addAction(cancelAction)
        // add save action
        let saveAction = UIAlertAction(title: "Save", style: .default) { [self] _ in
            if let text = newStationAlertController.textFields?.first?.text {
                print("New cell added: \(text)")
                // TODO: Add new cell
                let newCellData = MenuCellData(title: text, symbol: UIImage(systemName: "gearshape")!.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal))
                sectionData[2].cellData.append(newCellData)
                tableView.reloadData()
            }
        }
        newStationAlertController.addAction(saveAction)
        // present the alert controller
        present(newStationAlertController, animated: true)
    }
}
