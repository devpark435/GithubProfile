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
    var isLoading = false
    
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repoTableView.delegate = self
        repoTableView.dataSource = self
        
        fetchRepositories()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        repoTableView.refreshControl = refreshControl
        
    }
    
    @objc func refreshData() {
        repositories.removeAll()
        fetchRepositories()
    }
    
    func fetchRepositories() {
        isLoading = true
        GetRepoData.shared.getRepoData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                
                DispatchQueue.main.async {
                    self.repoTableView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.isLoading = false
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
extension RepoViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepoListTableCell
        
        let repository = repositories[indexPath.row]
        cell.configureCell(repository: repository)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        
        guard let url = URL(string: repository.htmlURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
