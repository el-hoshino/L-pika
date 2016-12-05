//
//  Model.swift
//  L-pika
//
//  Created by 史　翔新 on 2016/11/18.
//  Copyright © 2016年 net.crazism. All rights reserved.
//

import Foundation
import AVFoundation
import Eltaso
import Alizes

class Model: NSObject {
	
	private let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
	private let converter = Converter()
	
	private let torchQueue = DispatchQueue(label: "torch")
	
	@discardableResult
	func sendMessage(_ message: String, through code: Converter.Code) -> (text: String, code: String) {
		
		let unitCodeTimeInterval: TimeInterval = 0.1
		let code = self.converter.convert(message, to: code)
		let binaryCodeGroups = self.converter.group(code: code.binaryCodeContainer)
		
		self.torchQueue.async {
			
			binaryCodeGroups.forEach({ (binaryCodeGroup) in
				let codeTimeInterval = unitCodeTimeInterval * TimeInterval(binaryCodeGroup.length)
				self.turnTorchMode(to: binaryCodeGroup.code.torchMode, for: codeTimeInterval)
			})
			
			self.turnTorchMode(to: .off)
			
		}
		
		return (code.initializedString, code.description)
		
	}
	
	private func turnTorchMode(to mode: AVCaptureTorchMode, for interval: TimeInterval? = nil) {
		
		guard let device = self.device else {
			return
		}
		
		do {
			try device.lockForConfiguration()
			device.torchMode = mode
			device.unlockForConfiguration()
			
		} catch let error {
			Console.shared.warning(error)
		}
		
		if let interval = interval {
			Thread.sleep(forTimeInterval: interval)
		}
		
	}
	
}

extension BinaryCodeContainer.Code {
	
	var torchMode: AVCaptureTorchMode {
		switch self {
		case .i:
			return .on
			
		case .o:
			return .off
		}
	}
	
}
