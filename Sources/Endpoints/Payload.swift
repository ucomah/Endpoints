// TODO: Add support for `Codable`
public protocol HTTPPayload: CustomStringConvertible {
    init()
}

extension HTTPPayload {
    
    static var reference: Self {
        let reference = Self()
        return reference
    }
    
    public var description: String {
        // FIXME: Complete this
        ""
    }
}
