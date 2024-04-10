//
//  OrganizationViewController.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then

class OrganizationViewController: UIViewController{
    
    @IBOutlet weak var organizationTableView: UITableView!
    var orgs: [OrganizationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetOrganizationData.shared.getOrganizationData { result in
            switch result {
            case .success(let organizations):
                self.orgs = organizations
                
                DispatchQueue.main.async {
                    self.organizationTableView.reloadData()
                }
            case .failure(let error):
                // 에러 처리
                print("Error: \(error)")
            }
        }
        organizationTableView.delegate = self
        organizationTableView.dataSource = self
    }
}
extension OrganizationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgs.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationTableCell", for: indexPath) as! OrganizationTableCell
        
        let org = orgs[indexPath.row]
        cell.configure(org: org)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let org = orgs[indexPath.row]
        
        guard let url = URL(string: org.url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
