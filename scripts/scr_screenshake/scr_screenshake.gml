function tremer_tela(_treme = 0)
{
	//se a instancia do objeto
	if(instance_exists(obj_tremer_tela))
	{
		//codigo dentro do objeto.
		with(obj_tremer_tela)
		{
			//se tremer tela for maior que tremer tela
			if(_treme > tremeT)
			{
				//treme mais forte.
				tremeT = _treme
			}
		}
	
	}

}