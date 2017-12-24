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
	lazy var resultView: UITextView = {
		let view = UITextView()
		view.isEditable = false
		return view
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
		self.addSubview(self.resultView)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let buttonSize = CGSize(width: 50, height: 30)
		let subviewMargin = CGSize(width: 10, height: 10)
		let subviewOriginY = (self.frame.height * 0.3) - (buttonSize.height / 2)
		
		do {
			let view = self.textField
			view.frame.origin.x = subviewMargin.width
			view.frame.origin.y = subviewOriginY
			view.frame.size.width = self.frame.width - buttonSize.width - (subviewMargin.width * 3)
			view.frame.size.height = buttonSize.height
		}
		
		do {
			let view = self.confirmButton
			view.frame.origin.x = self.frame.width - buttonSize.width - subviewMargin.width
			view.frame.origin.y = subviewOriginY
			view.frame.size = buttonSize
		}
		
		do {
			let view = self.resultView
			view.frame.origin.x = subviewMargin.width
			view.frame.origin.y = self.textField.frame.eltaso.bottom + subviewMargin.height
			view.frame.size.width = self.frame.width - (subviewMargin.width * 2)
			view.frame.size.height = 100
		}
		
	}
	
}
