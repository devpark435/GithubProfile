//
//  RepoViewController.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then

class RepoViewController: UIViewController {
    
    @IBOutlet weak var repoTableView: UITableView!
    var repositories: [Repository] = []
    var displayedRepositories: [Repository] = []
    var isLoading = false
    var activityIndicator: UIActivityIndicatorView!
    
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repoTableView.delegate = self
        repoTableView.dataSource = self
        
        // Set up refresh control
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        repoTableView.refreshControl = refreshControl
        
        // Set up activity indicator
        setActivityIndicator()
        view.addSubview(activityIndicator)
        
        loadInitialData()
        
    }
    
    @objc func refreshData() {
        displayedRepositories.removeAll()
        loadInitialData()
    }
    
    func setActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 0.098, green: 0.251, blue: 0.145, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    func loadInitialData() {
        fetchRepositories { [weak self] repositories in
            guard let self = self else { return }
            let initialRepositories = Array(repositories.prefix(8))
            self.displayedRepositories.append(contentsOf: initialRepositories)
            DispatchQueue.main.async {
                self.repoTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func loadMoreData() {
        guard !isLoading, displayedRepositories.count < repositories.count else {
            return
        }
        
        isLoading = true
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let currentCount = self.displayedRepositories.count
            let nextCount = min(currentCount + 8, self.repositories.count)
            let newRepositories = Array(self.repositories[currentCount..<nextCount])
            self.displayedRepositories.append(contentsOf: newRepositories)
            
            DispatchQueue.main.async {
                self.repoTableView.reloadData()
                self.isLoading = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func fetchRepositories(completion: @escaping ([Repository]) -> Void) {
        GetRepoData.shared.getRepoData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                completion(repositories)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion([])
            }
        }
    }
}
extension RepoViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepoListTableCell else {
            return UITableViewCell()
        }
        
        let repository = displayedRepositories[indexPath.row]
        cell.configureCell(repository: repository)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = displayedRepositories[indexPath.row]
        
        guard let url = URL(string: repository.htmlURL) else { return }
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
