//
//  ViewController.swift
//  TimeTrackerApp
//
//  Created by Ensar Batuhan Ünverdi on 14.09.2022.
//

import UIKit

final class StatusPageViewController: UIViewController {
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
    private var durationTimer = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(durationTimer)"
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
        2
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
