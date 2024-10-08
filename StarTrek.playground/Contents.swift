/*:
 # Fun with functional programming and structs

 *A recap from the lecture slides:*
 
 **map()**
 ::
 Takes a value out of a container, applies a function to it, then puts the result of that function back into a new container that gets returned to you.
 
 **compactMap()**
 ::
 The compactMap() function is a variant of map() that removes nil objects and automatically unwraps optional values.
 
 **filter()**
 ::
 The filter() method loops over every item in a collection, and passes it into a function that you write. If your function returns true for that item it will be included in a new array, which is the return value for filter().
 
 **reduce()**
 ::
 The reduce() function condenses an array into a single value by applying a function to every item. Each time the function is called, you get passed the previous value from your function as well as the next item in your array.
 
 **sorted()**
 ::
 Can do basic sorts on arrays without even passing arguments to it, but can also pass in blocks that handle more complex sorting if using *by:* parameter.
 
*/
var captains: [String: String] = ["kirk": "ncc1701", "sisko": "nx74205", "janeway": "ncc74656", "picard": "ncc1701d"]

var firstOfficers: [String: String] = ["spock": "ncc1701", "kira": "nx74205", "chakotay": "ncc74656", "riker": "ncc1701d", "tpol": "nx01"]

var vulcanOfficers: [String] = ["spock", "tuvok", "tpol"]

var humanOfficers: [String] = ["sisko", "kirk", "picard", "chakotay", "janeway", "riker", "seven"]

var femaleOfficers: [String] = ["kira", "dax", "tpol", "janeway", "troi", "seven"]

/*:
First, a set of warm-up problems for everyone
*/
// Q0: How many human officers are there?
let numHumanOfficers = humanOfficers.count
print("Number of human officers: \(numHumanOfficers)")


// Q1: What percentage of humans are female?

let femaleHumanOfficers = humanOfficers.filter { femaleOfficers.contains($0) }
let percentageOfFemaleHumans = (Double(femaleHumanOfficers.count) / Double(humanOfficers.count)) * 100
print("Percentage of human officers that are female: \(percentageOfFemaleHumans)%")



// Q2: How many first officers are human?

let humanFirstOfficers = firstOfficers.keys.filter { humanOfficers.contains($0) }
let numberOfHumanFirstOfficers = humanFirstOfficers.count
print("Number of human first officers: \(numberOfHumanFirstOfficers)")



// Q3: Get a list of females sorted by name

let sortedFemaleOfficers = femaleOfficers.sorted()
print("Sorted female officers: \(sortedFemaleOfficers)")



/*:
 Given the following struct and some methods to make these objects comparable, answer the questions in the sets below
 */
struct Officer: Comparable {
  var name: String
  var ship: String
  
  init(name: String, ship: String){
    self.name = name
    self.ship = ship
  }

  // To make this struct conform to Equatable protocol
  // Note that since matching all properties, this would
  // have been given automatically when made Equatable
  static func ==(lhs: Officer, rhs: Officer) -> Bool {
    return lhs.name == rhs.name && lhs.ship == rhs.ship
  }
  
  // To make this struct conform to Comparable protocol
  static func <(lhs: Officer, rhs: Officer) -> Bool {
    return lhs.name < rhs.name
  }
}

/*:
Group 1
*/
// Q4: Create an array of officer objects who captain starships
let captainOfficers = captains.map { Officer(name: $0.key, ship: $0.value) }
print("Captain officers: \(captainOfficers)")




// Q5: Alphabetize the previous list by the captain's name
let sortedCaptainOfficers = captainOfficers.sorted()
print("Sorted captain officers: \(sortedCaptainOfficers)")

/*:
Group 2
*/
// Q6: Create an array of officers serving as first officers who are also Vulcan
let vulcanFirstOfficers = firstOfficers.keys
    .filter { vulcanOfficers.contains($0) }
    .map { Officer(name: $0, ship: firstOfficers[$0]!) }
print("Vulcan first officers: \(vulcanFirstOfficers)")



// Q7: How many these Vulcan first officers have names shorter than 5 characters?
let shortNamedVulcanFirstOfficers = vulcanFirstOfficers.filter { $0.name.count < 5 }
let numberOfShortNamedVulcans = shortNamedVulcanFirstOfficers.count
print("Number of Vulcan first officers with names shorter than 5 characters: \(numberOfShortNamedVulcans)")



