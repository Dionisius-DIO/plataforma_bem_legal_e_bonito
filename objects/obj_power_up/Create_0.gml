//alvo do power up.
alvo    = noone;

//voltando.
voltar  = false;

//criando particula.
ps      = part_system_create(ps_part_power_up);

//posicionando particula.
part_system_position(ps, x, y);

//método para mover power up.
move = function()
{
    //se não tenho alvo, saio do evento.
    if(!alvo) return;
        
    //definindo posição do power up.
    x = alvo.x;
    y = alvo.y - 42;
    
}

//método de criar particulas.
particulas = function()
{
    
    var _qtd = irandom_range(20, 40);
    //repetir.
    repeat (_qtd) 
    {
        //criando particula.
        var _part = instance_create_layer(x, y, "efeito_tochas", obj_particula_power_up);
        
        //velocidade e direção das particulas.
        _part.speed         = random_range(2, 3);
        _part.direction     = random_range(0, 359);
        
        //dando alvo para particula.
        _part.alvo = alvo;
        
    }
}

