//
//  MessageView.swift
//  Discography
//
//  Created by Dario Fanjul on 08/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import UIKit

class MessageView: UIView {

    //MARK: - IBOutlets
    var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    var buttonAction: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Private
    private let space: CGFloat = 12.0
    
    //MARK: - Properties
    var title: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }
    var action: (() -> Void)? {
        didSet {
            buttonAction.isHidden = action == nil
        }
    }
    var actionTitle: String? {
        get {
            return buttonAction.title(for: .normal)
        }
        set {
            buttonAction.setTitle(newValue, for: .normal)
        }
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    //MARK: - Helpers
    private func commonInit() {
        addSubview(messageLabel)
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: space).isActive = true
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.6, constant: 0.0))
        addSubview(buttonAction)
        buttonAction.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstraint(NSLayoutConstraint(item: buttonAction, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.5, constant: 0.0))
        buttonAction.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc func buttonPressed(_ sender: UIButton) {
        action?()
    }
}
