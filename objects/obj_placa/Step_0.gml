//criando colisão com o player.
var _player = place_meeting(x, y, obj_player);

//se o player tocar a placa,
if(_player)
{
    //se eu não tenho uma caixa de dialogo.
    if(!instance_exists(caixa_D)) 
    {
        //crio caixa de dialogo..
        caixa_D = instance_create_layer(x, y, "dialogo", obj_caixa_dialogo);
        
        //diminuindo a escala.
        caixa_D.image_xscale = 0.1;
        
        //dando o texto da placa.
        caixa_D.texto = texto;
        
    }
}
else//se eu não to tocando o player.
{
    //se eu já criei a caixa de dialogo.
    if(instance_exists(caixa_D))
    {
        //eu me destruio.
       caixa_D.destruir = true;  
    }
    
}