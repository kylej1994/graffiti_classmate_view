//
//  RequestProtocol.swift
//  Graffiti
//
//  Created by Henry Lewis on 2/10/17.
//  Copyright © 2017 Amanda Aizuss. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol RequestProtocol {
    @discardableResult func defaultValidate() -> Self
    @discardableResult func responseJSON(completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self
    @discardableResult func responseObject<T: BaseMappable>(completionHandler: @escaping (DataResponse<T>) -> Void) -> Self

}

extension DataRequest : RequestProtocol {
    func defaultValidate() -> Self {
        return validate()
    }

    func responseJSON(completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        return responseJSON(queue: nil, options: .allowFragments, completionHandler: completionHandler)
    }
    
    func responseObject<T: BaseMappable>(completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil, completionHandler: completionHandler)
    }
}

