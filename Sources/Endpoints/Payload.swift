public protocol HTTPPayload: CustomStringConvertible, Encodable {
    var contentType: HTTP.ContentType { get }
}

extension HTTPPayload {
    
    public var contentType: HTTP.ContentType { .json }
    
    public var description: String {
        switch contentType {
        case .plainText:
            return String(describing: self)
        default:
            return Mirror(reflecting: self).children.compactMap {
                "\(unwrap($0.label)) = \(unwrap($0.value))"
            }.joined(separator: "\n")
        }
    }
}
