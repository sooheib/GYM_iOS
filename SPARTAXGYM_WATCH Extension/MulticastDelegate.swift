//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation

class MulticastDelegate<T: AnyObject>{
    
// MARK: - Initializers
    
    init(weakReferences: Bool = true){
        self.delegates = weakReferences ? NSHashTable<T>.weakObjects() : NSHashTable<T>()
    }
    
// MARK: - Public Methods
    
    func addDelegate(_ delegate: T){
        delegates.add(delegate)
    }
    
    func removeDelegate(_ delegate: T){
        delegates.remove(delegate)
    }
    
    func removeAllDelegates(){
        delegates.removeAllObjects()
    }
    
    func contains(_ delegate: T) -> Bool{
        return delegates.contains(delegate)
    }
    
    func invoke(_ invocation: (T) -> Void){
        for delegate in delegates.allObjects{
            invocation(delegate)
        }
    }
    
// MARK: - Private Properties
    
    private let delegates: NSHashTable<T>
}
