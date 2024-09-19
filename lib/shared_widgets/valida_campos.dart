class ValidaCampos {

ValidaCampos();  

static bool Validar (String altura, String peso){
  if(altura.isEmpty || peso.isEmpty || altura.contains(",") ){
    return false;
  } else {
    return true;
  }

}


}