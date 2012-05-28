quads = {}

local lg = love.graphics

function loadImages()
	imgPlayer = lg.newImage("art/player.png")
end

function createQuads()
	quads.player = lg.newQuad(0,0,13,20,128,128)
	quads.player_wall = lg.newQuad(16,0,13,19,128,128)

	quads.player_run = {}
	for i = 0,5 do
		quads.player_run[i] = lg.newQuad(i*16, 32, 13, 20, 128, 128)
	end
end
