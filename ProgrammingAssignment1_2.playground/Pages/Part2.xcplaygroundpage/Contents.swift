//: [Previous](@previous)

import Foundation
enum Direction : String {
    case Latitude = "Latitude";
    case Longitude = "Longitude";
}

func degree(direction:Direction, degrees:Int) -> String {
    if direction == Direction.Latitude && 0 <= degrees && degrees <= 90 {
        return "N";
    }
    if direction == Direction.Latitude && -90 <= degrees && degrees < 0 {
        return "S";
    }
    if direction == Direction.Longitude && 0 <= degrees && degrees <= 180 {
        return "E";
    }
    if direction == Direction.Longitude && -180 <= degrees && degrees < 0 {
        return "W";
    }
    return "Invalid parameters";
}

class CoordinateIV {
    var direction: Direction;
    var degrees: Int;
    var minutes: UInt;
    var seconds: UInt;
    var pole: String;

    
    init() {
        self.degrees = 0;
        self.minutes = 0;
        self.seconds = 0;
        self.direction = Direction.Latitude;
        self.pole = "N";
    }
    
    init?(degrees: Int, minutes: UInt, seconds: UInt, direction: Direction) {
        if !(
            (
                -90 <= degrees && degrees <= 90 && direction == Direction.Latitude ||
                -180 <= degrees && degrees <= 180 && direction == Direction.Longitude
            ) &&
            0 <= minutes && minutes <= 59 &&
            0 <= seconds && seconds <= 59
        ) {
            print("Invalid parameters");
            return nil
        }
        self.degrees = degrees;
        self.minutes = minutes;
        self.seconds = seconds;
        self.direction = direction;
        self.pole = degree(direction:direction, degrees: degrees);
    }

    func method_1() -> String {
        return "\(abs(self.degrees))°\(self.minutes)'\(self.seconds)\" \(self.pole)"
    }
    
    func method_2() -> String {
        let floatDegree: Float = Float(abs(self.degrees)) + Float(self.minutes)/60 + Float(self.seconds)/3600;
        return "\(floatDegree)° \(self.pole)";
    }
    
    func method_3(coord: CoordinateIV) -> CoordinateIV? {
        if self.direction != coord.direction {
            return nil;
        }
        let degrees_3 = (self.degrees + coord.degrees) / 2;
        let minutes_3 = (self.minutes + coord.minutes) / 2;
        let seconds_3 = (self.seconds + coord.seconds) / 2;
        return CoordinateIV(degrees: degrees_3, minutes: minutes_3, seconds: seconds_3, direction: self.direction)
    }
    
    func method_4(coord_1:CoordinateIV, coord_2: CoordinateIV) -> CoordinateIV? {
        if coord_1.direction != coord_2.direction {
            return nil;
        }
        let degrees_3 = (coord_1.degrees + coord_2.degrees) / 2;
        let minutes_3 = (coord_1.minutes + coord_2.minutes) / 2;
        let seconds_3 = (coord_1.seconds + coord_2.seconds) / 2;
        return CoordinateIV(degrees: degrees_3, minutes: minutes_3, seconds: seconds_3, direction: coord_1.direction)
    }
    
}

let coord = CoordinateIV(degrees: -30, minutes: 55,seconds: 10, direction: .Latitude);
print(coord?.method_1() ?? "Invalid parameters");
print(coord?.method_2() ?? "Invalid parameters");

let coord_2 = CoordinateIV(degrees: 45, minutes: 33, seconds: 56, direction: .Longitude);
print(coord_2?.method_1() ?? "Invalid parameters");
print(coord_2?.method_2() ?? "Invalid parameters");

let coord_3 = CoordinateIV();
print(coord_3.method_1());
print(coord_3.method_2());

let coord_4 = coord?.method_3(coord: coord_3);
print(coord_4?.method_1() ?? "Invalid parameters");
print(coord_4?.method_2() ?? "Invalid parameters");

let coord_5 = coord_4?.method_4(coord_1: coord ?? coord_3, coord_2: coord_3)
print(coord_5?.method_1() ?? "Invalid parameters");
print(coord_5?.method_2() ?? "Invalid parameters");

//: [Next](@next)

