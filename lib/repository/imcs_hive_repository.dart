import 'package:calculadoraimc/model/imc_hive_model.dart';
import 'package:hive/hive.dart';


class ImcsHiveRepository {
  static late Box _box;

  ImcsHiveRepository._criar();

  static Future<ImcsHiveRepository> carregar() async {
    if (Hive.isBoxOpen('imcHiveModel')) {
      _box = Hive.box('imcHiveModel');
    } else {
      _box = await Hive.openBox('imcHiveModel');
    }
    return ImcsHiveRepository._criar();
  }

  salvar(ImcHiveModel imcHiveModel) {
    _box.add(imcHiveModel);
  }

  alterar(ImcHiveModel imcHiveModel) {
    imcHiveModel.save();
  }

  excluir(ImcHiveModel imcHiveModel) {
    imcHiveModel.delete();
  }

  List<ImcHiveModel> obterDados() {
       
    return _box.values.cast<ImcHiveModel>().toList();
  }
}