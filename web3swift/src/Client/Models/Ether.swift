//
//  Ether.swift
//  web3swift
//
//  Created by Matt Marshall on 06/03/2018.
//  Copyright © 2018 Argent Labs Limited. All rights reserved.
//

import Foundation
import BigInt

public struct Ether {
    public static let kweiMultiplier: BigInt = 1_000
    public static let mweiMultiplier: BigInt = 1_000_000
    public static let gweiMultiplier: BigInt = 1_000_000_000
    public static let szaboMultiplier: BigInt = 1_000_000_000_000
    public static let finneyMultiplier: BigInt = 1_000_000_000_000_000
    public static let etherMultiplier: BigInt = 1_000_000_000_000_000_000
    
    public let wei: BigInt
    
    public init(wei: BigInt) {
        self.wei = wei
    }
    
    public init(kwei: BigInt) {
        self.wei = kwei * Ether.kweiMultiplier
    }
    
    public init(mwei: BigInt) {
        self.wei = mwei * Ether.mweiMultiplier
    }
    
    public init(gwei: BigInt) {
        self.wei = gwei * Ether.gweiMultiplier
    }
    
    public init(szabo: BigInt) {
        self.wei = szabo * Ether.szaboMultiplier
    }
    
    public init(finney: BigInt) {
        self.wei = finney * Ether.finneyMultiplier
    }
    
    public init(ether: BigInt) {
        self.wei = ether * Ether.etherMultiplier
    }
}

extension Ether: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hexValue = try container.decode(String.self)
        if let intValue = BigInt(hex: hexValue) {
            self.init(wei: intValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot convert string(hex) to BigInt")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let hexValue = String(hexFromBytes: self.wei.bytes)
        try container.encode(hexValue)
    }
}
