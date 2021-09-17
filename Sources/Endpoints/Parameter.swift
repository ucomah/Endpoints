extension HTTP {
    
    /// HTTP Patameter that represents optional/required value
    /// - parameter name: Name of the HTTP parameter that will be used during URL buling
    /// - parameter help: Help notes explaining this variable's purpose
    @propertyWrapper
    public struct Parameter<T>: AnyParameterValue {
        
        public let name: String
        
        public let help: String?
        
        private var _value: InputValue<T>
        
        public let kind: ParameterKind
        
        public var wrappedValue: T {
            get {
                _value.get(errorMessage: "Parameter {\(self.name)} was not initialized")
            }
            set {
                _value.set(newValue)
            }
        }
        
        public var isInitialized: Bool { _value.isInitialized }
        
        var anyValue: Any { wrappedValue }
        
        public init(name: String, kind: ParameterKind = .query, help: String? = nil) {
            self.name = name
            self.help = help
            self.kind = kind
            self._value = .uninitialized
        }
        
        public init(value: T, name: String = "", help: String? = nil) {
            self.name = name
            self.help = help
            self._value = .initialized(value)
        }
    }
}

extension HTTP {
    public enum ParameterKind: Int {
        /// Represents a part of URL path
        case path
        /// URL query parameter
        case query
extension HTTP.Parameter: ExpressibleByStringLiteral, ExpressibleByUnicodeScalarLiteral, ExpressibleByExtendedGraphemeClusterLiteral
where T: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: T.StringLiteralType) {
        self.init(value: T(stringLiteral: value))
    }

    public init(unicodeScalarLiteral value: T.UnicodeScalarLiteralType) {
        self.init(value: T(unicodeScalarLiteral: value))
    }
    
    public init(extendedGraphemeClusterLiteral value: T.ExtendedGraphemeClusterLiteralType) {
        self.init(value: T(extendedGraphemeClusterLiteral: value))
    }
}


internal protocol AnyParameterValue {
    var name: String { get }
    var help: String? { get }
    var kind: HTTP.ParameterKind { get }
    var isInitialized: Bool { get }
    var anyValue: Any { get  }
}
