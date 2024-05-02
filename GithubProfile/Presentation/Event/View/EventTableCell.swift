//
//  EventTableCell.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then
import Kingfisher
import SnapKit

class EventTableCell: UITableViewCell{
    // MARK: - Properties
    let actorAvatarImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let actorNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .black
    }
    
    let repoNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    
    let eventTimeLabel = UILabel().then {
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
        contentView.addSubview(actorAvatarImageView)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(repoNameLabel)
        contentView.addSubview(eventTimeLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        actorAvatarImageView.snp.makeConstraints{
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.top.equalTo(contentView.snp.top).offset(8)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        actorNameLabel.snp.makeConstraints{
            $0.leading.equalTo(actorAvatarImageView.snp.trailing).offset(8)
            $0.top.equalTo(contentView.snp.top).offset(8)
        }
        
        repoNameLabel.snp.makeConstraints{
            $0.leading.equalTo(actorAvatarImageView.snp.trailing).offset(8)
            $0.top.equalTo(actorNameLabel.snp.bottom).offset(8)
        }
        
        eventTimeLabel.snp.makeConstraints{
            $0.leading.equalTo(actorAvatarImageView.snp.trailing).offset(8)
            $0.top.equalTo(repoNameLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
    }
    
    // MARK: - Configure Cell
    func configureCell(event: EventModel) {
        switch event.type {
        case "CreateEvent":
            actorAvatarImageView.image = UIImage(named: "create")
            actorNameLabel.textColor = .systemCyan
        case "IssuesEvent":
            actorAvatarImageView.image = UIImage(named: "issue-opened")
            actorNameLabel.textColor = .systemGreen
        case "PushEvent":
            actorAvatarImageView.image = UIImage(named: "repo-push")
            actorNameLabel.textColor = .systemBlue
        case "PullRequestEvent":
            actorAvatarImageView.image = UIImage(named: "git-pull-request")
            actorNameLabel.textColor = .systemPurple
        default:
            actorAvatarImageView.image = UIImage(named: "code")
        }
        actorNameLabel.text = event.type
        repoNameLabel.text = event.repo.name
        eventTimeLabel.text = event.createdAt.convertToCustomFormat()
    }
}
