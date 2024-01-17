//
//  Beer.swift
//  dz16
//
//  Created by Павел Платов on 14.01.2024.
//

import Foundation

class Beer: Codable {
    var name: String
    var price: Int
    var quantity = 100
    var selected = 0
    var isLiked: Bool?
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
    enum CodingKeys: String, CodingKey {
        case name, price, quantity, selected, isLiked
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name
        = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Int.self, forKey: .price)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.selected = try container.decode(Int.self, forKey: .selected)
        self.isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.quantity, forKey: .quantity)
        try container.encode(self.selected, forKey: .selected)
        try container.encode(self.isLiked, forKey: .isLiked)
        
    }
}

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
