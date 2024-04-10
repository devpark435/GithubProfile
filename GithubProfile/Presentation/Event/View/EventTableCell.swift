//
//  EventTableCell.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then
import Kingfisher

class EventTableCell: UITableViewCell{
    let actorAvatarImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .gray
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(actorAvatarImageView)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(repoNameLabel)
        contentView.addSubview(eventTimeLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        actorAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        actorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actorAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actorAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            actorAvatarImageView.widthAnchor.constraint(equalToConstant: 40),
            actorAvatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            actorNameLabel.leadingAnchor.constraint(equalTo: actorAvatarImageView.trailingAnchor, constant: 8),
            actorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            repoNameLabel.leadingAnchor.constraint(equalTo: actorAvatarImageView.trailingAnchor, constant: 8),
            repoNameLabel.topAnchor.constraint(equalTo: actorNameLabel.bottomAnchor, constant: 8),
            
            eventTimeLabel.leadingAnchor.constraint(equalTo: actorAvatarImageView.trailingAnchor, constant: 8),
            eventTimeLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 8),
            eventTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
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
