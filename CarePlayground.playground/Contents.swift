import UIKit

var myArray = [Double]()
var myDateArray = [String]()
var today = Date()
let calendar = Calendar.current

var year = calendar.component(.year, from: today)
var month = calendar.component(.month, from: today)
var day = calendar.component(.day, from: today)

let dayLength : TimeInterval = 60.0 * 60.0 * 24 //let minute : TimeInterval = 60.0 //let hour : TimeInterval = 60.0 * minute

myDateArray.append("\(day),\(month),\(year)")
myArray.append(7.9) //Will be from Previes VC Data Brought Forward

for _ in 0..<6  {
    let x = round(Double(arc4random_uniform(9))) + Double(arc4random_uniform(10))/10
    myArray.append(x)
    today = today - dayLength
    let year = calendar.component(.year, from: today)
    let month = calendar.component(.month, from: today)
    let day = calendar.component(.day, from: today)
    myDateArray.append("\(day),\(month),\(year)")
}

myArray.reverse()
print(myArray)
myDateArray.reverse()
print(myDateArray)

let newArray = myArray.map{round($0 * 10)/10}
print(newArray)

let newWrapString = """

Hello Hello

Guys!

Wht are you up to?

"""

print(newWrapString)

class TestData {
    var age : Int!
}


var age = 10

print(age)

var scoresArray = [String]()

scoresArray.append("Hello")
scoresArray.append("GoodBye")

print(scoresArray)

//scoresArray.removeAll()

print(scoresArray[0])
//scoresArray[0]


//print(scoresArray)

let basicArray = ["age",
                  "fallHistory",
                  "bowel",
                  "medication",
                  "patientCareEquipment",
                  "mobility",
                  "cognition",
                  "incontinence",
                  "urgencyOrFrequency",
                  "requiresAssistance",
                  "unsteadyGait",
                  "impairmentMobility",
                  "alteredAwareness",
                  "impulsive",
                  "lackOfUnderstandingOfOnesLimitations"]

var newArray1: [String] = []

for i in 0...basicArray.count - 1 {
    var item = basicArray[i]
    newArray1.append(item)
}

print(newArray1)

if basicArray.index(of: "incontinence") == 7 {
    print("Hellooooooo")
}






















