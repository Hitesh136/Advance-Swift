//
//  MyResult.swift
//  Advanced Swift
//
//  Created by Hitesh  Agarwal on 21/09/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation


enum MyResult<Success, Failure: Error> {
	case success(Success)
	case failure(Failure)
	
	func map<NewSuccess>(
		_ transform: (Success) -> (NewSuccess)
	) -> MyResult<NewSuccess, Failure> {
		
		switch self {
		case let .success(success):
			return .success(transform(success))
		case let .failure(failure):
			return .failure(failure)
		}
	}
	
	func mapError<NewFailure>(
		_ tranform: (Failure) -> (NewFailure)
	) -> Result<Success, NewFailure> {
		
		switch self {
			case let .success(success):
				return .success(success)
			case let .failure(failure):
				return .failure(tranform(failure))
		}
	}
	
	func flatMap<NewSuccess>(
		_ transform: (Success) -> (Result<NewSuccess, Failure>)
	) -> Result<NewSuccess, Failure> {
		
		switch self {
			case let .success(success):
				return transform(success)
			case let .failure(failure):
				return .failure(failure)
		}
	}
	
	func flatError<NewFailure>(
		_ tranform: (Failure) -> (Result<Success, NewFailure>)
	) -> Result<Success, NewFailure> {
		
		switch self {
			case let .success(success):
				return .success(success)
			case let .failure(failure):
				return tranform(failure)
		}
	}
	
	func get() throws -> Success {
		switch self {
			case let .success(success):
				return success
			case let .failure(failure):
				throw failure
		}
	}
}

extension MyResult: Equatable where Success: Equatable, Failure: Equatable {}
extension MyResult: Hashable where Success: Hashable, Failure: Hashable {}
