#region variáveis
//variável da velocidade horizontal.
hsp                 = 0;

//variável da velocidade horizontal MÁXIMA.
max_hsp             = 1;

//variável da velocidade vertical.
vsp                  = 0;

//variável da velocidade vertical MÁXIMA.
max_vsp             = 3.7;

//variável do corner correction.
corner_pixels       = 8;

//váriavel da gravidade.
grav                = 0.2;

//variável de gravidade.
chao                = false;

//variável de onde virar morcego.
voa                 = false;

morcegando          = layer_tilemap_get_id("morcego");           

//criando colisão com o tileset.
var _tile           = layer_tilemap_get_id("chao");

//criando colisão com o tileset.
var _tile_1         = layer_tilemap_get_id("chao_1");

//criando a variável dos colisores com array.
colisores           = [obj_wall, obj_wall_one_way, _tile, _tile_1];

//variáveis dos inputs;
left                = false;
right               = false;
jump                = false; 
morcedificar        = false;

//variável da view.
view_player         = noone;


//variável de estado.
estado              = noone;

//variável da direção.
dir                 = 1; 

//variável de power up.
morcego             = global.morcego_p;

//variável das chaves.
chaves              = 0;

//variável da força da queda.
forca               = 0;

//váriavel do timer do coyote.
coyoteJ_timer       = game_get_speed(gamespeed_fps) * .1;

//váriavel do coyote jump atual.
coyoteJ_timer_atual = coyoteJ_timer;

//váriavel do buffer do pulo.
bufferJ_timer       = game_get_speed(gamespeed_fps) * .1;

//váriavel atual do buffer do pulo.
bufferJ_timer_atual = 0;

//variável de squash.
iniciar_squash();

//variável do brilho.
inicia_brilho();


#endregion

 
#region Métodos.

//método dos inputs.
input = function()
{
    //botões de movimento.
    left         = keyboard_check(ord("A")) or keyboard_check(vk_left);
    right        = keyboard_check(ord("D")) or keyboard_check(vk_right);
    
    //botão de pulo.
    jump         = keyboard_check_pressed(vk_space);
    jump_r       = keyboard_check_released(vk_space);
    
    //botão de virar morcego.
    morcedificar = keyboard_check_pressed(ord("E")) or keyboard_check_pressed(vk_shift);
    
}

//método do level.
toco_chao = function()
{
    //chão é igual a place meeting.
    chao = place_meeting(x, y + 1, colisores);
    
    //chão onde posso transformar.
    voa = place_meeting(x, y + 1, morcegando);
}

//método de movimentação.
control = function()
{
        
    //ativando o toco chão.
    toco_chao();
        
    //velocidade horizontal é igual a direita menos esquerda vezes a velocidade máxima.
    hsp = (right - left) * max_hsp;
    
    ////x é mais igual a velocidade horizontal.
    //x += hsp;
    
     ///APLICANDO GRAVIDADE///
    
    
    //se não estou tocando no chão,
    if(!chao)
    {
        //eu caio.
        vsp += grav; //minha velocidade vertical é mais igual a gravidade.
        
        //aplicando limite de gravidade.
        vsp = clamp(vsp, -max_vsp, max_vsp);
        
    }
    else //se não.
    {
    	//minha velocidade vertical é zero.
        vsp = 0;
        
        //se eu pular,
        if(jump || bufferJ_timer_atual)
        {
            //eu subo! 
            vsp += -max_vsp; // minha velocidade vertical é igual a velocidade vertical máxima.
            
            ///zerando o buffer do pulo.
            bufferJ_timer_atual = 0;
        }
        
        
    }
    
    
    
}

//método de movimento do player.
movimento = function()
{
    //colisão horizontal.
    move_and_collide(hsp, 0, colisores, 24);
    
    //colisão vertical.
    move_and_collide(0, vsp, colisores, 24);
}

//método de trocar estado.
troca_estado = function()
{
    var _spd = sprite_get_speed(sprite_index) / FPS;
    
    if(image_index + _spd == image_number)
    {
        return true;
    }
}

//método de modificar a escala.
escala = function()
{
    if(hsp != 0) dir = sign(hsp);
}

//método de interação com o power up
power_up = function()
{
    //mudando estado do player.
    estado = estado_PU_inicio;
    
}

//método de pegar a chave.
 pega_chave = function()
{
    //aumento a quantidade de chaves.
    chaves++;
}

//método de abrir a porta.
abre_porta = function()
{
    //pegando id da porta.
    var _porta = instance_place(x + hsp, y, obj_door);
    
    //se eu toquei na porta,
    if(_porta)
    {
        //se eu tenho mais de 0 chaves.
        if(chaves > 0 && _porta.estado == "fechado")
        {
            //abo a porta.
            _porta.estado = "abrindo";
            
            //diminuo quantidade de chaves.
            chaves--;
            
            //toco som de abrir porta.
            play(snt_porta, 3, false);
        }
    }
}

//método de não entrar dentro do bloco.
nao_entrar = function()
{
    //se eu to dentro do bloco.
    if(place_meeting(x, y, obj_wall_one_way))
    {
        //se existe o obj_wall
        if(array_contains(colisores, obj_wall_one_way))
        {
            //eu deleto ele.
            var _id = array_get_index(colisores, obj_wall_one_way);
            
            //apagando.
            array_delete(colisores, _id, 1);
             
        }
    }
}

//método de coyote jump.
coyote_jump = function()
{
    //checando se toquei o chão.
    toco_chao();
    
    //se eu não estou tocando o chão.
    if(!chao)
    {
        //diminuio o coyote jump atual
        coyoteJ_timer_atual--;
    }
    else//se não.
    {
        //reseto ele.
        coyoteJ_timer_atual = coyoteJ_timer;
    }
}

//método do buffer do pulo.
buffer_pulo = function()
{
    //checando o chão.
    toco_chao();
    
    //inputs.
    input();
    
    //se eu não toquei no chão.
    if(!chao)
    {
        //se eu apertei o botão de pulo, meu buffer atual é igual ao buffer timer.
        if(jump) bufferJ_timer_atual = bufferJ_timer;
            
        //diminuo o buffer timer atual.
        bufferJ_timer_atual--;
    }
}

#endregion

#region Debugs

//método do debug.
debugs = function()
{
    
    //se o modo debug tiver desativado, sai do método.
    //if(!global.debug) return;
    
    //mostrando os fps;
    show_debug_overlay(global.debug);
    
    //colocando a view dele.
    view_player = dbg_view("view player", 1, 60, 80);
    
    //mostrando a velocidade vertical.
    dbg_watch(ref_create(id,"vsp"), "velocidade vertical");
    
    //ajustando a velocidade vertical máxima.
    dbg_slider(ref_create(id, "max_vsp"), 0, 10, "velocidade vertical máxima", 0.1);
    
    //ajustando a gravidade.
    dbg_slider(ref_create(id, "grav"), 0.1, 5, "gravidade", 0.1);
       
}

//método de ativar o debug.
ativa_debug = function()
{
    
    //se eu NÃO estiver no modo debug, não roda o método.
    if(DEBUG_MODE == false) return;
    
    //se eu apertar tab,
    if(keyboard_check_pressed(vk_tab))
    {
        //ativo e desativo o modo debug
        global.debug = !global.debug
        
        //se eu estiver com o modo debug ativado
        if(global.debug)
        {
           //usando o método do debug.
            debugs(); 
        }
        else //se não,
        {
        	//desativo tudo.
            show_debug_overlay(0);
            
            //se minha view exista e o moto debug ta desativado,
            if(dbg_view_exists(view_player))
            {
                //mato ela com variás mortes morridas.
                dbg_view_delete(view_player);
            }
        }
    }
        
}

#endregion

#region Estados.

//método de trocar a sprite do estado.
troca_sprite = function(_sprite = spr_bg_teste)
{
    //se não estou usando a sprite correta
    if(sprite_index != _sprite)
    { 
        //mudando a sprite.
        sprite_index = _sprite;
        
        //frame da animação.
        image_index = 0;
 
    }   
}

//estado do player parado.
estado_idle = function()
{
    //zerando as velocidades.
    if(bufferJ_timer_atual == 0) vsp = 0;
    hsp = 0;
    
    //usando método de controle.
    control();
    
    //colocando sprite idle do player.
    troca_sprite(spr_player_idle);
    
    //se eu estou me movendo,
    if(right xor left)
    {
      //mudo para o estado walk.
        estado = estado_walk;  
    }
    
    //se eu pulei,
    if(jump || bufferJ_timer_atual)
    { 
          
        //mudo para o estado de pulo.
        estado = estado_jump;
        
        //crio particula de pulo.
        instance_create_depth(x, y, depth - 1, obj_particula_pulo);
        
        //toco som de pulo.
        play(snt_pulo, 1, false);
        
        //colocando efeito de squash.
        squash(.5, 1.4);
    }
    
    //se eu não to no chão
    if(!chao)
    {
        //eu to pulando.
        estado = estado_jump;
    }
    
    //se eu apertar shift ou E
    if(morcedificar && morcego && voa)
    {
        //eu começo a me transformar em morcego
        estado = estado_transformando;
        
    }
    
}

//estado do player movendo.
estado_walk = function()
{
    
    //usando método de controle.
    control();
    
    //abrir a porta.
    abre_porta();
    
    //colocando sprite walk do player.
     troca_sprite(spr_player_walk);
    
    //se não estou movendo horizontalmente,
    if(hsp == 0)
    {
        //provavelmente estou parado.
        estado = estado_idle;
    }
    
    //se eu não estou no chão, estou pulando.
    if(!chao)
    {
        //pulando.
        estado = estado_jump;
    }
    
    //se eu pulei,
    if(jump)
    {
        //mudo para o estado de pulo.
        estado = estado_jump;
        
        //crio particula de pulo.
        instance_create_depth(x, y, depth - 1, obj_particula_pulo);
        
         //colocando efeito de squash.
        squash(.5, 1.4);
        
          //toco som de pulo.
        play(snt_pulo, 1, false);
    }
    
}

//estado do player pulando.
estado_jump = function()
{
    
    
    //usando método de controle.
    control();
    
    //coyote jump.
    if(coyoteJ_timer_atual && jump)
    {
        //subo.
        vsp -= max_vsp;
        
        //crio particulas.
        instance_create_depth(x, y, depth - 1, obj_particula_pulo);
        
         //colocando efeito de squash.
        squash(.5, 1.4);
        
          //toco som de pulo.
        play(snt_pulo, 1, false);
        
    }
    
    //fazendo player parar ao tocar no teto.
    var _level          = layer_tilemap_get_id("chao");
    var _level1         = layer_tilemap_get_id("chao_1");
    var _colisores      = [obj_wall, _level, _level1]
    
    //se eu tocar no teto.
    if(place_meeting(x, y + sin(vsp), _colisores))
    {
        //variável de controle para parar de subir.
        var _parar = true;
        
        //se a velocidade menor ou igual a 0;
        if(vsp < 0)
        {
            //se eu cheguei no limite de pixeis
            for(var i = 0; i < corner_pixels; i++;)
            {
                //eu continuo pulando//
                var _corner = !place_meeting(x + i, y + vsp, _colisores)
                
                //se eu bati no canto do teto.
                if(_corner)
                {
                   //pulo alguns pixels pro lado;
                   x += i;
                
                  //continuo subindo.
                   _parar = false;
                   
                   //paro a repetição; 
                   break;
                
                }
                
                //corner pra esquerda.
                for(var _i = 0; _i < corner_pixels; _i++;)
                {
                    var _corner2 = !place_meeting(x - _i, y + vsp, _colisores)
                    
                    if(_corner2)
                    {
                        x -= i;
                        
                        _parar = false;
                        
                        break;
                    }
                }
             
                
            }
        }
        
        //se eu toquei no teto, eu paro de subir.
        if(_parar = true) vsp = 0; 
    }
    
    
    //se minha velocidade vertical for menor que 0
    if(vsp < 0)
    {
        //estou pulando.
        troca_sprite(spr_player_jump_up)
        
        
        //checando se o valor está dentro do array.
        if(array_contains(colisores, obj_wall_one_way))
        {
            //achando o valor correto.
            var _ind = array_get_index(colisores,obj_wall_one_way);
            
            //deletando valor do array.
            array_delete(colisores, _ind, 1);
        }
        
        //controle do pulo.
        if(jump_r)
        {
            vsp *= .2;
        }
        
        
    }
    else//se não,
    {
        //estou caindo.
        troca_sprite(spr_player_jump_down);
        
        //se eu to caindo eu aumento a força da queda.
         forca += 0.5;
        
        //se eu não estou colidindo com a plataforma,
        if(!place_meeting(x, y, obj_wall_one_way))
        {
            //checando se o valor do colisor não estar no array.
            if(!array_contains(colisores, obj_wall_one_way))
            {
                //eu adiciono o colisor.
                array_push(colisores, obj_wall_one_way);
            }
        }
        
        
        //se minha animação acabou,
        if(troca_estado())
        {
            //fica apenas o ultimp frame.
            image_index = 2;
        }
        
    
    }
    
    //se eu toquei o chão,
    if(chao)
    {
        //criando particula.
         instance_create_depth(x, y, depth - 1, obj_particula_queda);
        
        //zero a velocidade horizontal.
        hsp = 0;
        
        ///colocando efeito squash.
        squash(1.2, .8)
        
        //fico parado.
        estado = estado_idle;
        
        //se minha força da queda for maior que 15,
        if(forca > 15)
        {
            //zero a força.
            forca = 0;
            
            //vou pra o estado de cair no chão.
            estado = estado_cair_chao;
        }
        else//se não,
        {
            //não tenho força.
            forca = 0; 
        }
        
    }
    
    
}

//estado de cair no chão.
estado_cair_chao = function()
{
    
    //mudando a sprite.
    troca_sprite(spr_player_cair_jump);
    
  
    //se minha animação acabou.
    if(troca_estado())
    {
        //volto para o estado idle.
        estado = estado_idle;
    }
    
}

//estado de pegar power up.
estado_PU_inicio = function()
{
    //zerando a velocidade.
    vsp = 0;
    hsp = 0;
    
    //mudando a sprite.
    troca_sprite(spr_player_pegando);
    
    //mudando o estado ao acabar a animação.
    if(troca_estado())
    {
        //mudando o estado.
        estado = estado_PU_meio;
    }
}

//estado segurando power up.
estado_PU_meio = function()
{
    //mudando a sprite.
    troca_sprite(spr_player_levantando);
    
   //se acabou as particulas.
    if(!instance_exists(obj_particula_power_up))
    {
        //mudo de estado.
        estado = estado_PU_fim;
    }
}

//estado voltando ao idle.
estado_PU_fim = function()
{
     //mudando a sprite.
    troca_sprite(spr_player_voltando)
    
    //voltando para o estado idle.
    if(troca_estado())
    {
        //idle.
        estado = estado_idle;
    }
           
}

//estado de transformando em morcego.
estado_transformando = function()
{
    
    //zerando a velocidade.
        hps = 0;
    
    //mudando a sprite.
    troca_sprite(spr_player_transformando);
    
    //mudando o estado ao acabar a animação.
    if(troca_estado())
    {
        //indo para a morcegação.
        estado = estado_morcegacao;
    }
}

//estado de morcedificação.
estado_morcegacao = function()
{
    //mudando a sprite.
    troca_sprite(spr_player_morcegando);
    
    //mudando o estado ao acabar a animação.
    if(troca_estado())
    {
        //indo para a morcegação.
        estado = estado_morcego;
        
        //tocando som.
        audio_play_sound(snt_morcego, 2, false, , , 0.9);
    }
}

//estado morcego.
estado_morcego = function()
{
    //mudando a sprite.
    troca_sprite(spr_player_morcego);
    
    control();
    
     //mudando a mascara de colisão.
     mask_index = spr_player_morcego;
    
    
    vsp = 0;
    
    //variável temporária de não tocar no chão.
    var _parar = !place_meeting(x + (hsp * 30), y + 1, morcegando)
    
    //se eu não to tocando no chão,
    if(_parar)
    {
        //fico parado.
        hsp = 0;
    }
    
    //se eu apertar shift ou E
    if(morcedificar)
    {
        //zero a velocidade horizontal.
        hsp = 0;
        
        //volto a se humano.
        estado = estado_desmorcegando;
    }
}

//estado desmorcedificação.
estado_desmorcegando = function()
{
     //mudando a sprite.
    troca_sprite(spr_player_desmorcegando);
    
    //voltando mascara de colisão.
    mask_index = spr_player_idle;
    
    //se eu apertar shift ou E
    if(troca_estado())
    {
        //volto a se humano.
        estado = estado_destransformando;
        
        //tocando som de desmorcegar.
        audio_play_sound(snt_desmorcegando, 2, false, , 1.60);
    }
}

//estado voltando para o idle.
estado_destransformando = function()
{
     //mudando a sprite.
    troca_sprite(spr_player_voltando_humano);
    
    
    //se eu apertar shift ou E
    if(troca_estado())
    {
        //volto a se humano.
        estado = estado_idle;
        
    }
    
}

//estado de preparar pulo
//estado_preparar_pulo = function()
//{
    //
    //vsp = 0;
    //hsp = 0;
    //
    //troca_sprite(spr_player_preparar_jump);
    //
    //if(troca_estado())
    //{
        //vsp += max_hsp;
        //estado = estado_jump;
    //}
//}
#endregion

//definindo estado inicial.
estado = estado_idle;