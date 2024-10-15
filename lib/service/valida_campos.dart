class ValidaCampos {

ValidaCampos();  

static bool ValidarPeso (String peso){
  if(peso.isEmpty || peso.contains(",") || peso.contains(".")){
    return false;
  } else {
    return true;
  }
}

static bool ValidarNome (String nome){
  if(nome.isEmpty){
    return false;
  } else {
    return true;
  }
}

static bool ValidarAltura (String altura){
  if(altura.isEmpty || altura.contains(",")){
    return false;
  } else {
    return true;
  }
}


}