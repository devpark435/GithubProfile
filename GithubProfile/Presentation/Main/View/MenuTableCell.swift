//
//  MenuTableCell.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import Then
import SnapKit

class MenuTableCell: UITableViewCell {
    // MARK: - Properties
    let customImageView = UIImageView().then {
        $0.contentMode = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .lightGray
    }
    
    let customLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    let customSymbolImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // MARK: - setupViews & Constraints
    private func setupViews() {
        contentView.addSubview(customImageView)
        contentView.addSubview(customLabel)
        contentView.addSubview(customSymbolImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        customImageView.snp.makeConstraints{
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        customLabel.snp.makeConstraints{
            $0.leading.equalTo(customImageView.snp.trailing).offset(16)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        customSymbolImageView.snp.makeConstraints{
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    }
    
    // MARK: - Configure
    func configure(with data: (image: UIImage?, title: String, symbolName: String)) {
        customImageView.image = data.image
        customLabel.text = data.title
        customSymbolImageView.image = UIImage(systemName: data.symbolName)
    }
}
