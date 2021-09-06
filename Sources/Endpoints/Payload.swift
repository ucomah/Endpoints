public protocol HTTPPayload: CustomStringConvertible {
    init()
}

extension HTTPPayload {
    
    static var reference: Self {
        let reference = Self()
        return reference
    }
    
    public var description: String {
        Mirror(reflecting: self).children.compactMap {
            "\(unwrap($0.label)) = \(unwrap($0.value))"
        }.joined(separator: "\n")
    }
}
