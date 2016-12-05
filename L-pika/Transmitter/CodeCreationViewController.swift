//
//  CodeCreationViewController.swift
//  L-pika
//
//  Created by 史　翔新 on 2016/11/30.
//  Copyright © 2016年 net.crazism. All rights reserved.
//

import UIKit
import Eltaso
import Alizes

protocol CodeCreationViewControllerDelegate: class {
	func codeCreationViewControllerWillBiginTextInput(_ codeCreationViewController: CodeCreationViewController)
}

class CodeCreationViewController: UIViewController {
	
	weak var delegate: CodeCreationViewControllerDelegate?
	
	var shouldBeUnderTextInputMode = false
	
	private(set) lazy var creationView: CodeCreationView = {
		let view = CodeCreationView()
		view.delegate = self
		return view
	}()
	
	private(set) lazy var converter: Converter = {
		let converter = Converter()
		return converter
	}()
	
	override func loadView() {
		let view = self.creationView
		view.frame = UIScreen.main.bounds
		self.view = view
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.automaticallyAdjustsScrollViewInsets = false
		
		self.creationView.beginTextInputButton.addTarget(self, action: #selector(CodeCreationViewController.onButtonTapped(_:)), for: .touchUpInside)
	}
	
}

extension CodeCreationViewController {
	
	@objc fileprivate func onButtonTapped(_ sender: UIButton) {
		
		switch sender {
		case self.creationView.beginTextInputButton:
			self.shouldBeUnderTextInputMode = true
			self.delegate?.codeCreationViewControllerWillBiginTextInput(self)
			
		default:
			break
		}
		
	}
	
}

extension CodeCreationViewController {
	
	func updateControllerStatusDependingOnTextInputMode() {
		
		switch self.shouldBeUnderTextInputMode {
		case true:
			self.beginTextInput()
			
		case false:
			self.endTextInput()
		}
		
	}
	
	private func beginTextInput() {
		
		DispatchQueue.runMainQueueWork(forcedSync: false) {
			
			do {
				try self.creationView.beginTextInput()
				
			} catch let error {
				Console.shared.warning(error)
			}
			
		}
		
	}
	
	private func endTextInput() {
		
		DispatchQueue.runMainQueueWork(forcedSync: false) {
			
			do {
				try self.creationView.endTextInput()
				
			} catch let error {
				Console.shared.warning(error)
			}
			
		}
		
	}
	
}

extension CodeCreationViewController: CodeCreationViewDelegate {
	
	func codeCreationView(_ codeCreationView: CodeCreationView, didEndTextInputWithText text: String?) {
		if let text = text {
			let code = self.converter.convert(text, to: .baudotCode)
			self.creationView.displayCode(code.description)
		}
	}
	
}
