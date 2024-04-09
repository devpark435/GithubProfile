//
//  MenuTableCell.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then

class MenuTableCell: UITableViewCell {
    let customImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .gray
    }
    
    let customLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    let customSymbolImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(customImageView)
        contentView.addSubview(customLabel)
        contentView.addSubview(customSymbolImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        customSymbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 40),
            customImageView.heightAnchor.constraint(equalToConstant: 40),
            
            customLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            customSymbolImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customSymbolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customSymbolImageView.widthAnchor.constraint(equalToConstant: 24),
            customSymbolImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with data: (image: UIImage?, title: String, symbolName: String)) {
        customImageView.image = data.image
        customLabel.text = data.title
        customSymbolImageView.image = UIImage(systemName: data.symbolName)
    }
}
