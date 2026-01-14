//estados.
estado = "fechado";

///criando sistema de particula.///

//ps_chave
ps = part_system_create();
part_system_draw_order(ps, true);

//particula.
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_square);
part_type_size(ptype1, 0.1, 0.1, 0, 0);
part_type_scale(ptype1, 0.2, 0.2);
part_type_speed(ptype1, 1, 0.5, 0, 0);
part_type_direction(ptype1, 90, 90, 0, 0);
part_type_gravity(ptype1, 0, 65);
part_type_orientation(ptype1, 90, 270, 0, 0, false);
part_type_colour3(ptype1, $00D8FF, $0090FF, $00B2FF);
part_type_alpha3(ptype1, 1, 0.761, 0);
part_type_blend(ptype1, true);
part_type_life(ptype1, 15, 30);


//maquina de estado da porta.
stage_machine = function()
{
    //estados da porta.
    switch (estado)
    {
        //porta fechada.
    	case "fechado":
        {
            //tirando animação.
            image_speed = 0;
            
            var _x = x + random_range(sprite_width / 1.5, -sprite_width / 1.5);
            
            //colocando particula.
            part_particles_create(ps, _x, y, ptype1, 1);

        }
        break;
        
        //porta abrindo.
        case"abrindo":
        {
            //abrindo porta.
            image_speed = 1;
            
            //tremendo tela.
            tremer_tela(2);
            
            
            //tremendo portão.
            x = xstart + random_range(1, -1);
            
            //se minha animação acabou,
            if(image_index = 5)
            {
                //mudo o estado.
                estado = "aberto";
                
                //voltando a posição x original.
                x = xstart;
                
                alarm[0] = FPS;
                
            }
            
        }
        break;
    
        //porta fechando.
        case"aberto":
        {
            //tiro a colisão.
            mask_index = spr_portao_levantado;   
            
        }
    }
}