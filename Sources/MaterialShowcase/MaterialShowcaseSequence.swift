//
//  MaterialShowCaseSequence.swift
//  MaterialShowcase
//
//  Created by VB on 16.04.2019.
//  Copyright © 2019 Aromajoin. All rights reserved.
//

import UIKit

public class MaterialShowcaseSequence {
  
  var showcaseArray : [MaterialShowcase] = []
  var currentCase : Int = 0
  var key : String?

  private weak var parentView: UIView?
  
  public init() { }
  
  public func temp(_ showcase: MaterialShowcase) -> MaterialShowcaseSequence {
    showcaseArray.append(showcase)
    return self
  }
  public func start(parentView: UIView) {
    guard !getUserState(key: self.key) else {
      return
    }
    self.parentView = parentView
    showcaseArray.first?.show(parentView: parentView, completion: increase)
  }
  func increase() -> Void {
    self.currentCase += 1
  }
  
  /// Set user show retry
  public func setKey(key : String? = nil) -> MaterialShowcaseSequence {
    guard key != nil else {
      return self
    }
    self.key = key
    return self
  }
  
  /// Remove user state
  public func removeUserState(key : String = MaterialKey._default.rawValue) {
    UserDefaults.standard.removeObject(forKey: key)
  }
  /// Remove user state
  func getUserState(key : String?) -> Bool {
    guard key != nil else {
      return false
    }
    return UserDefaults.standard.bool(forKey: key!)
  }
  
  public func showCaseWillDismis() {
    guard self.showcaseArray.count > currentCase else {
      //last index
      guard self.key != nil else {
        return
      }
      UserDefaults.standard.set(true, forKey: key!)
      return
    }
    guard let parentView = self.parentView else { return }
    showcaseArray[currentCase].show(parentView: parentView, completion: self.increase)
  }
  
}

