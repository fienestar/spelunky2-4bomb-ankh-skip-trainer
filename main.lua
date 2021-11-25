meta.name = '4bomb-ankh-skip-trainer'
meta.version = '0.1'
meta.description = 'indicate good position for 4bomb ankh skip'
meta.author = 'fienestar'

function is_good_position(uid)
  local x, y, l = get_position(uid)
  if not (81 <= y and y <= 82 and l == 0) then
    return false
  end

  if entity_has_item_type(uid, ENT_TYPE.ITEM_POWERUP_PITCHERSMITT) then
    return 22.233 <= x and x <= 22.36
  else
    return 21.79 <= x and x <= 21.90
  end
end

function tint_entity(uid, r, g, b)
  local entity = get_entity(uid)
  if not entity then return end

  entity.color.r = r
  entity.color.g = g
  entity.color.b = b
end

function is_ankh_skip_needed(state)
  return state.theme == THEME.TIDE_POOL and state.world == 4 and state.level == 3
end

set_callback(function ()
  if is_ankh_skip_needed(state) then
    if is_good_position(players[1].uid) then
      tint_entity(players[1].uid, 0.1, 0.9, 0.1)
    else
      tint_entity(players[1].uid, 1, 1, 1)
    end
  end
end, ON.FRAME)