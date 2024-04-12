//
//  RepoListTableCell.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then

class RepoListTableCell: UITableViewCell{
    // MARK: - Properties
    let repoNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .black
    }
    
    let repoDescriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    
    let languageLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // MARK: - setupViews & Constraints
    private func setupViews() {
        contentView.addSubview(repoNameLabel)
        contentView.addSubview(repoDescriptionLabel)
        contentView.addSubview(languageLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repoNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            repoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            repoDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            repoDescriptionLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 8),
            
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            languageLabel.topAnchor.constraint(equalTo: repoDescriptionLabel.bottomAnchor, constant: 8),
            languageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    // MARK: - Configure Cell
    func configureCell(repository: Repository) {
        repoNameLabel.text = repository.name
        repoDescriptionLabel.text = repository.description ?? " "
        languageLabel.text = repository.language ?? " "
        switch repository.language {
        case "Swift":
            languageLabel.textColor = .orange
        case "Dart":
            languageLabel.textColor = .blue
        case .none:
            languageLabel.textColor = .gray
        case .some(_):
            languageLabel.textColor = .gray
        }
    }
}
