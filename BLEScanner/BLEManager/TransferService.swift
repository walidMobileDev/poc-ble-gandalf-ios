/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Transfer service and characteristics UUIDs
*/

import Foundation
import CoreBluetooth

enum TransferService {
//	static let serviceUUID = CBUUID(string: "E20A39F4-73F5-4BC4-A12F-17D1AD07A961")
//	static let characteristicUUID = CBUUID(string: "08590F7E-DB05-467E-8757-72F6FAEB13D4")
	
	static let serviceUUID = CBUUID(string: "c991e030-812f-4eb5-a314-8b51a7754c39".uppercased())
	static let RxCharacteristicUUID = CBUUID(string: "c991e032-812f-4eb5-a314-8b51a7754c39".uppercased())
	static let TxCharacteristicUUID = CBUUID(string: "c991e031-812f-4eb5-a314-8b51a7754c39".uppercased())
	
	static let APPLICATION_REQUEST_CMD = "2400ffffffffffff00001123b100000100001123b10000010100000054c8141a11060000".uppercased()
	static let GET_FIRMWARE_INFO       = "2400ffffffffffff00001123b100000100001123b10000010100000054c8141a07070000".uppercased()
	static let REBOOT_CMD              = "2400ffffffffffff00001123b100000100001123b10000010100000024c8141a0c010000".uppercased()
    
    static let GANDALF_DESC = CBUUID(string: "00002902-0000-1000-8000-00805f9b34fb")
}

