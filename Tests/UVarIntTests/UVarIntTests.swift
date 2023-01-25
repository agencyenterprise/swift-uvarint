@testable import UVarInt
import XCTest

final class UVarIntTests: XCTestCase {

    func testEncoding() throws {
        var subject: UVarInt = 1
        XCTAssertEqual(subject.encoded, [0b0000_0001])
        
        subject = 127
        XCTAssertEqual(subject.encoded, [0b0111_1111])
        
        subject = 128
        XCTAssertEqual(subject.encoded, [0b1000_0000, 0b0000_0001])
        
        subject = 255
        XCTAssertEqual(subject.encoded, [0b1111_1111, 0b0000_0001])
        
        subject = 300
        XCTAssertEqual(subject.encoded, [0b1010_1100, 0b0000_0010])
        
        subject = 16384
        XCTAssertEqual(subject.encoded, [0b1000_0000, 0b1000_0000, 0b0000_0001])
    }
    
    func testDecoding() throws {
        XCTAssertEqual(try UVarInt([0b0000_0001]).decode().0, 1)
        XCTAssertEqual(try UVarInt([0b0111_1111]).decode().0, 127)
        XCTAssertEqual(try UVarInt([0b1000_0000, 0b0000_0001]).decode().0, 128)
        XCTAssertEqual(try UVarInt([0b1111_1111, 0b0000_0001]).decode().0, 255)
        XCTAssertEqual(try UVarInt([0b1010_1100, 0b0000_0010]).decode().0, 300)
        XCTAssertEqual(try UVarInt([0b1000_0000, 0b1000_0000, 0b0000_0001]).decode().0, 16384)
    }
}
