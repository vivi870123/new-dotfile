" Functions
let s:float_default_width_ratio = 0.9
let s:float_default_height_ratio = 0.8
let s:float_default_width = float2nr(&columns * s:float_default_width_ratio)
let s:float_default_height = float2nr(&lines * s:float_default_height_ratio)
let s:float_default_ratio = [s:float_default_width_ratio, s:float_default_height_ratio]
let s:float_default_size = [s:float_default_width, s:float_default_height]

function! mines#float#get_default_size()
  return s:float_default_size
endfunction

function! mines#float#get_default_ratio()
  return s:float_default_ratio
endfunction

function! mines#float#calculate_pos(width, height)
  let col = (&columns - a:width) / 2
  let row = (&lines - a:height) / 2
  return [col, row]
endfunction

function! mines#float#calculate_pos_from_ratio(width_ratio, height_ratio)
  let col_ratio = (1 - a:width_ratio) / 2
  let row_ratio = (1 - a:height_ratio) / 2
  let col = float2nr(&columns * col_ratio)
  let row = float2nr(&lines * row_ratio)
  return [col, row]
endfunction
