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
        
        var anyValue: Any {
            encode(obj: wrappedValue) ?? wrappedValue
        }
        
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
        
        func encode(obj: Any) -> Any? {
            guard let obj = obj as? AnyRawRepresentable else {
                return nil
            }
            switch obj {
            case _ where obj.floatRawValue != nil:
                return obj.floatRawValue
            case _ where obj.stringRawValue != nil:
                return obj.stringRawValue
            case _ where obj.intRawValue != nil:
                return obj.intRawValue
            case _ where obj.boolRawValue != nil:
                return obj.boolRawValue
            default:
                return nil
            }
        }
    }
}

// MARK: -

internal protocol AnyParameterValue {
    var name: String { get }
    var help: String? { get }
    var isInitialized: Bool { get }
    var anyValue: Any { get }
}
