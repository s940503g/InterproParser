//
//  File.swift
//  InterproParser
//
//  Created by apple on 2016/11/1.
//
//

import Foundation
import SWXMLHash

public func readFile(path: String) -> String {
    
    do {
        let content: String = try String(contentsOfFile: path, encoding: String.Encoding.ascii)
        return content
    } catch {
        fatalError("Unable to read file: \(path)")
    }
}

public func checkLibrary(index: XMLIndexer, library: String) -> Bool {
    do {
        return try index["signature"]["signature-library-release"].value(ofAttribute: "library") == library
    }catch{
        fatalError("\(index)")
    }
}

public func selectLibrary(match_index: XMLIndexer, library: String) -> [XMLIndexer]? {
    var indexes: [XMLIndexer]?
    
    for index in match_index.all {
        if checkLibrary(index: index, library: library) {
            indexes = []
            indexes?.append(index)
        }else{
        }
    }
    
    return indexes
}

public func getLocations(lib_match: XMLIndexer) -> [(start: Int, end: Int)] {
    
    let locations =  lib_match["locations"].children
    
    return locations.map({ loc in
        guard let start = Int((loc.element?.allAttributes["env-start"]?.text)!), let end = Int((loc.element?.allAttributes["env-end"]?.text)!) else {
            fatalError("\(#line), \(#function)")
        }
        return (start, end)
    })
}

public func makeLine(accession: String, pfamAnnotations: [String], goterm: [String]) -> String {
    return accession + "\t" + pfamAnnotations.joined(separator: ",") + "\t" + goterm.joined(separator: ",")
}

public func makeLine(accession: String, goterm: [String]) -> String {
    return accession + "\t" + goterm.joined(separator: ",")
}

public func writeDoc(array: [String], filename: String) {
    let content = array.joined(separator: "\n")
    do {
        try content.write(toFile: filename, atomically: true, encoding: String.Encoding.utf8)
    }catch{
        fatalError("cant not write document.")
    }
    
    print("output to \(filename)")
}

