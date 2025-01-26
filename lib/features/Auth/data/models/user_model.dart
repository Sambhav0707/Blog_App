// import '../../domain/entities/user.dart';

// class UserModel extends User {
//   UserModel(super.id, super.name, super.email);

//   factory UserModel.fromJson(Map<String, dynamic> map) {
//     return UserModel(
//       map['id'],
//       map['name'],
//       map['email']
//     );
//   }
// }
import '../../../../core/comman/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
  }) : super(id, name, email);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 'Unknown ID', // Default value for missing id
      name: map['name'] ?? 'Unknown Name', // Default value for missing name
      email: map['email'] ?? 'Unknown Email', // Default value for missing email
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
