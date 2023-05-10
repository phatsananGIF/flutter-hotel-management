//
//  FlavorUtil.swift
//  Runner
//
//  Created by Doodii Macbook Pro on 3/5/2565 BE.
//

import Foundation

class FlavorUtil {
    func getFlavorName() -> String {
        print(Bundle.main.infoDictionary ?? "")
        let flavor = Bundle.main.infoDictionary?["Flavor Name"]
        
        return flavor as! String;
    }
}
