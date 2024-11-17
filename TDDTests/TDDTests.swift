//
//  TDDTests.swift
//  TDDTests
//
//  Created by Jorge Miguel Lucena Pino on 17/11/24.
//

import Testing
@testable import TDD

struct M3U8Parser {
    enum Error: Swift.Error {
        case invalidData
    }
    
    func parse(_ data: Data) throws {
        throw Error.invalidData
    }
}

struct TDDTests {

    @Test func givenInvalidData_whenParse_ThenThrowError() async throws {
        let sut = M3U8Parser()
        let invalidData: Data = "invalidData".data(using: .utf8)!
        
        #expect(throws: M3U8Parser.Error.invalidData) {
            try sut.parse(invalidData)
        }
    }
}
