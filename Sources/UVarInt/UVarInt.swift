import Algorithms

// MARK: - UVarInt

public struct UVarInt {
    var encoded: [UInt8]

    public init(_ encoded: [UInt8]) { self.encoded = encoded }
}

public extension UVarInt {
    init(_ value: some FixedWidthInteger) {
        var buffer: [UInt8] = withUnsafeBytes(of: value, Array.init)
        var value = value
        var endIndex = 0
        let indices = buffer.indices
        for index in indices {
            buffer[index] = .init(truncatingIfNeeded: value) | 0x80
            value >>= 7
            if value == 0 {
                buffer[index] &= 0x7F
                break
            }
            endIndex += 1
        }
        self.init(Array(buffer[0 ... endIndex]))
    }

    func decode<Decoded: FixedWidthInteger>(as type: Decoded.Type) throws -> (value: Decoded, remainder: [UInt8]) {
        var decoded: Decoded = 0
        for (offset, byte) in encoded.enumerated() {
            let maskedByte = Decoded(byte & 0x7F)
            decoded |= maskedByte << (offset * 7)
            
            let isLastByte = byte & 0x80 == 0
            switch isLastByte {
            case true where byte == 0 && offset > 0: throw UVarIntError.encodingNotMinimal
            case true: return (decoded, Array(encoded.suffix(from: offset + 1)))
            case false: continue
            }
        }

        throw UVarIntError.insufficient
    }

    func decode<Decoded: FixedWidthInteger>() throws -> (Decoded, [UInt8]) { try decode(as: Decoded.self) }
}

// MARK: - UVarInt + ExpressibleByIntegerLiteral

extension UVarInt: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

