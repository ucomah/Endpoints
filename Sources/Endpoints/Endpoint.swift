/// General purpose protocol to define endpoints for HTTP APIs.
public protocol Endpoint: AnyHTTPEndpoint {
    
    typealias HTTPParameter = HTTP.Parameter
    
    associatedtype Body: HTTPPayload
    
    var body: Body? { get }
}

// MARK: - Default values

public extension Endpoint {
    
    var body: Body? { nil }
}

public extension AnyHTTPEndpoint {

    var parameters: [String: Any]? {
        let mirror = Mirror(reflecting: self).children
        let titles = mirror.map {
            $0.label ?? ""
        }.map {
            $0.trimmingCharacters(in: .init(charactersIn: "_"))
        }
        let values = mirror.map { $0.value as? AnyParameterValue }
        let buf = zip(titles, values).map { (param) -> (String, Any?) in
            let title: String
            if let name = param.1?.name, !name.isEmpty {
                title = name
            } else {
                title = param.0
            }
            let value = param.1?.anyValue
            return (title, value)
        }
        return Dictionary(uniqueKeysWithValues: buf).compactMapValues { $0 }
    }
}

// MARK: - LosslessStringConvertible

extension Endpoint {

    public var description: String {
        switch method {
        case .get:
            return basicDescription
        default:
            return "\(basicDescription)\nParameters: \(unwrap(parameters))\nBody: \(unwrap(body))"
        }
    }
}

// MARK: - Body variations

public struct EmptyBody: HTTPPayload {
    public var kind: HTTP.ContentType { .plainText }
}

extension String: HTTPPayload {
    public var kind: HTTP.ContentType { .plainText }
}

// MARK: - AnyEndpoint

/// Type-erased Endpoint.
public protocol AnyEndpoint: Endpoint { }

extension AnyEndpoint {
    public var body: EmptyBody? { nil }
}
