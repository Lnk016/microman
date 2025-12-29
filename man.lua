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

    local topic = ""
    for i = 1, #args do
        if i > 1 then topic = topic .. " " end
        topic = topic .. args[i]
    end

    local out, err = shell.ExecCommand(
        "sh",
        "-c",
        "MANPAGER=cat man " .. topic .. " | col -bx"
    )

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
