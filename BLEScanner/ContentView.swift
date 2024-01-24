//
//  ContentView.swift
//  BLEScanner
//
//  Created by Christian Möller on 02.01.23.
//

import SwiftUI
import CoreBluetooth

enum ScanResultState {
    case Scanning, Connected, CommandSent, ResponseReceived(value: String)
}

struct ContentView: View {
    @ObservedObject private var bpzCentralManager = BeepizCentralManager()
    @State private var searchText = ""
    @State var scanResultState = ScanResultState.Scanning

    var body: some View {
        VStack {
            HStack {
                // Text field for entering search text
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                // Button for clearing search text
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
                .opacity(searchText == "" ? 0 : 1)
            }
            .padding()
        

            // List of discovered peripherals filtered by search text
            List(bpzCentralManager.discoveredPeripherals.filter {
                self.searchText.isEmpty ? true : $0.peripheral.name?.lowercased().contains(self.searchText.lowercased()) == true
            }, id: \.peripheral.identifier) { discoveredPeripheral in
                VStack(alignment: .leading) {
                    Text(discoveredPeripheral.peripheral.name ?? "Unknown Device")
                    Text(discoveredPeripheral.advertisedData)
                        .font(.caption)
                        .foregroundColor(.gray)
                }.onTapGesture {
                    print("tapped cell : \(discoveredPeripheral.peripheral.name)")
                    bpzCentralManager.discoveredPeripheral = discoveredPeripheral.peripheral
                    bpzCentralManager.centralManager.connect(discoveredPeripheral.peripheral)
                }
            }

            // Button for starting or stopping scanning
            Button(action: {
                if self.bpzCentralManager.isScanning {
                    self.bpzCentralManager.stopScan()
                } else {
                    self.bpzCentralManager.startScan()
                }
            }) {
                if bpzCentralManager.isScanning {
                    Text("Stop Scanning")
                } else {
                    Text("Scan for Devices")
                }
            }
            // Button looks cooler this way on iOS
            .padding()
            .background(bpzCentralManager.isScanning ? Color.red : Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
        }
        
        .alert(isPresented: $bpzCentralManager.didReceiveData) {
            Alert(title: Text("Data Received"), message: Text("Data : \(bpzCentralManager.retrievedData)"), dismissButton: .default(Text("OK")))
        }
        
        .onAppear(perform: {
            
        })
    }
}
