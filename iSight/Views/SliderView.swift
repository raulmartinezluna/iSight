//
//  SliderView.swift
//  iSight
//
//  Created by Raul Martinez-Luna on 5/31/22.
//

import SwiftUI

struct SliderView: View {
    @Binding var prescriptionSliderValue:Float
    @State private var isEditing = false
    
    var label: String = "Prescription"
    var minVal: Float = -10
    var maxVal: Float = 5
    var increments: Float = 0.25
    
    var body: some View {
        Text("\(label)"+": "+"\(prescriptionSliderValue)")
            .foregroundColor(isEditing ? .red : .blue)
        Slider(
            value: $prescriptionSliderValue,
            in: minVal...maxVal,
            step: increments
        ) {
            Text(label)
        } minimumValueLabel: {
            Image(systemName: "minus")
        } maximumValueLabel: {
            Image(systemName: "plus")
        } onEditingChanged: { editing in
            isEditing = editing
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
      SliderView(prescriptionSliderValue: .constant(0))
    }
}
