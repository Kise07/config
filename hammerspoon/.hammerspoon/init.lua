-- ============================================
-- Hammerspoon config: focus switching between
-- MacBook display and external monitor.
-- Raycast handles window tiling/moving; this
-- only handles which screen's app is active.
-- ============================================

local mods = { "alt" }

-- Move the pointer to the center of a window
local function movePointerToWindow(win)
    local f = win:frame()
    hs.mouse.setAbsolutePosition(
        hs.geometry.point(f.x + f.w / 2, f.y + f.h / 2)
    )
end

-- Jump to the display in the given direction
-- ("right" / "left"), focusing its frontmost
-- window and moving the pointer there.
local function jumpToOtherDisplay(direction)
    local cur = hs.mouse.getCurrentScreen()
    if not cur then return end

    local screens = hs.screen.allScreens()
    if #screens < 2 then
        hs.alert.show("Only one display connected")
        return
    end

    local curFrame = cur:frame()
    local candidates = {}
    for _, s in ipairs(screens) do
        if s ~= cur then
            local f = s:frame()
            if direction == "right" and f.x > curFrame.x + 1 then
                candidates[#candidates + 1] = s
            elseif direction == "left" and f.x + f.w < curFrame.x - 1 then
                candidates[#candidates + 1] = s
            end
        end
    end

    local target
    if #candidates == 0 then
        -- nothing in that direction: fall back to any other screen
        for _, s in ipairs(screens) do
            if s ~= cur then target = s break end
        end
    else
        table.sort(candidates, function(a, b) return a:frame().x < b:frame().x end)
        if direction == "right" then
            target = candidates[1]
        else
            target = candidates[#candidates]
        end
    end
    if not target then return end

    -- frontmost window on the target screen
    local win
    for _, w in ipairs(hs.window.orderedWindows()) do
        if w:screen() == target then
            win = w
            break
        end
    end

    if win then
        win:focus()
        movePointerToWindow(win)
    else
        hs.mouse.setAbsolutePosition(target:center())
    end
end

-- Mouse follows focus: when the active window
-- changes, move the pointer into it so the
-- pointer never lags behind what you use.
local mouseFollowsFocus = true

local function applyMouseFollow(win)
    if mouseFollowsFocus and win then
        movePointerToWindow(win)
    end
end

hs.window.filter.default:subscribe(
    hs.window.filter.windowFocused,
    applyMouseFollow
)

local function toggleMouseFollow()
    mouseFollowsFocus = not mouseFollowsFocus
    hs.alert.show("Mouse-follow-focus: " .. (mouseFollowsFocus and "ON" or "OFF"))
end

hs.hotkey.bind(mods, "right", function() jumpToOtherDisplay("right") end)
hs.hotkey.bind(mods, "left", function() jumpToOtherDisplay("left") end)
hs.hotkey.bind({ "alt" }, "m", toggleMouseFollow)

hs.alert.show("Hammerspoon loaded — ⌥← / ⌥→ switch display, ⌥M toggles mouse-follow")
