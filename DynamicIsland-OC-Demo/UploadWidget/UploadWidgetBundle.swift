//
//  UploadWidgetBundle.swift
//  UploadWidget
//
//  Created by Gavin Xiang on 2023/11/22.
//

import WidgetKit
import SwiftUI

@main
struct UploadWidgetBundle: WidgetBundle {
    var body: some Widget {
        UploadWidget()
        UploadWidgetLiveActivity()
    }
}
