//
//  ControlView.swift
//  iSight
//
//  Created by Raul Martinez-Luna on 5/31/22.
//

import SwiftUI

struct ControlView: View {
  @Binding var prescription:Float
  var body: some View {
    VStack {
      Spacer()
      SliderView(prescriptionSliderValue: $prescription)
    }
  }
}

struct ControlView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.black
        .edgesIgnoringSafeArea(.all)

      ControlView(
        prescription: .constant(0)
      )
    }
  }
}
