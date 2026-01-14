
function iniciar_squash()
{
	//escala x e y.
	xscale = 1;
	yscale = 1;
}
#region squish
function squash(_xscale = 0.7, _yscale = 1.7)
{
	//colocando escalas
	xscale = _xscale;
	yscale = _yscale;
}

function re_squash(_qnt = 1, _temp  = 0.1)
{
	//voltando a escala originals
	xscale = lerp(xscale, _qnt, _temp);
	yscale = lerp(yscale, _qnt, _temp);
}

function coloc_squash()
{
	//desenhando o squish.
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}
#endregion