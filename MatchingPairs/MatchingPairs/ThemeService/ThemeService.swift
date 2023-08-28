//
//  ThemeService.swift
//  MatchingPairs
//
//  Created by petrut alexandra on 26.08.2023.
//

import Foundation

enum CustomError: Error {
    case urlCreationFailed
}

fileprivate let themesUrl = "https://firebasestorage.googleapis.com/v0/b/concentrationgame-20753.appspot.com/o/themes.json?alt=media&token=6898245a-0586-4fed-b30e-5078faeba078"

final class ThemeService {
    
    func fetchThemes(completion: @escaping ([Theme]?, Error?) -> Void) {
        
        guard let url = URL(string: themesUrl) else {
            completion([], CustomError.urlCreationFailed)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil) // No error, but no data received
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let themes = try decoder.decode([Theme].self, from: data)
                completion(themes, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
