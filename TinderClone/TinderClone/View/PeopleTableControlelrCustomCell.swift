//
//  PeopleTableControlelrCustomCell.swift
//  TinderClone
//
//  Created by Richard Price on 10/03/2021.
//

import UIKit

class PeopleTableControllerCustomCell: UITableViewCell {
    
    static let identifier = "PeopleCustomCell"
    
    let avatar: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "taylor_swift"))
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let messageImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "icon-chat"))
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let usernameLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 12)
        lable.textColor = .systemGreen
        lable.text = "Test Username"
        lable.textColor = .black
        return lable
    }()
    
    let statusLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 12)
        lable.textColor = .systemGreen
        lable.text = "Test Status"
        lable.textColor = .black
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
        contentView.addSubview(avatar)
        avatar.constrainWidth(constant: 64)
        avatar.constrainHeight(constant: 64)
        let hStack = hstack(avatar, VerticalStackView(arrangedSubviews: [usernameLable, statusLable]), UIView(), messageImage)
                hStack.padRight(20).spacing = 16
                hStack.padLeft(2).spacing = 16
                //hStack.padLeft(10)
                addSubview(hStack)
                hStack.fillSuperview()
    }
}