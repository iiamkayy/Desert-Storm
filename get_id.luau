-- Your GitHub get_id.luau file
local ids = {
    ["logo"] = 80184907652793, -- PUT YOUR REAL ROBLOX IMAGE ID HERE
    ["close"] = 80184907652793 -- PUT YOUR CLOSE BUTTON IMAGE ID HERE (optional)
}

-- Return a function that the main script can call
return function(name)
    return ids[name]
end
