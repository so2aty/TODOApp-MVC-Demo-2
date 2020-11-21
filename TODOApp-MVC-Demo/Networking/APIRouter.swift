//
//  APIRouter.swift
//  TODOApp-MVC-Demo
//
//  Created by Ibrahim El-geddawy on 11/7/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case login(_ email: String, _ password: String)
    case getTodos
    case logout
    case signup(_ email: String, _ password: String,_ name: String,_ age: Int)
    case getUserDetails
    case edidProfile (_ age: Int)
    case uploadPhoto (_ image: UIImage)
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .getTodos:
            return .get
        case .edidProfile:
        return .put
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [ParameterKeys.email: email, ParameterKeys.password: password]
        case .signup(let email , let password , let name , let age):
            return [ParameterKeys.email: email, ParameterKeys.password: password, ParameterKeys.name: name, ParameterKeys.age: age]
        case .edidProfile(let age):
        return [ParameterKeys.age: age]
        default:
            return nil
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return URLs.login
        case .getTodos:
            return URLs.todos
        case .logout:
            return URLs.logout
        case .signup:
            return URLs.Register
        case .getUserDetails:
            return URLs.userDetails
        case .edidProfile(_):
            return URLs.EditProfile
        case .uploadPhoto(_):
            return URLs.uploadPhoto
        }
    }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getTodos ,.logout, .getUserDetails :
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
            forHTTPHeaderField: HeaderKeys.authorization)
        default:
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
