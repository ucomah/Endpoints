public protocol HTTPPayload: CustomStringConvertible, Encodable {
    var kind: HTTP.ContentType { get }
}

extension HTTPPayload {
    
    var kind: HTTP.ContentType { .json }
    
    public var description: String {
        switch kind {
        case .plainText:
            return String(describing: self)
        default:
            return Mirror(reflecting: self).children.compactMap {
                "\(unwrap($0.label)) = \(unwrap($0.value))"
            }.joined(separator: "\n")
        }
    }
}
