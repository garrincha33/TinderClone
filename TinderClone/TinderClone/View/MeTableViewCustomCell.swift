//
//  MeTableViewCustomCell.swift
//  TinderClone
//
//  Created by Richard Price on 09/03/2021.
//

import UIKit

class MeTableViewCustomCell: UITableViewCell {
    static let identifier = "MeTableViewCellIdentifier"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let lable: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 1
        return lable
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(lable)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 10, y: 6, width: size, height: size)
        
        let imageSize: CGFloat = size / 1.5
        iconImageView.frame = CGRect(x: (size-imageSize) / 2, y: 5, width: imageSize, height: imageSize)
        
        lable.frame = CGRect(x: 15 + iconContainer.frame.size.width, y: 0, width: contentView.frame.size.width - 15 - iconContainer.frame.size.width, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        lable.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: MeModel) {
        lable.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackGroundColor
    }
    
}
