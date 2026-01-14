//iniciando variáveis do efeito de brilho
function inicia_brilho(_cor = c_white)
{
    //escalas.
    xscale = 1;
    yscale = 1;
    
    //transparencia.
    alpha  = 0;
    
    //cor do brilho.
    cor    = _cor
    
    //direção do player.
    dir    = 1;
}

//colocando o brilho.
function coloca_brilho(_alpha = 1)
{
    //brilho.
    alpha = _alpha;
}

//fazendo o efeito sair.
function retorna_brilho()
{
    //se meu alpha for menor que 0.3, saio da função.
    if(alpha <= 0.01) return;
        
    //tirando o brilho.
    alpha = lerp(alpha, 0, 0.1);
}

//desenhando efeito.
function desenha_efeito()
{
    //colocando shader.
    shader_set(shader_brilho);
    
    //colocando efeito no player.
    draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, cor, alpha);
    
    //tirando shader.
    shader_reset();
}