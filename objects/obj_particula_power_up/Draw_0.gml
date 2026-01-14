gpu_set_blendmode(bm_add);

draw_sprite_ext(spr_brilho, image_index, x, y, 0.08, 0.08, image_angle, c_red, 0.7);

draw_self();

gpu_set_blendmode(bm_normal);
