//me destruo.
instance_destroy();

//ganho uma chave.
other.pega_chave();

//criando particula de pegar.
var _ps = part_system_create(ps_pegar_chave);

part_system_position(_ps, x, y);

//tocando som.
play(snt_chave, 2, false);

