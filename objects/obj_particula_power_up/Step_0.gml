//se não tenho alvo, saio.
if(!alvo) exit
    
//deixando as particulas transparentes.
image_alpha = speed / 3;
        
//se eu não estou voltando.
if(voltar == false)
{
    //movo para fora
    speed -= 0.05;
    
    //se a velocidade for menor ou igual a 0,
    if(speed <= 0)
    {
        //estou voltando.
        voltar = true;
        
        //deixando aleatorio
        var _x = alvo.x + random_range(2, 4);
        var _y = alvo.y - 16 + random_range(3, 5);
        
        //colocando direção.
        var _dir = point_direction(x, y, _x, _y);
        
        //indo para o player.
        direction = _dir;
    }
    
}
else //se não,
{
    //movo para dentro.
    speed += 0.05;
    
   //destruindo particulas.
    var _player = instance_place(x, y, obj_player);
    
    if(_player)
    {
        //colocando efeito squash
        with(_player)
        {
            //deixando valores do efeito aleatorio.
            var _xscale = random_range(0.9, 1.2);
            var _yscale = random_range(1.2, 0.9);
            
            //fazendo squash.
            squash(_xscale, _yscale);
            
            //tremendo tela
            tremer_tela(2);
            
            //toco som.
            play(snt_hit, 2, false);
            
            //brilho.
            coloca_brilho();
        }
        
        //destruindo particula.
        instance_destroy();
    }
    
}