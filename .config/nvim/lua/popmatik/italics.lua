local M = {}

-- Allowed highlight keys (only these can be passed to nvim_set_hl)
local allowed_keys = {
  'fg',
  'bg',
  'sp',
  'bold',
  'standout',
  'underline',
  'undercurl',
  'underdouble',
  'underdotted',
  'underdashed',
  'strikethrough',
  'italic',
  'reverse',
  'nocombine',
  'default',
  'link',
  'blend',
}

local function italicize(group)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  local cleaned = {}

  for _, key in ipairs(allowed_keys) do
    if hl[key] ~= nil then
      cleaned[key] = hl[key]
    end
  end

  cleaned.italic = true -- force italics on
  vim.api.nvim_set_hl(0, group, cleaned)
end

function M.apply()
  -- Standard function highlight groups
  italicize '@function'
  italicize '@function.call'
  italicize 'Function'
  italicize '@method'
  italicize '@variable.function'

  -- TypeScript/React specific highlight groups
  italicize '@function.call.tsx'
  italicize '@function.tsx'
  italicize '@method.tsx'
  italicize '@constructor.tsx' -- For React components
  italicize '@variable.function.tsx'

  -- TypeScript specific highlight groups
  italicize '@function.typescript'
  italicize '@method.typescript'
  italicize '@variable.function.typescript'

  -- JSX/TSX specific highlight groups
  italicize '@jsx.element'
  italicize '@jsx.component'
  italicize '@tsx.element'
  italicize '@tsx.component'

  -- React component highlight groups
  italicize '@tag.attribute.tsx' -- For JSX/TSX attributes
  italicize '@tag.tsx' -- For JSX/TSX tags
  italicize '@tag.delimiter.tsx' -- For JSX/TSX tag delimiters
end

return M
