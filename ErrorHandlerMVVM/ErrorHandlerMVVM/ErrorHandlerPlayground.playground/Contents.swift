//: Playground - noun: a place where people can play

import UIKit
import ErrorHandlerMVVM
import PlaygroundSupport

var str = "Hello, playground"
print(str)

var navi = UINavigationController()

var controller = UIViewController()
controller.view

navi.viewControllers = [controller]
 
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = navi

controller.showGenericError(message: "Hola")