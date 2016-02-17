import Foundation

let string1 = "Helloworld"
let string2 = "carl"





func checkForSubString(subString: String, parentString: String) -> Bool {
    var arrayOfChars = Array(subString.lowercaseString.characters)
    
    for _ in 0..<arrayOfChars.count {
        
        if parentString.lowercaseString.characters.contains(arrayOfChars.first!) {
            
            arrayOfChars.removeFirst()
            
        }
        print(arrayOfChars)
    }
    
    return arrayOfChars.isEmpty
    
}



checkForSubString(string2, parentString: string1)




// Grab the number of characters in a  string
// Loop through