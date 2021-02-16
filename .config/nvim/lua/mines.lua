-- Global api

local api_paths = {
  ansi            = 'mines/ansi';
  buf             = 'mines/buffers';
  diagnostics     = 'mines/diagnostics';
  files           = 'mines/files';
  fzf             = 'mines/fzf';
  git             = 'mines/git';
  grep            = 'mines/grep';
  qf              = 'mines/quickfix';
  selfunc         = 'mines/selfunc';
  term            = 'mines/terminal';
  wk              = 'mines/which_key';
  window          = 'mines/window';

  sys		  = 'mines/system/init';

  fn              = 'mines/util';
  fs              = 'mines/util/fs';
  helper    	  = 'mines/util/helper';
  mappings        = 'mines/util/mappings';
  nvim		  = 'mines/util/nvim';
  project         = 'mines/util/project';
  rx = {
    observable    = 'mines/util/observable';
    subscriber    = 'mines/util/subscriber';
    subscription  = 'mines/util/subscription';
  };
  util = {
    funcref       = 'mines/util/funcref';
    jobs          = 'mines/util/jobs';
    unique_id     = 'mines/util/unique_id';

    buffers       = 'mines/util/buffers';
    files         = 'mines/util/files';
    messages      = 'mines/util/messages';
    strings       = 'mines/util/strings';
    tables        = 'mines/util/tables';
  };
}

local function setup_lookup_table(tbl, api, path)
  setmetatable(tbl, {
    __index = function(tbl, key)
      local api_path = api[key]
      local existing_api = rawget(tbl, key)

      if existing_api then return existing_api end

      if type(api_path) == 'table' then
        -- If a list then merge all modules into a single api
        if vim.tbl_islist(api_path) then
          local result = {}

          for _,path in ipairs(api_path) do
            result = vim.tbl_extend('force', result, require(path))
          end

          rawset(tbl, key, result)

          return result
        -- If a table then return the namespace that can lazily be looked up
        else
          local sub = {}

          rawset(tbl, key, sub)

          return setup_lookup_table(sub, api_path, path .. '.' .. key)
        end
      -- If a string then import that module
      elseif type(api_path) == 'string' then
        rawset(tbl, key, require(api_path))

        return rawget(tbl, key)
      else
        error("Could not find mines API path " .. path .. '.' .. key)
      end
    end
  })

  return tbl
end

-- Everything is exposed, lazily, as `mines`
mines = {
  -- Shorthand for commands
  command = vim.api.nvim_command;
  -- Easy way to expose nvim commands
  ex = setmetatable({}, {
    __index = function(tbl, key)
      local existing = rawget(tbl, key)

      if existing then return existing end

      local fn = function(...)
        local cmd = key

        for i = 1, select("#", ...) do
          cmd = cmd .. " " .. select(i, ...)
        end

        return vim.cmd(cmd)
      end

      rawset(tbl, key, fn)

      return fn
    end
  })
}

setup_lookup_table(mines, api_paths, 'mines')
