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
        repoNameLabel.snp.makeConstraints{
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.top.equalTo(contentView.snp.top).offset(8)
        }
        
        repoDescriptionLabel.snp.makeConstraints{
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.top.equalTo(repoNameLabel.snp.bottom).offset(8)
        }
        
        languageLabel.snp.makeConstraints{
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.top.equalTo(repoDescriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
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
