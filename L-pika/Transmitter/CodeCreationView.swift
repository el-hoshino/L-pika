//
//  CodeCreationView.swift
//  L-pika
//
//  Created by 史　翔新 on 2016/11/30.
//  Copyright © 2016年 net.crazism. All rights reserved.
//

import UIKit
import Eltaso

class CodeCreationView: UIView {
	
	lazy var beginTextInputButton: UIButton = {
		let button = UIButton()
		return button
	}()
	
	lazy var textInputView: UITextField = {
		let view = UITextField()
		view.backgroundColor = .blue
		return view
	}()
	
	lazy var codePreviewView: UITextView = {
		let view = UITextView()
		view.backgroundColor = .red
		view.isUserInteractionEnabled = false
		view.isSelectable = false
		return view
	}()
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		self.addSubview(self.beginTextInputButton)
		self.insertSubview(self.textInputView, belowSubview: self.beginTextInputButton)
		self.addSubview(self.codePreviewView)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self._layoutBeginTextInputButton()
		self._layoutTextInputView()
		self._layoutCodePreviewView()
	}
	
	private func _layoutBeginTextInputButton() {
		let button = self.beginTextInputButton
		button.frame.origin.x = 0
		button.frame.origin.y = 0
		button.frame.size.width = self.frame.width
		button.frame.size.height = 30
	}
	
	private func _layoutTextInputView() {
		let view = self.textInputView
		view.frame.origin.x = 0
		view.frame.origin.y = 0
		view.frame.size.width = self.frame.width
		view.frame.size.height = 30
	}
	
	private func _layoutCodePreviewView() {
		let view = self.codePreviewView
		view.frame.origin.x = 0
		view.frame.origin.y = self.textInputView.frame.bottom
		view.frame.size.width = self.frame.width
		view.frame.size.height = self.frame.height - view.frame.origin.y
	}
	
}

extension CodeCreationView {
	
	func beginTextInput() throws {
		
		enum Error: Swift.Error {
			case textInputViewUnableToBecomeFirstResponder
		}
		
		guard self.textInputView.canBecomeFirstResponder else {
			throw Error.textInputViewUnableToBecomeFirstResponder
		}
		
		self.beginTextInputButton.isHidden = true
		self.textInputView.becomeFirstResponder()
		
	}
	
	func endTextInput() throws {
		
		enum Error: Swift.Error {
			case textInputViewUnableToResignFirstResponder
		}
		
		guard self.textInputView.canResignFirstResponder else {
			throw Error.textInputViewUnableToResignFirstResponder
		}
		
		self.beginTextInputButton.isHidden = false
		self.textInputView.resignFirstResponder()
		
	}
	
}

extension CodeCreationView {
	
	func displayCode(_ code: String) {
		self.codePreviewView.text = code
	}
	
}
