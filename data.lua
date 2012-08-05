require("TSerial")

function loadSettings()
	if love.filesystem.exists("settings") then
		local data = love.filesystem.read("settings")
		local set = TSerial.unpack(data)
		setScale(set.scale)
		SCROLL_SPEED = set.scroll_speed
	else
		setScale(3)
		SCROLL_SPEED = 5 -- 3 to 8 = smooth, 9 = none
	end
end

function saveSettings()
	local set = {}
	set.scale = SCALE
	set.scroll_speed = SCROLL_SPEED

	local data = TSerial.pack(set)
	love.filesystem.write("settings", data)
end

function loadData()
	if love.filesystem.exists("status") then
		local data = love.filesystem.read("status")
		local set = TSerial.unpack(data)

		unlocked = set.unlocked
		deaths = set.deaths
		level_status = set.level_status
	else
		unlocked = 1
		deaths = 0

		level_status = {}
		for i=1,9 do
			level_status[i] = {}
			level_status[i].coins = 0
			level_status[i].deaths = nil
			level_status[i].time = nil
		end
	end
end

function saveData()
	local set = {}
	set.unlocked = unlocked
	set.deaths = deaths
	set.level_status = level_status

	local data = TSerial.pack(set)
	love.filesystem.write("status", data)
end

function levelCompleted()
	if current_map <= 8 then
		unlocked = math.max(unlocked, current_map+1)
	end

	level_status[current_map].coins = math.max(level_status[current_map].coins, map.numcoins)
	if level_status[current_map].deaths == nil then
		level_status[current_map].deaths = map.deaths
	else
		level_status[current_map].deaths = math.min(level_status[current_map].deaths, map.deaths)
	end

	saveData()
	gamestate = STATE_LEVEL_MENU
end