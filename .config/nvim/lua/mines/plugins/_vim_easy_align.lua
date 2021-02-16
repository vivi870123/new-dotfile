local M = {}

function M.setup()
  vim.g.easy_align_delimiters = {
    [';']  = { pattern = ';'        , left_margin = 0 },
    ['[']  = { pattern = '['        , left_margin = 1, right_margin = 0 },
    [']']  = { pattern = ']'        , left_margin = 0, right_margin = 1 },
    [',']  = { pattern = ','        , left_margin = 0, right_margin = 1 },
    [')']  = { pattern = ')'        , left_margin = 0, right_margin = 0 },
    ['(']  = { pattern = '('        , left_margin = 0, right_margin = 0 },
    ['=']  = { pattern = [[<\?=>\?]], left_margin = 1, right_margin = 1 },
    ['|']  = { pattern = [[|\?|]]   , left_margin = 1, right_margin = 1 },
    ['&']  = { pattern = [[&\?&]]   , left_margin = 1, right_margin = 1 },
    [':']  = { pattern = ':'        , left_margin = 1, right_margin = 1 },
    ['?']  = { pattern = '?'        , left_margin = 1, right_margin = 1 },
    ['<']  = { pattern = '<'        , left_margin = 1, right_margin = 0 },
    ['\\'] = { pattern = '\\'       , left_margin = 1, right_margin = 0 },
    ['+']  = { pattern = '+'        , left_margin = 1, right_margin = 1 }
  }
end

return M
