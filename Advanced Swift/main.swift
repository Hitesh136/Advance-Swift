//
//  main.swift
//  Advanced Swift
//
//  Created by Hitesh  Agarwal on 21/09/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

enum FactorError: Error {
	case divideByZero
	case belowMinimum
	case isPrime
}

func generateRandomNmuber(maximum: Int) -> MyResult<Int, FactorError> {
	
	guard maximum > 0 else {
		return .failure(.belowMinimum)
	}
	
	return .success(Int.random(in: 0...maximum))
}

func calculateFactors(number: Int) -> Result<Int, FactorError> {
	guard number != 0 else {
		return .failure(.divideByZero)
	}
	let factorsCount = (1...number).filter{ number % $0 == 0 }.count
	
	if factorsCount == 2 {
		return .failure(.isPrime)
	} else {
		return .success(factorsCount)
	}
}

let result1 = generateRandomNmuber(maximum: 10)
let result2 = generateRandomNmuber(maximum: 10)
let finalResult = result1.flatMap{ calculateFactors(number: $0) }

do {
	try print(finalResult.get())
} catch let error {
	print("Error: \(error)")
}

//if result1 == result1 {
//	print("Both results are same")
//} else {
//	print("Both are not same")
//}
//print(result1.map{ "Factors count of \($0) is \(calculateFactors(number: $0))"})
//print(result1.map{ calculateFactors(number: $0) })
//print(result1.flatMap{ calculateFactors(number: $0) })






