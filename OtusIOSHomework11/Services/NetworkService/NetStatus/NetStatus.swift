//
//  NetStatus.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 12.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation
import Network

//NetStatus.shared.startMonitoring()
//NetStatus.shared.netStatusChangeHandler = {
//    DispatchQueue.main.async { [unowned self] in
//        print("Change Net")
//    }
//}

@available(iOS 12.0, *)
public class NetStatus {
    
    public static let shared = NetStatus()
    
    public var monitor: NWPathMonitor?
    
    public var isMonitoring = false
    
    public var didStartMonitoringHandler: (() -> Void)?
    
    public var didStopMonitoringHandler: (() -> Void)?
    
    public var netStatusChangeHandler: (() -> Void)?
    
    
    public var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    
    public var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
        
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type
    }
    
    
    public var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    
    public var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
    
    
    // MARK: - Init & Deinit
    
    private init() {
        
    }
    
    
    deinit {
        stopMonitoring()
    }
    
    
    // MARK: - Method Implementation
    
    public func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
        
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
    }
    
    
    public func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
    
}
