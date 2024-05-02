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
    var isLoadingLast = false
    var activityIndicator: UIActivityIndicatorView!
    
    let refreshControl = UIRefreshControl()
    
    let searchController = UISearchController(searchResultsController: nil).then{
        $0.searchBar.placeholder = "Search repositories"
    }
    
    var page = 1
    
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
        
        // Set up search controller
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        
        fetchRepositories()
    }
    
    @objc func refreshData() {
        repositories.removeAll()
        fetchRepositories()
    }
    
    func setActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 0.098, green: 0.251, blue: 0.145, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    func loadMoreData() {
        guard !isLoading else {
            return
        }
        if isLoadingLast == true {
            print("마지막 페이지까지 불러왔어요.")
            DispatchQueue.main.async {
                // repositories가 비어있을 때 알림 표시
                let alert = UIAlertController(title: "알림", message: "저장소가 없습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()
            }
            return
        }
        isLoading = true
        page += 1
        activityIndicator.startAnimating()
        
        fetchRepositories()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.repoTableView.reloadData()
            self.isLoading = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func fetchRepositories() {
        GetRepoData.shared.getRepoData(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repositories):
                if repositories.isEmpty == true {
                    self.isLoadingLast = true
                    return
                }
                self.repositories.append(contentsOf: repositories)
                print("Repositories: \(self.repositories.count)")
                
                DispatchQueue.main.async {
                    self.repoTableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
extension RepoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return displayedRepositories.count
        } else {
            return repositories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepoListTableCell else {
            return UITableViewCell()
        }
        
        let repository: Repository
        if searchController.isActive {
            repository = displayedRepositories[indexPath.row]
        } else {
            repository = repositories[indexPath.row]
        }
        
        cell.configureCell(repository: repository)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository: Repository
        if searchController.isActive {
            repository = displayedRepositories[indexPath.row]
        } else {
            repository = repositories[indexPath.row]
        }
        
        guard let url = URL(string: repository.htmlURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            // 마지막 셀에 도달한 경우
            if !searchController.isActive {
                loadMoreData()
            }
        }
    }
}
extension RepoViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        displayedRepositories = repositories.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        repoTableView.reloadData()
    }
}
