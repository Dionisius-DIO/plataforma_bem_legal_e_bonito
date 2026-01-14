//se eu tenho alvo.
if(alvo && voltar == false)
{
    //aumento a escala
    image_xscale += 0.01;
    image_yscale += 0.01;
    
    
    if(image_xscale >= 1.5 && image_yscale = 1.5)
    {  
          voltar = true;
    }
}

if(voltar == true)
{
    image_xscale = lerp(image_xscale, 0, 0.09);
    image_yscale = lerp(image_xscale, 0, 0.09);
    
    if(image_xscale <= 0)
    {
        instance_destroy();
    }
}