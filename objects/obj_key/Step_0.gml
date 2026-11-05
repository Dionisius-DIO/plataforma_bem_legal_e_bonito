//se eu tenho um alvo.
if(instance_exists(alvo_player))
{
    //sigo o player na horizontal.
    x = lerp(x, alvo_player.x, 0.05);
    
    //sigo o player na vertical.
    y = lerp(y, alvo_player.y - alvo_player.sprite_height, 0.1)
}