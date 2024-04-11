//
//  MenuCell.swift
//  ProjectTableView
//
//  Created by doss-zstch1212 on 09/04/24.
//

import UIKit

class MenuCustomCell: UITableViewCell {
    
    static let reuseIdentifier = "MenuCustomCell"
    
//    private lazy var containerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(titleLabel)
//        view.addSubview(symbolImageView)
//        view.layer.cornerRadius = 5
//        return view
//    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupSubViews() {
//        contentView.addSubview(containerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(symbolImageView)
        
//        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            symbolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            symbolImageView.heightAnchor.constraint(equalToConstant: 40),
            symbolImageView.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(title text: String, symbol image: UIImage) {
        titleLabel.text = text
        symbolImageView.image = image
    }

}
