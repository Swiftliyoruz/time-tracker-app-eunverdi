//
//  ViewController.swift
//  TimeTrackerApp
//
//  Created by Ensar Batuhan Ünverdi on 14.09.2022.
//

import UIKit

final class StatusPageViewController: UIViewController {
    
    private var durationTimer = 35
    private var taskFromPersistance: [TaskModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var taskNameLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.showsVerticalScrollIndicator = false
            tableView.register(UINib(nibName: TaskTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TaskTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTaskFromPersistance()
        timerLabel.text = "\(durationTimer)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        fetchTaskFromPersistance()
    }
    
    private func fetchTaskFromPersistance() {
        CoreDataManager.shared.getTaskFromPersistance { result in
            switch result {
            case .success(let tasks):
                self.taskFromPersistance = tasks
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func detailButtonClicked(_ sender: Any) {
        let detailVC = DetailViewController.instantiate()
        detailVC.durationTimer = durationTimer
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func seeAllButtonTapped(_ sender: UIButton) {
        let allTaskVC = AllTaskViewController.instantiate()
        navigationController?.pushViewController(allTaskVC, animated: true)
    }
}

extension StatusPageViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        taskFromPersistance.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spaceView = UIView()
        spaceView.backgroundColor = view.backgroundColor
        return spaceView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constant.headerHeightInSection
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController.instantiate()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
