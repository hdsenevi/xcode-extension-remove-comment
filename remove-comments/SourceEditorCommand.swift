//
//  SourceEditorCommand.swift
//  remove-comments
//
//  Created by Sha on 5/7/17.
//  Copyright © 2017 Sha. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        print("Content Type : \(invocation.buffer.contentUTI)")
        print("Command Identifier : \(invocation.commandIdentifier)")
        
        if invocation.commandIdentifier.contains("TestHeader") {
            var reachedEndOfHeader = false
            var lastCommentLine = 0
            let newHeader = "// Hello world, new header"
            
            // Delete the header
            while !reachedEndOfHeader {
                let currentLine = invocation.buffer.lines[lastCommentLine] as! String
                
                if currentLine.hasPrefix("//") {
                    invocation.buffer.lines[lastCommentLine] = ""
                    lastCommentLine += 1
                } else {
                    reachedEndOfHeader = true
                    lastCommentLine -= 1
                }
            }
            
            // Assign the new header
            invocation.buffer.lines[0] = newHeader
        }
        
        completionHandler(nil)
    }
    
}
