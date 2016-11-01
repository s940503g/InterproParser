import PackageDescription

let package = Package(
       name:"InterproParser",
       dependencies: [
	       .Package(url:"https://github.com/drmohundro/SWXMLHash.git", "3.0.2")
       ]
       )
