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
			morseCode.binaryCode.codes.forEach { (code) in
				switch code {
				case .i:
					self.turnTorchMode(to: .on, for: unitCodeTimeInterval)
					
				case .o:
					self.turnTorchMode(to: .off, for: unitCodeTimeInterval)
				}
			}
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
