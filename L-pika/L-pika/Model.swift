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
	
	func sendMessage(_ message: String) {
		
		let unitCodeTimeInterval: TimeInterval = 0.1
		let morseCode = MorseCode.Sentence(message)
		
		DispatchQueue.global().async {
			
			morseCode.groupedBinaryCode.forEach({ (codeGroup) in
				let codeTimeInterval = unitCodeTimeInterval * TimeInterval(codeGroup.length)
				self.turnTorchMode(to: codeGroup.code.torchMode, for: codeTimeInterval)
			})
			
			self.turnTorchMode(to: .off)
			
		}
		
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

extension BinaryCode.Code {
	
	var torchMode: AVCaptureTorchMode {
		switch self {
		case .i:
			return .on
			
		case .o:
			return .off
		}
	}
	
}
