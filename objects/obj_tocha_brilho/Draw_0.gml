//fazendo brilho mexer
var _esc = random_range(0.87, 0.9);

//deixando o brilho brilhoso.
gpu_set_blendmode(bm_add);

//desenhando brilho
draw_sprite_ext(spr_brilho, 0, x, y, 0.8 * _esc , 0.8 * _esc, image_angle, image_blend, 0.3);

//reset.
gpu_set_blendmode(bm_normal);