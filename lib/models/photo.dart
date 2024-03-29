// class Photo {
//   int? id;
//   String photoName;

//   Photo({this.id, required this.photoName});

//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       'id': id,
//       'photoName': photoName,
//     };
//     return map;
//   }

//   Photo.fromMap(Map<String, dynamic> map) {
//     id = map['id'];
//     photoName = map['photoName'];
//   }
// }

class Photo {
  late int? id;
  late String photoName;

  Photo({this.id, required this.photoName});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photoName': photoName,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photoName = map['photoName'];
  }
}
