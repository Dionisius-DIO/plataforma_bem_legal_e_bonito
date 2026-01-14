//estado. 
estado = noone;

sprite_index = sprite;

//timer.
timer  = tempo;

//Método do timer.
Timer = function(_estado = x)
{
    //diminuindo timer.
    timer--;
    
    //se meu timer for menor ou igual a 0,
    if(timer <= 0)
    {
        //mudo se estado.
        estado = _estado;
        
        //reseto o timer.
        timer = tempo;
    }
}

#region Estados do bloco.

//estado visivel.
estado_V = function()
{
    //colocando o frame correto.
    image_index = 0;
    
    //colocando mascara de colisão.
    mask_index  = spr_block_B;
    
    //colocando timer.
    Timer(estado_transI);
    
}

//estado transição pro estado invisivel.
estado_transI = function()
{
    //se eu chegar no frame 5,
    if(image_index >= 5)
    {
        //mudo de estado.
        estado = estado_I;
    }
}

//estado invisivel.
estado_I = function()
{
    //colocando frame certo.
    image_index = 5;
    
    //colocando mascara de colisão.
    mask_index = spr_nada;
    
    //colocando timer.
    Timer(estado_transV)
}

//estado transição para visivel.
estado_transV = function()
{
    //se eu chegar no frame certo,
    if(image_index >= image_number - 1)
    {
        //volto para o estado visivel.
        estado = estado_V;
    }
}

#endregion

//estado do bloco.
estado = estado_V;

//se o estado for igual a invisivel.
if(estado_inicial == "estado_I")
{
    //meu estado é igual a estado invisivel.
    estado = estado_I;
}
