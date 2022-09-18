//
//  CoreDataManager.swift
//  TimeTrackerApp
//
//  Created by Ensar Batuhan Ünverdi on 18.09.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    var coreDataStack: CoreDataStack
    var moc: NSManagedObjectContext {
        return coreDataStack.managedContext
    }
    
    private init(coreDataStack: CoreDataStack = CoreDataStack(modelName: "TaskModel")) {
        self.coreDataStack = coreDataStack
    }
    
    private func taskIDPredicate(of request: NSFetchRequest<TaskModel>, with id: Int) -> NSPredicate {
        request.predicate = NSPredicate(format: "id == %d", id)
        return request.predicate!
    }
    
    func getTaskFromPersistance(completion: @escaping (Result <[TaskModel], Error>) -> Void) {
        do {
            let request: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
            request.returnsObjectsAsFaults = false
            let task = try moc.fetch(request)
            completion(.success(task))
        } catch {
            completion(.failure(error))
        }
    }
    
//    func createMovie(with movieResult: MovieResults) {
//        let favouriteMovie = FavouriteMovie(context: moc)
//        favouriteMovie.id = Int64(movieResult.id ?? 0)
//        favouriteMovie.title = movieResult.title
//        favouriteMovie.voteAverage = movieResult.voteAverage ?? 0.0
//        favouriteMovie.posterPath = movieResult.posterPath
//        favouriteMovie.releaseDate = movieResult.releaseDate
//        coreDataStack.saveContext()
//    }
    
    
}
