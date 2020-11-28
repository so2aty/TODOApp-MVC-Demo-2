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
    //MARK:- Sign In
    class func  login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>)-> ()){
        request(APIRouter.login(email, password)){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Sign Up
    class func  Register(email: String, password: String,name: String, age: Int, completion: @escaping (Result<LoginResponse, Error>)-> ()){
        request(APIRouter.signup(email, password, name, age)){ (response) in
            completion(response)
        }
    }
//    class func Register(email: String, passowrd: String,name: String, age: Int, completion: @escaping (_ error: Error?, _ loginResponse: LoginResponse?) -> Void) {
//
//        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
//        let params: [String: Any] = [ParameterKeys.email: email,
//                                     ParameterKeys.password: passowrd,
//                                     ParameterKeys.name: name,
//                                     ParameterKeys.age: age ]
//
//        AF.request(URLs.Register, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response { response in
//            guard response.error == nil else {
//                print(response.error!)
//                completion(response.error, nil)
//                return
//            }
//
//            guard let data = response.data else {
//                print("didn't get any data from API")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let RegisterData = try decoder.decode(LoginResponse.self, from: data)
//                completion(nil, RegisterData)
//            } catch let error {
//                if let stringRes = String(data: data, encoding: .utf8) {
//                    print("json: \(stringRes)")
//                    //completion(stringRes, nil)
//                } else {
//                    print(error)
//                }
//            }
//        }
//    }
    //MARK:- Get TODOS
    class func  getAllTodos(completion: @escaping (Result<TodosResponse, Error>)-> ()){
        request(APIRouter.getTodos){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Log Out
    class func  logout(completion: @escaping (Result<LogoutResponse, Error>)-> ()){
        request(APIRouter.logout){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Get User Details
    
//    class func  getUserDetails(completion: @escaping (Result<UserData, Error>)-> ()){
//        request(APIRouter.getUserDetails){ (response) in
//            completion(response)
//        }
//    }
    
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
    
    //MARK:- Edit User Details ( Age )

    class func EditProfile(age: String,completion: @escaping (_ error: Error?, _ userData: EditProfileResponse?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]
        
        let body = [
            "age": age
        ]
        
        AF.request(URLs.EditProfile, method: HTTPMethod.put, parameters: body, encoding: JSONEncoding.default, headers: headers).response { response in
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
                let editProfileData = try decoder.decode(EditProfileResponse.self, from: data)
                completion(nil, editProfileData)
            } catch let error {
                print(error)
            }
        }
    }
    
    //MARK:- Delet Task

    class func deletTask(id: String, completion: @escaping (_ error: Error?, _ deletData: DeletTaskResponse? ) -> Void) {

        let headers: HTTPHeaders = [HeaderKeys.contentType:"application/json",
                                    HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]

        AF.request(URLs.delet + id, method: HTTPMethod.delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).response { response in
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

    
    //MARK:- Add Task

    class func addTask(descriptionn: String, completion: @escaping (_ error: Error?, _ addData: AddTaskResponse? ) -> Void) {

        let headers: HTTPHeaders = [HeaderKeys.contentType:"application/json",
                                    HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]
        let params: [String: Any] = [ParameterKeys.description : descriptionn]
        

        AF.request(URLs.addTask, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response { response in
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
                let addTaskData = try decoder.decode(AddTaskResponse.self, from: data)
                completion(nil, addTaskData)
            } catch let error {
                print(error)
            }
        }
    }



//MARK:- upload Photo

    
    
  class func uploadPhoto(with image: UIImage, completion: @escaping (Bool) -> Void) {

    guard let imageJpgData = image.jpegData(compressionQuality: 0.8) else {return}
    let headers: HTTPHeaders = [HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]
                              

        AF.upload(multipartFormData: {(formData) in
        formData.append(imageJpgData, withName: "avatar", fileName: "Photo.jpg", mimeType: "blog-header.jpg")
    }, to: URLs.uploadPhoto,method: HTTPMethod.post, headers: headers).response { response in
        guard response.error == nil else {
            print(response.error!.localizedDescription)
            completion(false)
            return
        }
        print(response)
        completion(true)
    }
}
}

    // MARK:- The request function to get results in a closure
extension APIManager{
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            print(response)
        }
    }
}

