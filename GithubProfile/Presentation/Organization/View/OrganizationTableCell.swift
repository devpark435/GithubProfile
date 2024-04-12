//
//  OrganizationTableCell.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then
import Kingfisher

class OrganizationTableCell: UITableViewCell {
    // MARK: - Properties
    let orgAvatarImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    let orgNameLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .black
    }
    let orgDescriptionLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .gray
        $0.numberOfLines = 0
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // MARK: - SetupViews & Constraints
    func setupViews(){
        contentView.addSubview(orgAvatarImageView)
        contentView.addSubview(orgNameLabel)
        contentView.addSubview(orgDescriptionLabel)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            orgAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            orgAvatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            orgAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            orgAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            
            orgNameLabel.leadingAnchor.constraint(equalTo: orgAvatarImageView.trailingAnchor, constant: 16),
            orgNameLabel.topAnchor.constraint(equalTo: orgAvatarImageView.topAnchor, constant: 8),
            
            orgDescriptionLabel.topAnchor.constraint(equalTo: orgNameLabel.bottomAnchor, constant: 8),
            orgDescriptionLabel.leadingAnchor.constraint(equalTo: orgAvatarImageView.trailingAnchor, constant: 16),
            orgDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(org: OrganizationModel){
        orgNameLabel.text = org.login
        orgDescriptionLabel.text = org.description
        if let avatarURL = URL(string: org.avatarURL) {
            orgAvatarImageView.kf.setImage(with: avatarURL)
        }
    }
    
    
}
