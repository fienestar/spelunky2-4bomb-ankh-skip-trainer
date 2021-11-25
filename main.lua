meta.name = '4bomb-ankh-skip-trainer'
meta.version = '0.3'
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
  return #players ~= 0 and state.theme == THEME.TIDE_POOL and state.world == 4 and state.level == 3
end

player_uid = -1
update_tints_cb_id = nil

function update_tints()
  if is_good_position(player_uid) then
    tint_entity(player_uid, 0.1, 0.9, 0.1)
  else
    tint_entity(player_uid, 1, 1, 1)
  end
end

function clear_update_tints()
  if update_tints_cb_id ~= nil then
    clear_callback(update_tints_cb_id)
    update_tints_cb_id = nil
  end
end

set_callback(clear_update_tints, ON.DEATH)
set_callback(clear_update_tints, ON.WIN)

set_callback(function()
  clear_update_tints()
  if is_ankh_skip_needed(state) then
    if #players > 1 then
      player_uid = state.camera.focused_entity_uid
    else
      player_uid = players[1].uid
    end

    update_tints_cb_id = set_callback(update_tints, ON.FRAME)
  end
end, ON.LEVEL)
