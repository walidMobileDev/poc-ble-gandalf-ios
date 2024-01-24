//
//  String+Extensions.swift
//  CoreBluetoothLESample
//
//  Created by Mehdi CHENNOUFI on 28/11/2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

extension String {
	
	// MARK: - For Hexa formatted string extensions
	var hexadecimal: Data? {
		var data = Data(capacity: self.count / 2)
		
		let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
		regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
			let byteString = (self as NSString).substring(with: match!.range)
			let num = UInt8(byteString, radix: 16)!
			data.append(num)
		}
		
		guard data.count > 0 else { return nil }
		
		return data
	}
	
}

extension Data {
    func toHexString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

