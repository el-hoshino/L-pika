//
//  View.swift
//  L-pika
//
//  Created by 史　翔新 on 2016/11/21.
//  Copyright © 2016年 net.crazism. All rights reserved.
//

import UIKit
import Eltaso

class View: UIView {
	
	lazy var textField: UITextField = {
		let field = UITextField()
		field.borderStyle = .roundedRect
		return field
	}()
	lazy var confirmButton: UIButton = {
		let button = UIButton()
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
	}
	
	convenience init() {
		self.init(frame: .zero)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		self.addSubview(self.textField)
		self.addSubview(self.confirmButton)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let buttonSize = CGSize(width: 50, height: 30)
		let subviewHorizontalMargin: CGFloat = 10
		let subviewOriginY = (self.frame.height * 0.3) - (buttonSize.height / 2)
		
		self.textField.frame.origin.x = subviewHorizontalMargin
		self.textField.frame.origin.y = subviewOriginY
		self.textField.frame.size.width = self.frame.width - buttonSize.width - (subviewHorizontalMargin * 3)
		self.textField.frame.size.height = buttonSize.height
		
		self.confirmButton.frame.origin.x = self.frame.width - buttonSize.width - subviewHorizontalMargin
		self.confirmButton.frame.origin.y = subviewOriginY
		self.confirmButton.frame.size = buttonSize
		
	}
	
}
