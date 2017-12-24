//
//  ViewController.swift
//  L-pika
//
//  Created by 史　翔新 on 2016/11/18.
//  Copyright © 2016年 net.crazism. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let model = Model()
	let mainView = View()
	
	
	
	override func loadView() {
		self.mainView.frame = UIScreen.main.bounds
		self.view = self.mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.mainView.confirmButton.setTitle("OK", for: .normal)
		self.mainView.confirmButton.addTarget(self, action: #selector(ViewController.didTap(sender:)), for: .touchUpInside)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

extension ViewController {
	
	@objc fileprivate func didTap(sender: UIButton) {
		switch sender {
		case self.mainView.confirmButton:
			self.mainView.textField.resignFirstResponder()
			self.sendMessage()
			return
			
		default:
			return
		}
	}
	
}

extension ViewController {
	
	func sendMessage() {
		
		if let message = self.mainView.textField.text {
			let result = self.model.sendMessage(message, through: .morseCode)
			self.mainView.textField.text = result.text
			self.mainView.resultView.text = result.code
			
		}
	}
	
}
