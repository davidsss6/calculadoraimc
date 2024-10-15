import 'package:hive/hive.dart';

part 'imc_hive_model.g.dart';

@HiveType(typeId: 1)
class ImcHiveModel extends HiveObject {
  @HiveField(0)
  int peso = 0;

  @HiveField(1)
  String data = "";

  @HiveField(2)
  double imc = 0;

  ImcHiveModel();

  ImcHiveModel.criar(this.peso, this.data, this.imc);
}