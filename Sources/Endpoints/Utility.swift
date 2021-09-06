#if canImport(Foundation)
import Foundation
#endif

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {

    func encodedFor(method: HTTP.Method) -> String? {
        guard method == .get else { return nil }
        var addons = [String]()
        for (key, value) in self {
            if let arr = value as? [String] {
                addons.append(contentsOf: arr.map { "\(key)=\($0)" })
            } else {
                addons.append("\(key)=\(String(describing: value))")
            }
        }
        guard !addons.isEmpty else { return nil }
        let tmp = "?" + addons.joined(separator: "&")
        if let result = tmp.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            return result
        }
        return nil
    }
}

func unwrap<T>(_ any: T) -> Any {
    let mirror = Mirror(reflecting: any)
    guard mirror.displayStyle == .optional, let first = mirror.children.first else {
        return any
    }
    return unwrap(first.value)
}

