public protocol AnyRawRepresentable {
    var stringRawValue: String? { get }
    var intRawValue: Int? { get }
    var floatRawValue: Float? { get }
    var boolRawValue: Bool? { get }
}

extension AnyRawRepresentable {
    var stringRawValue: String? { nil }
    var intRawValue: Int? { nil }
    var floatRawValue: Float? { nil }
    var boolRawValue: Bool? { nil }
}

extension AnyRawRepresentable
where Self: RawRepresentable, Self.RawValue == String {
    var stringRawValue: String? { rawValue }
}

extension AnyRawRepresentable
where Self: RawRepresentable, Self.RawValue == Int {
    var intRawValue: Int? { rawValue }
}

extension AnyRawRepresentable
where Self: RawRepresentable, Self.RawValue == Float {
    var floatRawValue: Float? { rawValue }
}

extension AnyRawRepresentable
where Self: RawRepresentable, Self.RawValue == Bool {
    var boolRawValue: Bool? { rawValue }
}

// MARK: -

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
