//
//  Double+Extensions.swift
//  buttoncraft
//
//  Created by An Trinh on 23/9/20.
//

import UIKit

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
