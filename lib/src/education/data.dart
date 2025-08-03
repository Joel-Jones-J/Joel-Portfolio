import '../json_service.dart';

List<List<String>> education() {
  final List<List<String>> totalEducation = [];
  final List<String> temp = [];

  for (final k in JSONService.response['education'].values) {
    for (final l in k.values) temp.add(l.toString());

    if (temp[3] == '') temp[3] = 'constant/education.png';
    totalEducation.add([...temp]);
    temp.clear();
  }
  return totalEducation;
}
