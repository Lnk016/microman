VERSION = "1.0.1"

local micro  = import("micro")
local config = import("micro/config")
local shell  = import("micro/shell")
local buffer = import("micro/buffer")

function init()
    config.MakeCommand("man", manCommand, config.NoComplete)
end

function manCommand(bp, args)
    if #args == 0 then
        micro.InfoBar():Error("Usage: man <command>")
        return
    end

    local topic = args[1]
    for i = 2, #args do
        topic = topic .. " " .. args[i]
    end

    local view = bp:GetView()
    local width = view.Width - 5
    if width < 40 then
        width = 40
    end

    local cmd = string.format(
        "MANWIDTH=%d MANPAGER=cat man %s | col -bx",
        width,
        topic
    )

    local out, err = shell.ExecCommand("sh", "-c", cmd)

    if err ~= nil or out == "" then
        micro.InfoBar():Error("No manual entry for " .. topic)
        return
    end

    local buf = buffer.NewBuffer(out, "man:" .. topic)
    buf:SetOption("readonly", "true")
    buf:SetOption("modifiable", "false")

    bp:NewTabCmd({})
    micro.CurPane():OpenBuffer(buf)
end
