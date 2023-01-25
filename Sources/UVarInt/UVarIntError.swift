// MARK: - UVarIntError

enum UVarIntError {
    case insufficient
    case overflow
    case encodingNotMinimal
}

// MARK: - UVarIntError + CustomStringConvertible

extension UVarIntError: CustomStringConvertible {
    var description: String {
        switch self {
        case .insufficient: return "Not enough input bytes."
        case .overflow: return "Input bytes exceed maximum."
        case .encodingNotMinimal: return "Encoding is not minimal (has trailing zero bytes)."
        }
    }
}

// MARK: - UVarIntError + Error

extension UVarIntError: Error {
    var localizedDescription: String { description }
}

#if canImport(Foundation)
    import Foundation

    extension UVarIntError: LocalizedError {
        var errorDescription: String? { description }
    }
#endif
