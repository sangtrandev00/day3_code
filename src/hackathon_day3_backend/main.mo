import Debug "mo:base/Debug";
import ExperimentalCycles "mo:base/ExperimentalCycles";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Prim "mo:prim";
import Principal"mo:base/Principal";
import Result "mo:base/Result";

import Animals "animal";
import Student "custom";

actor {
 
//  Challenge 1
  public type student = Student.Student;
  let sang : student = {
    id = "PS20227";
    name = "Tran Nhat Sang";
    age = 22;
    message = "This is Sang's Information";
  };

  public func fun () : async student {
    return sang;
  };

  // Challenge 2

  public type Animal = Animals.Animals;
  let cat : Animal = {
    species = "Meo";
    energy = 200;
    weight = 3;
    place = "My House HiHi";
  };

  public func callAnimal() : async Text {
    return cat.species;
  };


  // Challenge 4

  public func create_animal_then_takes_a_break (species : Text, energy: Nat) : async Animal {

    var newAnimal : Animal = {
      species = species;
      energy = energy;
      weight = 200;
      place = "My house";
    };

    newAnimal := Animals.animal_sleep(newAnimal);
  // Animals o day nhu mot cai 

    return newAnimal;

    // Call Animal Sleep here

  };

  // Challenge 5
  // Create a list that store animals.
  public type List<Animal> = ?(Animal, List<Animal>); 
  // Empty list store animal
  var listAnimal = List.nil<Animal>();

  // Challenge 6
  // push 
  public func push_animal(animal : Animal): async () {
     listAnimal := List.push(animal, listAnimal);
  };
  // get
  public func get_animals() : async List.List<Animal> {
    return listAnimal;
  };

  // Challenge 11:

  public shared(msg) func whoami1() : async Principal {
    let principal_caller = msg.caller;
    return(principal_caller);
  };

 public shared({caller}) func whoami2() : async Principal {
    return(caller);
  };
  
  // function is anonymous
  public shared({caller}) func is_anonymous(): async Bool {
    Principal.isAnonymous(caller);
  };

  // Challenge 12

  let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
  
  // Challenge 13

  // public shared({caller}) func add_favorite_number(n: Nat): async() {
  //   favoriteNumber.put(caller, n);
  // };

  public shared({caller}) func show_favorite_number (): async ?Nat {
    // Debug.print(debug_show(caller));
    return favoriteNumber.get(caller);
  };

  // Challenge 14
  // Rewrite function add_favorite_number
  public shared({caller}) func add_favorite_number(n: Nat): async Result.Result<Text,Text> {
    var value = favoriteNumber.get(caller);
    Debug.print(debug_show(value));
    switch(value) {
      
      case(null) {
        favoriteNumber.put(caller,n);
        return #ok("You've successfully registered your number");
      };

      case(?something) {
        return #err("You've already registered your number")
      };

    }
  };


  // Challenge 15

  // Update
  public shared({caller}) func update_favorite_number(n: Nat) : async Result.Result<Text,Text> {
    // favoriteNumber.put(key, value);
    var value = favoriteNumber.get(caller);
    switch(value) {
      
      case (null) {
        return #err ("You haven't registered your favorite number yet!");
      };

      case(_) {
        favoriteNumber.put(caller,n);
        return #ok ("Updated successfully!");
      };

    };

  };

  // Delete

  public shared({caller}) func delete_favorite_number(n: Nat) :async Result.Result<Text,Text> {

    let valueCaller = favoriteNumber.get(caller);
    Debug.print(debug_show(valueCaller));
    switch(valueCaller) {
      case(null) {
        return #err("You haven't registered your favorite number yet!");
      };
      case(?something) {
        if(n == something) {
          // let hasRemoved = favoriteNumber.remove(caller);
          favoriteNumber.delete(caller);
          return #ok("You have removed " #Nat.toText(n) #" out of favorite numbers");
        }else {
          // if n is different from value caller --> show err here!
          return #err("Some thing went wrong here!");
        };
      };
  };
};



  // Challenge 16
  public func deposit_cycles () : async Nat {
    let depositAmount = 100000;
    ExperimentalCycles.add(depositAmount);

    Debug.print(Nat.toText(ExperimentalCycles.balance()));
    return depositAmount;
  };
  
  // Challenge 17

  public func withdraw_cycles (n: Nat ) {

  };

  // Challenge 18
  stable var count = 0;
  stable var versionNumber = 0;
  public func  increment_counter (n: Nat): async Nat {
    count += n;
    versionNumber +=1;
    Debug.print(debug_show(versionNumber));
    return count;
  }

  // Challenge 19.
  
  

  
};
