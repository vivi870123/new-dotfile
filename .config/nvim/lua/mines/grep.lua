local nvim = mines.nvim
local echoerr = mines.util.messages.echoerr
local clear_lst = mines.util.tables.clear_lst


if not nvim.has('nvim-0.5') then
  return nil
end

_G.Grep = {}

local grepjobs = {}

local function on_data(id, data, event)
  if data ~= nil and #data > 0 then
    vim.list_extend(grepjobs[id].data, clear_lst(data))
  end
end

local function on_exit(id, exit_code, event)
  local search = grepjobs[id].search
  if type(search) == 'table' then
    search = vim.fn.join(search, ' ')
  end

  local lines = clear_lst(grepjobs[id].data)

  if exit_code == 0 then

    vim.fn.setqflist(
      {}, 'r', {
        contex = 'AsyncGrep',
        efm = grepjobs[id].format,
        lines = lines,
        title = 'Grep '.. search,
      })

    if vim.fn.getcwd() == grepjobs[id].cwd then
      local orientation = vim.o.splitbelow and 'botright' or 'topleft'
      nvim.command(orientation .. ' copen')
    else
      print('Grep '.. search .. ' finished')
    end

  elseif exit_code == 1 then
    vim.fn.setqflist(
      {}, 'r', {
        contex = 'AsyncGrep',
        title = 'No results for '.. search,
      })
    echoerr('No results for '.. search)
  else
    vim.fn.setqflist(
      {}, 'r', {
        contex = 'AsyncGrep',
        efm = grepjobs[id].format,
        lines = grepjobs[id].data,
        title = 'Error, Grep '.. search ..' exited with '..exit_code,
      })
    echoerr('Grep exited with '..exit_code)
  end
end

function _G.Grep.QueueJob(...)
  local cmd = vim.bo.grepprg or vim.o.grepprg

  local cwd = vim.fn.getcwd()
  local format = vim.o.grepformat

  for id, job in pairs(grepjobs) do
    if job['cwd'] == cwd then
      vim.fn.jobstop(id)
    end
  end

  local args = {...}
  local flags = {}
  local search = {}

  local quoute = false
  for i=1, #args do
    local arg = args[i]
    if arg:sub(1, 1) == '-' and quoute == false then
      flags[#flags + 1] = arg
    else
      if arg:sub(1, 1) == "'" or arg:sub(1, 1) == '"' then
        quoute = true
      else
        quoute = false
      end
      search[#search + 1] = arg
    end
  end

  cmd = vim.split(cmd, ' ')
  local prg = cmd[1]

  table.remove(cmd, 1)

  vim.list_extend(flags, cmd)

  flags = clear_lst(flags)

  local job = {prg}

  vim.list_extend(job, flags)
  vim.list_extend(job, search)

  job = clear_lst(job)

  local id = vim.fn.jobstart(
    job, {
      cwd = cwd,
      on_stdout = on_data,
      on_stderr = on_data,
      on_exit   = on_exit,
    })

  grepjobs[id] = {
    id = id,
    cmd = prg,
    flags = flags,
    search = search,
    format = format,
    data = {},
    cwd = cwd,
  }
end

nvim.commands.set_command{
  lhs = 'Grep',
  rhs = 'call v:lua.Grep.QueueJob(<f-args>)',
  args = {nargs = '+', force = true}
}

return grepjobs
