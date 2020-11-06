//
//  APIManager.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    class func login(email: String, passowrd: String, completion: @escaping (_ error: Error?, _ loginResponse: LoginResponse?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
        let params: [String: Any] = [ParameterKeys.email: email,
                                     ParameterKeys.password: passowrd]
        
        AF.request(URLs.login, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let loginData = try decoder.decode(LoginResponse.self, from: data)
                completion(nil, loginData)
            } catch let error {
                if let stringRes = String(data: data, encoding: .utf8) {
                    print("json: \(stringRes)")
                    //completion(stringRes, nil)
                } else {
                    print(error)
                }
            }
        }
    }
    
    class func Register(email: String, passowrd: String,name: String, age: Int, completion: @escaping (_ error: Error?, _ loginResponse: LoginResponse?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
        let params: [String: Any] = [ParameterKeys.email: email,
                                     ParameterKeys.password: passowrd,
                                     ParameterKeys.name: name,
                                     ParameterKeys.age: age ]
        
        AF.request(URLs.Register, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let RegisterData = try decoder.decode(LoginResponse.self, from: data)
                completion(nil, RegisterData)
            } catch let error {
                if let stringRes = String(data: data, encoding: .utf8) {
                    print("json: \(stringRes)")
                    //completion(stringRes, nil)
                } else {
                    print(error)
                }
            }
        }
    }
    
    class func getAllTodos(completion: @escaping (_ error: Error?, _ todosArr: [TodoData]?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.contentType:"application/json",
             HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]
        
        AF.request(URLs.todos, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let todosArr = try decoder.decode(TodosResponse.self, from: data).data
                completion(nil, todosArr)
            } catch let error {
                print(error)
            }
        }
    }
    
    class func getUserDetails(completion: @escaping (_ error: Error?, _ userData: UserData?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]
        
        AF.request(URLs.userDetails, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(UserData.self, from: data)
                completion(nil, userData)
            } catch let error {
                print(error)
            }
        }
    }
    
    class func logOut(completion: @escaping (_ error: Error?, _ userData: LogoutResponse?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]
        
        AF.request(URLs.logout, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let logoutdata = try decoder.decode(LogoutResponse.self, from: data)
                completion(nil, logoutdata)
            } catch let error {
                print(error)
            }
        }
    }
    
    class func deletTask(completion: @escaping (_ error: Error?, _ deletData: DeletTaskResponse? ) -> Void) {

        let headers: HTTPHeaders = [HeaderKeys.contentType:"application/json",
                                    HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]

        AF.request(URLs.delet + "\(UserDefaultsManager.shared().id)", method: HTTPMethod.delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }

            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }

            do {
                let decoder = JSONDecoder()
                let deletData = try decoder.decode(DeletTaskResponse.self, from: data)
                completion(nil, deletData)
            } catch let error {
                print(error)
            }
        }
    }
}
