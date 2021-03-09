//
//  MeTableControllerHeader.swift
//  TinderClone
//
//  Created by Richard Price on 09/03/2021.
//

import UIKit

class MeTableControllerHeader: UITableViewHeaderFooterView {
    static let identifier = "Tableheader"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon_profile")
        return imageView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height - 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("we dont care about storyboards")
    }
}
