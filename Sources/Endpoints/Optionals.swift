enum InputValue<T> {
    case initialized(T)
    case uninitialized
}

extension InputValue {
    
    func get(errorMessage: String?) -> T {
        switch self {
        case let .initialized(self):
            return self
        case .uninitialized where isOptionalType(T.self):
            // swiftlint:disable:next force_cast
            return Optional<Any>.none as! T
        default:
            fatalError(errorMessage ?? "")
        }
    }
    
    mutating func set(_ newValue: T) {
        self = .initialized(newValue)
    }
    
    public var isInitialized: Bool {
        switch self {
        case .initialized: return true
        case .uninitialized: return false
        }
    }
}

protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { Wrapped.self }
}

func isOptionalType(_ type: Any.Type) -> Bool {
    type is OptionalProtocol.Type
}

