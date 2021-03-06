//
//  IBeaconViewController.swift
//  SwiftCase
//
//  Created by wtf on 2017/5/3.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit
import CoreBluetooth

class IBeaconViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    /**
     中心者模式
        1、建立中心设备
        2、扫描外部设备
        3、连接外部设备
        4、扫描外部设备中的服务和特征
        5、利用相关的特征与外部设备收发数据。
        一个中心设备可以连接多个外部设备
        一个外部设备包含一个或多个服务
        一个服务包含一个或多个特征
     外设模式
        
     */
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var segment: UISegmentedControl!
    var centralMgr: CBCentralManager!
    var peripherals = [CBPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSourceCodeItem("ibeacon")
        
        centralMgr = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
    }
    
    @IBAction func scan(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // CBUUID(cfuuid: "需要连接的外部设备的服务的UUID")
            // 扫描所有外设，options让中心设备不断监听外部设备消息
            centralMgr.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        } else {
            centralMgr.stopScan()
        }
    }
    
    // MARK: - CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            textview.text = textview.text.appending("State:ON \n")
        default:
            textview.text = textview.text.appending("Bluetooth is not on \n")
        }
    }
    // 开始扫描后发现外设
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripherals.append(peripheral)
        let name = peripheral.name ?? ""
        textview.text = textview.text.appending("\(name) \(peripheral.state.rawValue) \n")
        // 连接设备
        if name.hasPrefix("MI Band 2") {
            central.connect(peripheral, options: nil)
            central.stopScan()
            segment.selectedSegmentIndex = 1;
        }
    }
    // 连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        textview.text = textview.text.appending("\(peripheral.name!) connected. \n")
        // 开始扫描外设服务
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    // 连接失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        textview.text = textview.text.appending("Not connected, \(error.debugDescription) \n")
    }
    // 从设备中发现的所有服务
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    // 从服务中获得的特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                // 读取特征数据
                peripheral.readValue(for: characteristic)
            }
        }
    }
    // 读写数据后进入这里
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        textview.text = textview.text.appending("  \(characteristic) \n")
        // 写入数据 withResponse
        // peripheral.writeValue(Data(), for: characteristic, type: .withResponse)
    }
    // .withResponse 写入数据回调 是否成功
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            print("Write Characteristic Failed:\(error.debugDescription)")
        }
    }
    
}
