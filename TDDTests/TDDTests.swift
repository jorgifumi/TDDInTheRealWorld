//
//  TDDTests.swift
//  TDDTests
//
//  Created by Jorge Miguel Lucena Pino on 17/11/24.
//

import Testing
@testable import TDD

struct Track {
    let path: String
}

struct M3U8Parser {
    enum Error: Swift.Error {
        case invalidData
    }
    
    func parse(_ data: Data) throws -> [Track] {
        guard !data.isEmpty else {
            return []
        }
        
        let lines = String(decoding: data, as: Unicode.UTF8.self).components(separatedBy: .newlines)
        return try lines.map { line in
            if isValidPath(line) {
                Track(path: line)
            } else {
                throw Error.invalidData
            }
        }
    }
    
    private func isValidPath(_ line: String) -> Bool {
        line.hasPrefix("http://") || line.hasPrefix("https://") || line.hasPrefix("/")
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
    
    @Test func givenEmptyData_whenParse_ThenDeliverEmptyPlaylist() async throws {
        let sut = M3U8Parser()
        let emptyData: Data = Data()
        
        let playlist = try sut.parse(emptyData)
        
        #expect(playlist.isEmpty)
    }
    
    @Test func givenDataWithOneTrackWithURLPath_whenParse_ThenDeliverOneTrack() async throws {
        let sut = M3U8Parser()
        let path: String = "http://example.com/track.m4s"
        let data: Data = path.data(using: .utf8)!
        
        let playlist = try sut.parse(data)
        
        #expect(playlist.count == 1)
        #expect(playlist.first!.path == path)
    }
    
    @Test func givenDataWithOneTrackWithRelativePath_whenParse_ThenDeliverOneTrack() async throws {
        let sut = M3U8Parser()
        let path: String = "/example/track.m4s"
        let data: Data = path.data(using: .utf8)!
        
        let playlist = try sut.parse(data)
        
        #expect(playlist.count == 1)
        #expect(playlist.first!.path == path)
    }
    
    @Test func givenDataWithMultipleTracks_whenParse_ThenDeliverMultipleTracks() async throws {
        let sut = M3U8Parser()
        let path1: String = "http://example.com/track1.m4s"
        let path2: String = "http://example.com/track2.m4s"
        let data: Data = "\(path1)\n\(path2)".data(using: .utf8)!
        
        let playlist = try sut.parse(data)
        
        #expect(playlist.count == 2)
        #expect(playlist.first!.path == path1)
        #expect(playlist.last!.path == path2)
    }
}
