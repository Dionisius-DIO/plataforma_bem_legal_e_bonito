//texto do dialogo.
texto       = "TEXTO LEGAL :D";

//mostrar texto.
M_texto     = false;

//destruindo caixa.
destruir    = false;

//mechendinho
scribble_anim_wave(1, 0.05, 0.05);

scribble_anim_wobble(1, 1);

//digitando.
escrever    = scribble_typist();

escrever.in(.5, 0);

//método de fazer a caixa de dialogo.
inicia_caixa = function()
{
    //aumentando escala da caixa de dialogo.
    image_xscale = lerp(image_xscale, 5.5, 0.1);
    image_yscale = lerp(image_yscale, 2.5, 0.1);
    
    //subindo caixa de dialogo.
    y = lerp(y, ystart - 50, 0.1);
    
    //aparecendo o texto.
    if(y <= ystart - 48)
    {
        //apareço o texto.
        M_texto = true;
    }
    
}

//destruindo caixa de dialogo.
destroi_caixa = function()
{
    //diminuindo a escala da caixa de dialogo.
    image_xscale = lerp(image_xscale, -1, 0.15);
    image_yscale = lerp(image_yscale, -1, 0.15);
    
    //descendo caixa de dialogo.
    y = lerp(y, ystart, 0.5)
    
    //tirando o texto.
    M_texto = false;
    
    //posso me destuir de novo.
    destruir = false;
    
    //destruindo caixa de dialogo.
    if(image_yscale <= 0.5)
    {
        //destruindo.
        instance_destroy();
    }
}