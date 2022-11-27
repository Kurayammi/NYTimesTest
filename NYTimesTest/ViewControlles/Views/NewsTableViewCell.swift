//
//  NewsTableViewCell.swift
//  NYTimesTest
//
//  Created by Kito on 11/25/22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    private var favoriteButton: UIButton!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var publishetAtLabel: UILabel!
    private var sourceLabel: UILabel!
    private var sectionLabel: UILabel!
    
    private var buttonHandler: ((NewsTableViewCell) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupButtons()
        setupLables()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.backgroundColor = .darkGray
    }
    
    func setData(data: CellDataModel,
                 buttonHandler: ((NewsTableViewCell) -> Void)? ) {
        titleLabel.text = data.title
        descriptionLabel.text = data.abstract
        sectionLabel.text = "section: " + data.section
        sourceLabel.text = "source: " + data.source
        publishetAtLabel.text = "Published at: " + data.published_date
        
        if data.isSaved {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        self.buttonHandler = buttonHandler
    }
    
    private func setupButtons() {
        favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        contentView.addSubview(favoriteButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        favoriteButton.addTarget(self, action: #selector(didTapCellButton(sender:)), for: .touchUpInside)
    }
    
    private func setupLables() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        
        publishetAtLabel = UILabel()
        publishetAtLabel.font = UIFont.systemFont(ofSize: 8)
        publishetAtLabel.textColor = .lightGray
        publishetAtLabel.numberOfLines = 1
        
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
        
        sectionLabel = UILabel()
        sectionLabel.font = UIFont.systemFont(ofSize: 8)
        sectionLabel.textColor = .lightGray
        sectionLabel.numberOfLines = 1
        
        sourceLabel = UILabel()
        sourceLabel.font = UIFont.systemFont(ofSize: 8)
        sourceLabel.textColor = .lightGray
        sourceLabel.numberOfLines = 1
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(publishetAtLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(sectionLabel)
        contentView.addSubview(sourceLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        sectionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        publishetAtLabel.translatesAutoresizingMaskIntoConstraints = false
        publishetAtLabel.leadingAnchor.constraint(equalTo: sectionLabel.trailingAnchor, constant: 5).isActive = true
        publishetAtLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        publishetAtLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        publishetAtLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        sourceLabel.trailingAnchor.constraint(equalTo: sectionLabel.leadingAnchor,constant: 5).isActive = true
        sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5).isActive = true
    }
    
    @objc private func didTapCellButton(sender: UIButton) {
        buttonHandler?(self)
    }
}
