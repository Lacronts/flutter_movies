import 'package:equatable/equatable.dart';

class EntertainmentCrew extends Equatable {
  final String creditId;
  final int id;
  final String job;
  final String name;
  final String department;

  const EntertainmentCrew({
    this.id,
    this.creditId,
    this.job,
    this.name,
    this.department,
  });

  static EntertainmentCrew fromJson(Map<String, dynamic> json) {
    return EntertainmentCrew(
      id: json['id'],
      creditId: json['credit_id'],
      job: json['job'],
      name: json['name'],
      department: json['department'],
    );
  }

  @override
  List<Object> get props => [creditId, id, job, name, department];
}

class Jobs {
  static const Director = 'Director';
  static const Screenplay = 'Screenplay';
}

class Department {
  static const Writing = 'Writing';
}
