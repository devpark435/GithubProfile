//
//  EventViewController.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then

class EventViewController: UIViewController{
    
    @IBOutlet weak var eventTableView: UITableView!
    var events: [EventModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        GetEventData.shared.getEventData { result in
            switch result {
            case .success(let events):
                self.events = events
                
                DispatchQueue.main.async {
                    self.eventTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        eventTableView.delegate = self
        eventTableView.dataSource = self
    }
}
extension EventViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableCell", for: indexPath) as! EventTableCell
        
        let events = events[indexPath.row]
        cell.configureCell(event: events)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let events = events[indexPath.row]
        
        guard let url = URL(string: events.repo.url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
