//
//  DPSideMenuItemCell.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 15/11/18.
//

import Foundation

private class IconView: UIImageView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 14, height: 14)
    }
}

extension DPSideMenuItemCell {
    public func set(title: String) {
        titleLabel.text = title
    }
    
    public func set(icon: UIImage) {
        iconImageView.image = icon
    }
}

public class DPSideMenuItemCell: UITableViewCell {
    
    fileprivate let iconImageView: IconView = {
        let imageView = IconView(image: nil)
        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView, titleLabel, UIView()
            ])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        stackView.spacing = 12
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 36, bottom: 16, right: 36)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
