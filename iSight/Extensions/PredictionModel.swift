//
//  PredictionModel.swift
//  iSight
//
//  Created by Raul Martinez-Luna on 5/31/22.
//

import Foundation


class PredictionModel {
  
  var prescription:[Float]! = nil
  var focus:[Float]! = nil
  
  //Model variables
  var lineOfBestFit:(Float)! = nil
  var slope:Float! = nil
  var intercept: Float! = nil
  
  init(prescriptionArray:[Float], focusArray:[Float]) {
    self.prescription = prescriptionArray
    self.focus = focusArray
    
    linearRegression(self.prescription, self.focus)
  }
  
  func average(_ input: [Float]) -> Float {
    return input.reduce(0, +) / Float(input.count)
  }
  func multiply(_ a: [Float], _ b: [Float]) -> [Float] {
    return zip(a,b).map(*)
  }
  func linearRegression(_ xs: [Float], _ ys: [Float]) {
    let sum1 = average(multiply(ys, xs)) - average(xs) * average(ys)
    let sum2 = average(multiply(xs, xs)) - pow(average(xs), 2)
    self.slope = sum1 / sum2
    self.intercept = average(ys) - slope * average(xs)
    //return { x in self.intercept + self.slope * x }
  }
  
  func getPrediction(prescription: Float) -> Float {
    let predictedFocus:Float = prescription*self.slope + self.intercept
    
    return predictedFocus
  }
  
}
