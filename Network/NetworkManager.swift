

import UIKit

public class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    private var requestTimeout = 15000
    private var sslConfigured = false
    public var apiUrl : String = ""
    public var apiKey : String = ""
    open var identityData : IdentityData?
    private var articlesSource = [Article]()
    private var categories : NSArray?
    private var chats: NSDictionary?
    private var messages: NSArray?
    private var chatMessages: NSDictionary?
    private var user: User?
    private var createdUser: User?
    
    private var chat : NSDictionary?
    private var identityUser : User?
    private var resultError : String?
    private var responseString : String?
    
    @objc public func getArticles(query: ArticlesQuery) -> [Article]? {
        self.articlesSource.removeAll()
        var url = apiUrl + "/search.json?ownership=knowledge-base"
        
        if query.type.count > 0 {
            url = url + "&type=" + query.type
        }
        
        if query.category >= 0 {
            url = url + "&category_id" + String(query.category)
        }
        
        if query.search.count > 0 {
            url = url + "&text=" + query.search
        }
        
        if query.featured {
            url = url + "&featured=1"
        }
        
        if query.forum > 0 {
            url = url + "&forum_id=" + String(describing: query.forum);
        }
        
        let response = getRequest(url: url)
        
        guard self.resultError == nil || self.resultError?.count == 0 else {
            return nil
        }
        let responseArticles = response.object(forKey: "knowledgeBase") as? NSArray ?? NSArray()
        for article in responseArticles {
            self.articlesSource.append(Article.init(dictionary: article as! [String : Any]))
        }
        
        return self.articlesSource
    }
    
    @objc public func getCategories() -> Set<String>? {
        var categories = Set<String>()
        if self.articlesSource.count > 0 {
            for article in self.articlesSource {
                categories.insert(article.category.name)
            }
        }
        
        return categories
    }
    
    @objc public func getChats(query: ChatsQuery ) -> Chats? {
        let url = self.apiUrl + "/chats.json?apiKey=" + self.apiKey + "&page=" + String(query.page)
        
        let response = self.getRequest(url: url)
        
        var chats : Chats?
        if (response.object(forKey:"success")) != nil {
            chats = Chats.init(dictionary: response.object(forKey:"success") as! [String : Any])
        } else if response.object(forKey:"error") != nil {
            self.resultError = (response.object(forKey:"error") as! NSDictionary).object(forKey: "message") as? String
        } else {
            chats = nil
        }
        
        if self.resultError!.count > 0 {
            return nil
        }
        return chats
    }
    
    @objc public func getChat(query: ChatQuery) -> Chat? {
        let url = self.apiUrl + "/chats/" + String(query.id) + ".json?apiKey=" + self.apiKey
        
        let responseDictionary = self.getRequest(url: url)
        var chat : Chat?
        if (responseDictionary.object(forKey:"success")) != nil {
            chat = Chat.init(dictionary: responseDictionary.object(forKey: "success") as! [String : Any])
        }
        if self.resultError!.count > 0 {
            return nil
        }
        return chat
    }
    
    @objc public func getChatMessages(query: ChatMessagesQuery ) -> ChatMessages? {
        let url = self.apiUrl + "/chats/" + String(query.id) + "/messages.json?apiKey=" + self.apiKey + "&page=" + String(query.page)
        
        let responseDictionary = self.getRequest(url: url)
        var messages : ChatMessages?
        if (responseDictionary.object(forKey:"success")) != nil {
            messages = ChatMessages.init(dictionary: responseDictionary.object(forKey:"success") as! [String : Any])
        }
        
        if self.resultError!.count > 0 {
            return nil
        }
        return messages
    }
    
    @objc public func getIdentity(createIfNotExists: Bool) -> User? {
        if (identityData != nil) {
            var url = self.apiUrl + "/sso/identity.json?token="
                + (identityData?.token)! + "&email=" + (identityData?.email)!
            
            if (identityData?.id)!.count > 0 {
                url += "&sso_id=" + (identityData?.id)!
            }
            
            let responseDictionary = self.getRequest(url: url)
            if (responseDictionary.object(forKey:"success")) != nil {
                let user = User.init(dictionary: responseDictionary.object(forKey:"success") as! [String : Any])
                
                if (user.id > 0) {
                    self.identityUser = user
                }
            }
        }
        if self.identityUser != nil && self.identityUser!.id > 0 {
            return self.identityUser!
        } else if createIfNotExists {
            let user = self.createUser()
            return user
        }
        return nil
        
    }
    
    public func createUser() -> User? {
        let url = self.apiUrl + "/register.json"
        var requestDictionary = NSDictionary()
        if (identityData != nil) {
            requestDictionary = identityData?.dictionaryFromIdentityData() as! NSDictionary
        }
        
        let response : NSDictionary? = self.postRequest(url: url, dataJson: requestDictionary)
        let user = (response?.object(forKey: "success") != nil) ? User.init(dictionary: response?.object(forKey:"success") as! [String : Any]) : nil
        
        if user?.id != nil {
            if (user?.id)! > 0 {
                return user
            }
        }
        return nil
    }
    
    
    public func getTickets(query: TicketsQuery) -> Tickets? {
        var url = self.apiUrl + "/tickets.json?bbcode=1&apiKey=" + self.apiKey + "&page=" + String(query.page)
        if query.search != nil {
            url += "&text=" + query.search!
        }
        let result = getRequest(url: url)
        
        if result.object(forKey: "success") != nil {
            return Tickets(object: result.object(forKey: "success") as! NSDictionary)
        }
        return nil
    }
    
    public func getTicket(ticketId: Int) -> Ticket? {
        let url = self.apiUrl + "/objects/" + String(ticketId) + ".json?bbcode=1&apiKey=" + self.apiKey
        
        let result = getRequest(url: url)
        
        if result.object(forKey: "success") != nil {
            let ticket = Ticket.init(object: result.object(forKey: "success") as! NSDictionary)
            if ticket.id > 0 {
                return ticket
            }
        }
        return nil
    }
    
    public func createTicket(form: TicketForm) -> Ticket? {
        let url = self.apiUrl + "/objects.json?mobile=1&apiKey=" + self.apiKey
        let response = postRequest(url: url, dataJson: form.getDictionaryFromTicket()! as NSDictionary)
        if response.object(forKey: "success") != nil {
            let ticket = Ticket.init(object: response.object(forKey: "success") as! NSDictionary)
            if ticket.id > 0 {
                return ticket
            }
        }
        return nil
    }
    
    public func getComments(query: CommentsQuery) -> [Comment]? {
        var result = [Comment]()
        let url = self.apiUrl + "/objects/" + "\(query.id)" + "/comments.json?bbcode=1&apiKey=" + self.apiKey
        let response = getRequest(url: url)
        if response.object(forKey: "success") != nil {
            let comments = response.object(forKey: "success") as! NSArray
            
            for comment in comments {
                result.append(Comment.init(dictionary: comment as! [String : Any]))
            }
        }
        return result
    }
    
    public func createComment(form: CommentForm) -> Comment? {
        let url = self.apiUrl + "/comments.json?mobile=1&apiKey=" + self.apiKey
        let response = postRequest(url: url, dataJson: form.dictionaryFromCommentForm() as NSDictionary)
        if response.object(forKey: "success") != nil {
            let comment = Comment.init(dictionary: response.object(forKey: "success") as! [String : Any])
            
            if comment.id > 0 {
                return comment
            }
        }
        return nil
    }
    
    open func getCustomFields(fieldType: String) -> [CustomField]? {
        var result = [CustomField]()
        let url = apiUrl + "/custom-fields/" + fieldType + ".json"
        let response = getRequest(url: url)
        if response.object(forKey: "success") != nil {
            let fields = response.object(forKey: "success") as! NSArray
            
            for field in fields {
                result.append(CustomField.init(dictionary: field as! [String : Any]))
            }
        }
        return result
    }
    
    open func uploadFile(form: FileForm) -> NSDictionary {
        let url = self.apiUrl + "/upload-file.json?apiKey=" + self.apiKey
        
        let response = postRequest(url: url, dataJson: ["name" : form.name, "content" : form.content])
        
        if response.object(forKey: "success") == nil {
            return ["error" : response.object(forKey: "error") as! NSDictionary]
        }
        return response.object(forKey: "success") as! NSDictionary
    }

    private func getRequest(url: String) -> NSDictionary {
        self.resultError = ""
        
        var resDict : NSMutableDictionary?
        if let fullUrl = URL(string: url) {
            
            let semaphore = DispatchSemaphore(value: 0)
            let request = URLRequest(url:fullUrl)
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if let data = data {
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            
                            resDict = NSMutableDictionary.init(dictionary : jsonResult)
                        }
                    } catch let error as NSError {
                        self.resultError = error.localizedDescription
                    }
                } else if let error = error {
                    self.resultError = error.localizedDescription
                }
                semaphore.signal()
            }).resume()
            
            semaphore.wait()
        }
        
        guard resDict != nil else {
            return NSDictionary()
        }
        return resDict!
    }
    
    private func postRequest(url: String, dataJson: NSDictionary) -> NSDictionary {
        self.resultError = ""
        var resDict : NSMutableDictionary?
        if let fullUrl = URL(string: url) {
            
            let semaphore = DispatchSemaphore(value: 0)
            var request = URLRequest(url:fullUrl)
            
            request.httpMethod = "POST"
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: dataJson, options: .prettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if let data = data {
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            resDict = NSMutableDictionary.init(dictionary : jsonResult)
                        }
                    } catch let error as NSError {
                        self.resultError = error.localizedDescription
                    }
                } else if let error = error {
                    self.resultError = error.localizedDescription
                }
                semaphore.signal()
            }).resume()
            
            semaphore.wait()
        }
        
        guard resDict != nil else {
            return NSDictionary()
        }
        return resDict!
    }
}
