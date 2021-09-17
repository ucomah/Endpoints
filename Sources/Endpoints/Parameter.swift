extension HTTP {
    
    /// HTTP Patameter that represents optional/required value
    /// - parameter name: Name of the HTTP parameter that will be used during URL buling
    /// - parameter help: Help notes explaining this variable's purpose
    @propertyWrapper
    public struct Parameter<T>: AnyParameterValue {
        
        public let name: String
        
        public let help: String?
        
        private var _value: InputValue<T>
        
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
        
        public init(name: String, help: String? = nil) {
            self.name = name
            self.help = help
            self._value = .uninitialized
        }
        
        public init(value: T, name: String = "", help: String? = nil) {
            self.name = name
            self.help = help
            self._value = .initialized(value)
        }
    }
}

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

extension HTTP.Parameter: ExpressibleByIntegerLiteral where T: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: T.IntegerLiteralType) {
        self.init(value: T(integerLiteral: value))
    }
}

extension HTTP.Parameter: ExpressibleByFloatLiteral where T: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: T.FloatLiteralType) {
        self.init(value: T(floatLiteral: value))
    }
}

extension HTTP.Parameter: ExpressibleByBooleanLiteral where T: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: T.BooleanLiteralType) {
        self.init(value: T(booleanLiteral: value))
    }
}

extension HTTP.Parameter: ExpressibleByNilLiteral where T: ExpressibleByNilLiteral {
    
    public init(nilLiteral: ()) {
        self.init(value: T(nilLiteral: nilLiteral))
    }
}

extension HTTP.Parameter: ExpressibleByArrayLiteral where T: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = T.ArrayLiteralElement
    
    public init(arrayLiteral elements: T.ArrayLiteralElement...) {
        self.init(value: elements as! T) // swiftlint:disable:this force_cast
    }
}

extension HTTP.Parameter: ExpressibleByDictionaryLiteral where T: ExpressibleByDictionaryLiteral {
    
    public typealias Key = T.Key
    public typealias Value = T.Value
    
    public init(dictionaryLiteral elements: (T.Key, T.Value)...) {
        self.init(value: elements as! T) // swiftlint:disable:this force_cast
    }
}


internal protocol AnyParameterValue {
    var name: String { get }
    var help: String? { get }
    var isInitialized: Bool { get }
    var anyValue: Any { get  }
}
