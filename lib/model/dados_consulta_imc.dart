class ConsultaImc {

int _peso;
String _data;
double _imc;

ConsultaImc(this._peso, this._data, this._imc);

int get peso => _peso;

set peso (int peso) {
		    _peso = peso;	
		}

String get data => _data;

set data (String data) {
		    _data = data;	
		}    

double get imc => _imc;

set imc (double imc) {
		    _imc = imc;	
		}  



}