local M = {}

-- Name des Output-Buffers
local OUTPUT_BUF_NAME = "LuaRunnerOutput"

-- finde existierenden Output-Buffer oder erstelle ihn
local function get_output_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match(OUTPUT_BUF_NAME .. "$") then
        return buf
      end
    end
  end

  -- neuen Buffer erstellen
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, OUTPUT_BUF_NAME)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "lua"

  return buf
end

-- öffne Window für Output-Buffer (oder nutze vorhandenes)
local function open_output_window(buf)
  -- prüfen ob Buffer bereits sichtbar ist
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- sonst neues Split-Window
  vim.cmd("botright split")
  vim.api.nvim_win_set_buf(0, buf)
end

function M.run_current_buffer()
  -- nur Lua ausführen
  if vim.bo.filetype ~= "lua" then
    vim.notify("Kein Lua-Buffer", vim.log.levels.WARN)
    return
  end

  -- aktuellen Buffer speichern
  vim.cmd("write")

  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Buffer muss gespeichert sein", vim.log.levels.ERROR)
    return
  end

  local output_buf = get_output_buf()
  open_output_window(output_buf)

  -- Buffer leeren
  vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})

  -- Lua ausführen
  vim.system({ "lua", file }, { text = true }, function(result)
    vim.schedule(function()
      local lines = {}

      if result.stdout and result.stdout ~= "" then
        for line in result.stdout:gmatch("[^\n]+") do
          table.insert(lines, line)
        end
      end

      if result.stderr and result.stderr ~= "" then
        table.insert(lines, "")
        table.insert(lines, "stderr:")
        for line in result.stderr:gmatch("[^\n]+") do
          table.insert(lines, line)
        end
      end

      if #lines == 0 then
        lines = { "[kein Output]" }
      end

      vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, lines)
    end)
  end)
end

return M
