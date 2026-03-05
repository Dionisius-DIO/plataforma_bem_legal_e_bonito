//draw_text(x,y,string(estado))

//desenhando sprite.
draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, image_blend, image_alpha);

//desenhando brilho.
desenha_efeito();

//draw_text(x, y, bufferJ_timer_atual);

//mostrando a mascara de colisão.
//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true);