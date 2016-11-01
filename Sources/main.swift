import SWXMLHash
import Foundation

let args = Array(CommandLine.arguments.dropFirst())

let file: String = readFile(path: args[0])
let xml = SWXMLHash.parse(file)
//print(xml)

let proteins = xml["protein-matches"]["protein"].all


var lines: [String] = []

func getGOterms(protein_indexer: XMLIndexer) -> [String] {
    
    return protein_indexer["matches"].children.flatMap({
        return $0["signature"]["entry"]["go-xref"].all.flatMap({
            return $0.element?.attribute(by: "id")?.text
        })
    })
}

for protein in proteins {
    
    if let id = protein["xref"].element?.allAttributes["id"]?.text {
        
        let line = makeLine(accession: id, goterm: getGOterms(protein_indexer: protein))
        
        lines.append(line)
    }
    
}

writeDoc(array: lines, filename: args[1])
