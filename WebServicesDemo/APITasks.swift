import Foundation
import Alamofire
import SwiftyJSON


extension API{
    
    class func tasks (page: Int=1 ,completion: @escaping (_ error: Error?,_ tasks: [Task]?, _ last_page: Int )->Void) {
        let url = URLs.tasks
        
        guard let api_token = helprt.getApiToken() else {
            
            completion(nil, nil, page)
            return
            
        }
        
        let parameters: [String:Any] = [
            
            "api_token":api_token,
            "page": page
            
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result
                {
                case .failure(let error ):
                    completion(error,nil,page)
                    print(error)
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    
                    guard let dataArr = json["data"].array else {
                        completion(nil,nil,page)
                        return
                    }
                    var tasks = [Task]()
                    for data in dataArr {
                        if let data = data.dictionary, let task = Task.init(dict: data){
                            tasks.append(task)
                        }
                        
                        let last_page = json["last_page"].int ?? page
                        completion(nil,tasks,last_page)
                    }
                }
        }
    }
    
    
    class func newTask(newTask: Task, completion: @escaping (_ error:Error?, _ newTask: Task?)->Void) {
        let url = URLs.new_task
        guard let api_token = helprt.getApiToken() else {
            completion(nil,nil)
            return
        }
        
        let parameters = [
            "api_token": api_token,
            "task": newTask.task
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    
                    guard let taskData = json["task"].dictionary, let task = Task(dict: taskData) else {
                        completion(nil, nil)
                        return
                    }
                    
                    completion(nil, task)
                }
                
        }
    }
    
    class func deleteTask(task: Task, completion: @escaping (_ error: Error?, _ success: Bool)-> Void) {
        let url = URLs.delete_task
        
        guard let api_token = helprt.getApiToken() else {
            completion(nil,false)
            return
        }
        
        let parameters: [String: Any]  = [
            "api_token": api_token,
            "task_id": task.id
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        .responseJSON { response in
            
            switch response.result
            {
            case .failure(let error):
                completion(error, false)
                print(error)
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                guard let status = json["status"].toInt, status == 1  else {
                    completion(nil, false)
                    return
                }
                
                completion(nil, true)
            }
            
        }

    }
    
    class func editTask(task: Task, completion: @escaping (_ error: Error?, _ editedTask: Task?)-> Void) {
        let url = URLs.edit_task
        
        guard let api_token = helprt.getApiToken() else {
            completion(nil, nil)
            return
        }
        
        let parameters: [String: Any]  = [
            "api_token": api_token,
            "task_id": task.id,
            "task": task.task,
            "completed": task.completed.toInt
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    
                    guard let taskData = json["task"].dictionary, let task = Task(dict: taskData) else {
                        completion(nil, nil)
                        return
                    }
                    
                    completion(nil, task)
                }
                
        }
        
    }

}





