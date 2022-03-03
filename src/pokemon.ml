
type p_types =  Normal | Fire | Water | Grass | Electric | Ice | Fighting | Poison | Ground | Flying | Psychic | Bug | Rock | Ghost | Dark | Dragon | Steel | Fairy 

type p_moves = { move_name: string; damage: int; move_type : p_type; accuracy: int}

type t = { p_id: int; p_name: string; p_type: p_type; pokemon moves: p_moves list }

