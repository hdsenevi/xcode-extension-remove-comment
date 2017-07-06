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
        
        // Replace top header with the preset text
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
            
            // Remove top comment
            invocation.buffer.lines.removeObjects(in: NSRange(location: 0, length: lastCommentLine))
            
            // Assign the new header
            invocation.buffer.lines.insert(newHeader, at: 0)
        }
        
        // Remove all comments command
        if invocation.commandIdentifier.contains("RemoveComments") {
            let lines = invocation.buffer.lines
            
            var commentLineStart = 0
            var commentLineEnd = 0
            
            // Will hold the start index and the count of comments from start index
            var removeArray = [(start: Int, count: Int)]();
            
            for (i, bufferLine) in lines.enumerated() {
                let line = bufferLine as! String
                if line.trimmingCharacters(in: .whitespaces).hasPrefix("//") {
                    commentLineEnd = i
                }
                else {
                    if commentLineStart != 0 && commentLineStart != commentLineEnd {
                        
                        // Since we need the count of commented lines, not to-line index
                        removeArray.append((commentLineStart + 1, commentLineEnd - commentLineStart))
                    }
                    
                    commentLineStart = i
                    commentLineEnd = commentLineStart
                }
            }
            
            // Remove the actual comments
            for removeElement in removeArray.reversed() {
                lines.removeObjects(in: NSRange(location: removeElement.start, length: removeElement.count))
            }
        }
        
        completionHandler(nil)
    }
    
}
