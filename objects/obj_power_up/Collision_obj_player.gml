//se eu não tenho alvo.
if(alvo == noone)
{
    //mudo o estado do player.
    other.power_up();
    
    //colocando o alvo.
    alvo = other.id;
    
    //consigo virar morcegoum.
    other.morcego = true;
    
    //destruo as particulas.
    part_system_destroy(ps);

    //mexendo power up;
    move();
    
    //usando as particulas.
    particulas();
}

//tocando som.
play(snt_power_up, 2, false);
