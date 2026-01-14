//ativando inputs.
input();

//ativando movimento.
movimento();

//ativando o não entra.
nao_entrar();

//ativando debug
ativa_debug();

//ativando escala.
escala();

//voltando a escala original.
re_squash();

//tira o brilho.
retorna_brilho();

//resetando a room.
var _reset = keyboard_check_pressed(ord("R"));

//se eu apertar r, eu reseto a room.
if(_reset) cria_transicao_inicia(room);
    

//ativando estados do player.
estado();

///debug///
///// mudar de cor///
//if(keyboard_check_pressed(ord("Z"))) 
//{
    //cria_transicao_inicia(level_1);
//}
//if(keyboard_check_pressed(ord("X"))) cor = c_blue;
//if(keyboard_check_pressed(ord("C"))) cor = c_green;
//if(keyboard_check_pressed(ord("V"))) cor = c_white;
//
/////mudando o alpha.
//if(keyboard_check_pressed(vk_enter)) coloca_brilho(); 
//


//se eu apertar f11
if(keyboard_check_pressed(vk_f11))
{
    ///deixo em tela cheia.///
    
    var _full = window_get_fullscreen();
    
    window_set_fullscreen(!_full);
}
