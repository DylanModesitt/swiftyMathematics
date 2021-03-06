//
//  Created by Dylan Modesitt
/*  Copyright (c) 2015 Dylan Modesitt.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE. */

import UIKit

func evaluateGraph(atX: Double) -> Double? {
    return sin(atX)
}

func evaluateDerivitive(atPoint:Double) -> Double? {
    
    let h = 0.000001
    return (evaluateGraph(atPoint + h)! - evaluateGraph(atPoint)! ) / h
}
func evaluateIntegral(atA: Double, atB:Double) -> Double? {
    let totalInterval = atB - atA
    var answer = 0.0
    var changInX = 1.0 / 100.0
    
    var howMany = totalInterval * 100
    var currentPoint = atA
    
    var index: Double
    
    for index = 0.0; index < howMany; ++index {
        print("index is \(index)")
        
        answer = answer + evaluateGraph(currentPoint)! + evaluateGraph(currentPoint + changInX)!
        currentPoint = currentPoint + changInX
        
    }
    println(answer)
    return answer * changInX / 2
    
}

evaluateDerivitive(0.0)


evaluateIntegral(0.0, M_PI)



// higher percision -> better accuracy, start...end: Interval, f: function
// higher percision -> better accuracy, start...end: Interval, f: function
func getZero(#precision: Int, var #start: Double, var #end: Double, f: Double -> Double) -> Double? {
    
    let isStartNegative = f(start).isSignMinus
    if isStartNegative == f(end).isSignMinus { return nil }
    
    let doublePrecision = pow(10, -Double(precision))
    
    while end - start > doublePrecision {
        let mid = (start + end) / 2
        if f(mid) > 0 {
            if isStartNegative {
                end = mid
            } else {
                start = mid
            }
        } else {
            if isStartNegative {
                start = mid
            } else {
                end = mid
            }
        }
    }
    
    return (start + end) / 2
}

// same as above but it returns an array of points
func getZerosInRange(#precision: Int, #start: Double, #end: Double, f: Double -> Double) -> [Double] {
    
    let doublePrecision = pow(10, -Double(precision))
    
    /// accuracy/step count between interval; "antiproportional" performance!!!!
    let stepCount = 100.0
    let by = (end - start) / stepCount
    var zeros = [Double]()
    
    for x in stride(from: start, to: end, by: by) {
        if let xZero = getZero(precision: precision, start: x, end: x + by, f) {
            zeros.append(xZero)
        }
    }
    return zeros
}

// using currying; all return values should be elements of the interval start...end
func inverse(#precision: Int, #start: Double, #end: Double, f: Double -> Double)(_ x: Double) -> [Double] {
    return getZerosInRange(precision: precision, start: start, end: end) { f($0) - x }
}

let f = { (x: Double) in (x * x) - 1 }

// you would pass the min and max Y values of the GraphView
// type: Double -> [Double]
let inverseF = inverse(precision: 10, start: -10, end: 10, f)

inverseF(0.0) // outputs [-1.999999999953436, 2.000000000046564]
getZero(precision: 10, start: 0, end: 100, f)
getZerosInRange(precision: 10, start: -10.0, end: 10.0, f)
abs(-10)
