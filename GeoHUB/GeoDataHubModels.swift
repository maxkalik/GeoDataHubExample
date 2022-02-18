//
//  GeoDataHubModels.swift
//  GeoHUB
//
//  Created by Maksim Kalik on 18/02/2022.
//

import Foundation

struct GeoDataHubModel: Codable {
    var type: String
    var name: String
    var features = [GeoDataHubFeatureModel]()
}

struct GeoDataHubFeatureModel: Codable {
    var type: String
    var properties: GeoDataHubFeaturePropertiesModel
}

struct GeoDataHubFeaturePropertiesModel: Codable {
    var country: String
    var level0: String?
    var level1: String?
    var level2: String?
    var level3: String?
    var level4: String?
    var level5: String?
    var level6: String?
    var level7: String?
    var fullAddress: String
    var apartment: String?
    var postalCode: String?
}
