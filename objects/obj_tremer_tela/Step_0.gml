//se treme for diferente de 0;
if(tremeT != 0)
{
	//variáveis x e y
	var _x = random_range(tremeT, -tremeT);
	var _y = random_range(tremeT, -tremeT);
	
	//fazendo tremer
	view_set_xport(view_current, _x);
	view_set_yport(view_current, _y);
	
}
else //se não
{
	//tremer é igual a 0.
	tremeT = 0;
	
	//não mexe.
	view_set_xport(view_current, 0);
	view_set_yport(view_current, 0);
	
}

//voltando ao normal.
tremeT = lerp(tremeT, 0, 0.1)