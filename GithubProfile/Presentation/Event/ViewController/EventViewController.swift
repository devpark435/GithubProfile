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
    var displayedEvents: [EventModel] = []
    var isLoading = false
    var activityIndicator: UIActivityIndicatorView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up refresh control
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        eventTableView.refreshControl = refreshControl
        
        // Set up activity indicator
        setActivityIndicator()
        view.addSubview(activityIndicator)
        
        loadInitialData()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
    }
    
    @objc func refreshData() {
        displayedEvents.removeAll()
        loadInitialData()
    }
    
    func loadInitialData() {
        fetchEvents { [weak self] events in
            guard let self = self else { return }
            let initialEvents = Array(events.prefix(8))
            self.displayedEvents.append(contentsOf: initialEvents)
            DispatchQueue.main.async {
                self.eventTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func loadMoreData() {
        guard !isLoading, displayedEvents.count < events.count else { return }
        
        isLoading = true
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let currentCount = self.displayedEvents.count
            let nextCount = min(currentCount + 8, self.events.count)
            let newRepositories = Array(self.events[currentCount..<nextCount])
            self.displayedEvents.append(contentsOf: newRepositories)
            
            DispatchQueue.main.async {
                self.eventTableView.reloadData()
                self.isLoading = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func setActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 0.098, green: 0.251, blue: 0.145, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    func fetchEvents(completion: @escaping ([EventModel]) -> Void) {
        GetEventData.shared.getEventData { result in
            switch result {
            case .success(let events):
                self.events = events
                completion(events)
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension EventViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableCell", for: indexPath) as? EventTableCell else {
            return UITableViewCell()
        }
        
        let events = displayedEvents[indexPath.row]
        cell.configureCell(event: events)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let events = displayedEvents[indexPath.row]
        let originalString = events.repo.url
        var desiredString = originalString.replacingOccurrences(of: "api.github.com/repos", with: "github.com")
        switch events.type {
        case "IssuesEvent":
            desiredString = desiredString + "/issues"
        case "PushEvent":
            desiredString = desiredString + "/commits"
        case "PullRequestEvent":
            desiredString = desiredString + "/pulls"
        default:
            break
        }
        guard let url = URL(string: desiredString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > contentHeight - height {
            loadMoreData()
        }
    }
}
