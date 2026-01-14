//me desenhando.
draw_self();

if(!M_texto) exit;

//colocando fonte.
//draw_set_font(fnt_dialogo);

//alinhando o texto.
//draw_set_valign(0);
//draw_set_halign(0);

//colocando magem
var _margem = 1;

//posicionando corretamente
var _x = x - sprite_width/2 + _margem;
var _y = y - sprite_height/2 + _margem + 2;

//colocando texto.
//draw_text_transformed(_x, y + _margem, texto, 0.05, 0.05, 0);

//criando texto.
var _txt = scribble(texto).starting_format("fnt_dialogo",c_white);

//colocando escala certa do texto.
_txt.scale(0.078);

//colocando quebras no texto.
_txt.wrap(sprite_width + _margem * 2);

//desenhando o texto.
_txt.draw(_x, _y, escrever);

//espaçamento das linhas.
_txt.line_spacing(6);


//resetando.
draw_set_font(-1);
//draw_set_valign(-1);
//draw_set_halign(-1);