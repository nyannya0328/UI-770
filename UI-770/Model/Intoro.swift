//
//  Intoro.swift
//  UI-770
//
//  Created by nyannyan0328 on 2022/10/17.
//

import SwiftUI

struct Intro: Identifiable {
   var id = UUID().uuidString
    var imageName : String
    var title : String
}

var intros: [Intro] = [
    .init(imageName: "Image 1", title: "Relax"),
    .init(imageName: "Image 2", title: "Care"),
    .init(imageName: "Image 3", title: "Mood Dairy"),
]

let sansBold = "WorkSans-Bold"
let sansSemiBold = "WorkSans-SemiBold"
let sansRegular = "WorkSans-Regular"

let dummyText = "SAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLE"




