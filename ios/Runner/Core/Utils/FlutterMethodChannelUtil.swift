//
//  FlutterMethodChannelUtil.swift
//  Runner
//
//  Created by Doodii Macbook Pro on 3/5/2565 BE.
//

import Foundation
import Flutter

class FlutterMethodChannelUtil {
    static func handlerMethodChannel(controller : FlutterViewController) {
        
        
        let flutterChannel = FlutterMethodChannel(
            name: "native",
            binaryMessenger: controller.binaryMessenger
        )
        
        flutterChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            result(FlavorUtil().getFlavorName())
        
        })
    }
}
