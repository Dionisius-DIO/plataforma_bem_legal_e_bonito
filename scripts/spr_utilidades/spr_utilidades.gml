///modo debug
#macro DEBUG_MODE 0 

#macro normal_mode:DEBUG_MODE 0
#macro debug_mode:DEBUG_MODE 1

//contantes.
#macro FPS game_get_speed(gamespeed_fps) 

 


//ativar debug
global.debug = 0;

#region funções

//aumenta tela
function aumenta_tela()
{
    
    //se eu apertar f11
    if(keyboard_check_pressed(vk_f11))
    {
        ///deixo em tela cheia.///
        
        var _full = window_get_fullscreen();
        
        window_set_fullscreen(!_full);
    }
    
}

//tocar sons e musicas.

function play(_som = snt_chave, _prior = 1, _loop = false)
{
    //tocando musica.
    audio_play_sound(_som, _prior, _loop);
}


#endregion

