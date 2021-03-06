local function makeFont(path)
    return setmetatable(
        {},
        {
            __index = function(t, size)
                local f = love.graphics.newFont(path, size)
                rawset(t, size, f)
                return f
            end
        }
    )
end

local fonts = {
    default = nil,
    monospace = makeFont "assets/fonts/ff3.ttf"
}

fonts.default = fonts.monospace

return fonts
