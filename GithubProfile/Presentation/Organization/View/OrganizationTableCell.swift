//
//  OrganizationTableCell.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then
import Kingfisher
import SnapKit

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
        orgAvatarImageView.snp.makeConstraints{
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        
        orgNameLabel.snp.makeConstraints{
            $0.leading.equalTo(orgAvatarImageView.snp.trailing).offset(16)
            $0.top.equalTo(orgAvatarImageView.snp.top).offset(8)
        }
        
        orgDescriptionLabel.snp.makeConstraints{
            $0.top.equalTo(orgNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(orgAvatarImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
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
