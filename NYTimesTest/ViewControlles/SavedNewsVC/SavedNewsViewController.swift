//
//  SavedNewsViewController.swift
//  NYTimesTest
//
//  Created by Kito on 11/26/22.
//

import UIKit

class SavedNewsViewController: UIViewController {
    private var newsTableView: UITableView!
    private let vm = SavedNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallbacks()
        setupTableView()
        vm.fetchFromCoreData()
    }
    
    private func setupTableView() {
        newsTableView = UITableView()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.backgroundColor = .red
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        newsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        newsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    private func setupCallbacks() {
        vm.onUpdate = { [weak self] in
            self?.newsTableView.reloadData()
        }
    }
    
    @objc private func openSection(button: UIButton) {
        let section = button.tag
        vm.onSectionTap(section: section)
    }
}

extension SavedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionsData = vm.sectionsData
        
        if sectionsData.isEmpty { return 0 }
        if sectionsData.count < section { return 0 }
        
        if sectionsData[section].isOpen {
            return sectionsData[section].num_result
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        
        let title = vm.sectionsData[section].title
        button.setTitle(title, for: .normal)
        button.tag = section
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)
        return button
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        vm.sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsTableViewCell else { return UITableViewCell()}
        
        let cellData = vm.sectionsData[indexPath.section].data[indexPath.row]
        cell.setData(data: cellData) {
            [weak self] cell in
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            self?.vm.onFavoriteButtonTapped(at: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsScreenViewController()
        let url = vm.sectionsData[indexPath.section].data[indexPath.row].url
        
        vc.url = url
        self.present(vc, animated: true)
    }
}

