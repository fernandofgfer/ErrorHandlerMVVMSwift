//
//  ErrirHandlerExtension.swift
//  ErrorHandlerMVVM
//
//  Created by Fernando García Fernández on 7/3/17.
//  Copyright © 2017 Fernando García Fernández. All rights reserved.
//

public enum errors: Error {
    case InternalError
    case ServerError(code: String)
    case ServerErrorWithNumber(code: String, number: Int)
    // Aqui podemos insertar más tipos de error
}



public struct errorMessages{
    
    static var errorSelfBankServers = NSLocalizedString("Error.noRed", comment: "")
    static var errorRequestGeneric = NSLocalizedString("Error.requestGeneric", comment: "")
    static var updateCategorie = "Se ha solicitado el cambio de categoría, en unos segundos se hará efectiva."
}


public protocol errorHandlerProtocol{
    func sendMsgGenericErrorDelegate(msg: String)
    func sendMsgGenericErrorTypeDelegate(errorType: errors)
}


extension UIViewController : errorHandlerProtocol{
    
    
    func delegateErrorGeneric(vm: ViewModel){
        vm.errorHandlerDelegate = self
    }
    
    // Llamada genérica donde indicamos nosotros el mensaje
    public func sendMsgGenericErrorDelegate(msg: String) {
        //self.showGenericError(msg)
    }
    
    // Error genérico por tipo
   public func sendMsgGenericErrorTypeDelegate(errorType: errors) {
        
        switch errorType {
        case .InternalError:
            self.showGenericError(message: errorMessages.errorSelfBankServers)
        case let .ServerError(errorMessage):
             self.showGenericError(message: errorMessage)
        case let .ServerErrorWithNumber(errorMessage, _):
             self.showGenericError(message: errorMessage)
        }
        
    }
    
    func sendMsgCategorie(){
        //self.showGenericError(errorMessages.updateCategorie)
    }
    
}

class ViewModel: NSObject{
    
    var errorHandlerDelegate: errorHandlerProtocol!
    
    
}
