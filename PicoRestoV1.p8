pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--global

function _init()
    create_player()
    create_frigo()
    create_client()
end

function _update()
    chef_movement()
    timer_count()
    client_move()
end

function _draw()
    draw_map()
    draw_frigo()
    draw_player()
    draw_ingredient()
    draw_caisse()
    draw_timer()
    draw_preparation()
    draw_client()
end
-->8
--gameplay chef
function create_player()
    chef = { 
    x = 9, 
    y = 7, 
    sprite = 128,
    tomate = 0,
    salade =0,
    steak = 0,
    pain = 0,
    }
end

function chef_movement()
    newx = chef.x
    newy = chef.y
    
    if btnp(➡️) then
    newx+=1
    chef.sprite=130 
				end
 
				if btnp(⬅️) then
    newx-=1
    chef.sprite=128    
				end

--chef de dos / face au frigo			
				if (chef.x == 5 or chef.x == 4) 
				and chef.y == 7
				and btn(⬆️)	
				then
				frigo.sprite = 18
				chef.sprite = 132
				end
				

--prise des ingredients	
				if chef.x == 3 
				and chef.y == 7
				and btnp(⬇️)	
				then
				chef.tomate += 1
				end
				
				if chef.x == 5
				and chef.y == 7
				and btnp(⬇️) 
				then
				chef.salade += 1
				end
				
				if chef.x == 7
				and chef.y == 7
				and btnp(⬇️)
				then 
				chef.steak += 1
				end
				
				if chef.x == 9
				and chef.y == 7
				and btnp (⬇️)
				then
				chef.pain +=1
				end

    if check_flag(0, newx, newy) then
    else
        chef.x = newx
        chef.y = newy
    end
end
function draw_player()
    spr(chef.sprite, chef.x*8, chef.y*8, 2, 2)
end
-->8
--foodtruck

function draw_map()
				cls()
    map(0, 0, 0, 0)
end

function check_flag(flag, x, y)
    local sprite = mget(x, y)
    return fget(sprite, flag)
end


function draw_caisse()
 spr(102,88,56,2,2)

end

--definit le frigo
function create_frigo()
frigo = { 
x =4,
y =7,
sprite = 16,
}
end

--le fait apparaitre sur la map
function draw_frigo()
spr(frigo.sprite,frigo.x*8,frigo.y*8,2,2)
end

--afficher les ingredients
--au premier plan
function draw_preparation()
spr(226,24,72)
spr(226,32,72)
spr(227,40,72)
spr(227,48,72)
spr(228,56,72)
spr(228,64,72)
spr(229,72,72)
spr(229,80,72)
end
-->8
--inventaire

function draw_ingredient()
 spr(226,2,2)
 print("X" .. chef.tomate,11,5)
 
 spr(227,19,2)
 print("X" .. chef.salade,28,5)
 
 spr(228,36,2)
 print("X" .. chef.steak,45,5)
 
 spr(229,53,2)
 print("X" .. chef.pain,62,5)
end
-->8
--timer et argent

timer = 60
counter = 0

function timer_count()
	counter = 1/30 --30 car 30fps
	timer -= counter 
end

function draw_timer()
	local timer_formate = flr(timer)
 print("time   " .. timer_formate,80,5)
end


-->8
--gameplay client

function create_client()
client = {
x=0,
y=11,
sprite=192
}

end

function draw_client()
spr(client.sprite, client.x*8, client.y*8, 2, 2)
end

function client_move() 
client.x+=0.1
if check_flag(1,client.x,client.y) 
then client.x=3
end
end
__gfx__
77777777777777777777777777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76777777777766777677777777776677000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76677777777766777667777777776677000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76667777777777777666777777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76676777777777777667677777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76677677777777777667767777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76677766777555777667776677755577000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666755555777666666675555577000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777dd8868868868867000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
767777777777557775d8868868868867000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
767777777777557775d88d88d88d88d7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
767777777777557775d6777766666667000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
767777777777757775d8868868868867000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
767777777777757775d8868868868867000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
767777777777767775d88d88d88d88d7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76777777777776777dd6777766666667000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76777777777777777d58868868868867000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76677777777777777d58868868868867000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76667777777777777d588d88d88d88d7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666777777777777dd6667666666767000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666677777776777dd66766ddd67667000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666777dd6766666676667000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666777dd7666666766667000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777755555555555557000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00499999000000003349999999999999999994000000000000000000999994330009994099994333999999999999999999988887778887778877778887778877
00499999000044443349999999999999999994004444444444400000999994330000994499942323999999999999999999888877788877778887778887778887
00499999000499993349999999999999999994009999999999940000999994330000999999427872999955555599999999888777888877788887778888777888
00499999000499993349999999999999999994009999999999940000999994330000099994338a83999555555555999998888777888777788887777888777788
0049999900499999334499999b99999999999400999999999aa94000999944330000000043327872995555000555599998887777888777788888777888777788
00499999004999993334444444b444449999940099999999aaaa4000999943330000000033332b2b955550050055559988887777888777888888777788877778
00499999004999993333333333b333b39999940099999999aa7a9400999943330000000033333bb3955505555505559988887777888777888888777788887778
00499999004999993333333333333b339999940099999999aa7a9400999943330000000033333b33955055665550559988877778887778888888877788887777
778999999999940000499999999ff4449999999944444444444ff99999940000000049990000000095505556655055999994444444444999aaaa940000000000
7778999999999400004999994fff444499999999444444444444fff499940000000049990000000095505555555055999994444444444999aaaa940000000000
8778899999999400004999999999999999999999999999999999999999940000000049990000000095505556555055999994444444444999aa8a940000000000
8777889999999400004999999999999999999999999999999999999999940000000049990000000095550565550055b999944444444449999aa9940000000000
88778889999994000049999999999999999999999999999999999999999400000000499900000000bb55055555055bb999944444444449999999940000000000
887777888999940000499998999999999999999999999999999999999994000000004999000000004b55505550055b4499944444444449999999940000000000
888777788899940000499988999999999999999999999999999999999994000000004999000000003b3555000055bb3399955444444559999999940000000000
888877788889940000499888999aaaaa99999999aaaaaaaaaaaaa999999400000000499900000000333355555553333399955554455559999999940000000000
51111111555555555555555566666666000000000000000000000000000000000000000044444444777777777777777799999999999999990000000000000000
511111111111111511111111666666660000000000000000000000000000000000000000f44444ff767777777777777799999999999999994440000000000000
51111111111111151111111166666666000000000000000000000000555555550000000044444444766777777766777799999999999999999994000000000000
511111111111111511111111666666660000000000000000000000005555555500000000fff44ff4766677777766777799999999999999999994000000000000
5111111111111115111111116666666600000000000000000000000055333355000000004444444476676777777777779999999999aaaa999999400000000000
51111111111111151111111166666666000000000000000000000000553333550000000044fff444766776777777777799999999999999999999400000000000
555555551111111511111111000000000000000000000000000000005555555500000000444444ff7667776677755577aaaaaaaaaaaaaaaa9999940000000000
00000000111111151111111100000000000000000000000000000000555555550000000044444444766666667555557799999999999999999999940000000000
55555555111111151111111166656666666566666665666600000000000055000000000044444444767777777777777777777777777777770000000000000000
51111111111111151111111166656666666d66666665666600000000000055000000000056555565766777777777777776777777777777770000000000000000
51111111111111151111111166555666666566666665666600005555555555000000000066666666766677777777777776777777777777770000000000000000
51111111111111151111111166565666665556666665566600005555555555000000000056555565766667777777777776777777777777770000000000000000
511111111111111511111111665656666d65656666655666005566886666dd550000000056555565766666777777767776777777777776770000000000000000
51111111111111151111111166d65666656565666665d666005566886666dd550000000066666666766666666666667776777777777776770000000000000000
51111111555555555555555500505000050505000005500055555555555555550000000056555565766666666666667776777777777776770000000000000000
51111111000000000000000000000000000000000005000055555555555555550000000056555565777777777777777776777777777776770000000000000000
000eeeeeeeeee000000eeeeeeeeee000000eeeeeeeeee00000022222222220000002222222222000000222222222200000022222222220000002222222222000
000eeeeeeeeee000000eeeeeeeeee000000eeeeeeeeee00000022222222220000002222222222000000222222222200000052525252526000062525252525000
000ffffffffee000000eeefffffff000000eeeeeeeeee0000004444444422000000222444444400000022222222220000005d5d5d5d5660000665d5d5d5d5000
000ffffffffff000000ffffffffff000000eeeeeeeeee000000444444444400000044444444440000002222222222000000dddddddddd600006dddddddddd000
000f4fff4fffff0000fffff4fff4f00000feeeeeeeeeef00000404440444440000444440444040000042222222222400000dbdddbddddd0000dddddbdddbd000
000fffffffffff0000fffffffffff00000feeeeeeeeeef00000444444444440000444444444440000042222222222400000ddddddddddd0000ddddddddddd000
000ffffffffffa0000affffffffff00000affffffffffa00000444444444400000a44444444440000004444444444a00000dddddddddd000000dddddddddd000
000ffffffffff000000ffffffffff000000ffffffffff000000444444444400000044444444440000004444444444000000dddddddddd000000dddddddddd000
00008888888800000000888888880000000ffffffffff00000003333333300000000333333330000000444444444400000005555555500000000555555550000
00008888888800000000888888880000000088888888000000003333333300000000333333330000000033333333000000005555555500000000555555550000
08878888888878800887888888887880088788888888788003373333333373300337333333337330033733333333733005575555555575500557555555557550
08877777777778800887777777777880088788888888788003377777777773300337777777777330033733333333733005577777777775500557777777777550
088777d77d777880088777d77d7778800887888888887880033777877877733003377787787773300337333333337330055777a77a777550055777a77a777550
088777dddd777880088777dddd7778800887888888887880033777888877733003377788887773300337333333337330055777aaaa777550055777aaaa777550
f88777dddd7f88800888f7dddd77788f0887888888887880433777888874333003334788887773340337333333337330d55777aaaa7d55500555d7aaaa77755d
f8877777777f88800888f7777777788f0887777777777880433777777774333003334777777773340337777777777330d5577777777d55500555d7777777755d
00022222222220000900000000000090090000000000009009000000000000900300000000000030030000000000003003000000000000300000000000000000
00652525252526000808888888888080088000000000088008088888888880800b0bbbbbbbbbb0b00b0bbbbbbbbbb0b00b0bbbbbbbbbb0b00000000000000000
006625252525660000888888888888000888888888888880008888888888880000bbbbbbbbbbbb0000bbbbbbbbbbbb0000bbbbbbbbbbbb000000000000000000
0062222222222600000888888888800000088888888880000008888888888000000bbbbbbbbbb000000bbbbbbbbbb000000bbbbbbbbbb0000000000000000000
00d2222222222d00000898889888880000088889888980000088888888888800000babbbabbbbb0000bbbbbabbbab00000bbbbbbbbbbbb000000000000000000
00d2222222222d00000888888888880000088888888880000088888888888800000bbbbbbbbbbb0000bbbbbbbbbbb00000bbbbbbbbbbbb000000000000000000
000dddddddddd000000888888888800000088888888880000008888888888000000bbbbbbbbbb000000bbbbbbbbbb000000bbbbbbbbbb0000000000000000000
000dddddddddd000000888888888800000088888888880000008888888888000000bbbbbbbbbb000000bbbbbbbbbb000000bbbbbbbbbb0000000000000000000
000dddddddddd0000000888888880000000088888888000000008888888800000000bbbbbbbb00000000bbbbbbbb00000000bbbbbbbb00000000000000000000
00005555555500000000999999990000000099999999000000009999999900000000333333330000000033333333000000003333333300000000000000000000
05575555555575500887888888887880088788888888788008878888888878800bb7bbbbbbbb7bb00bb7bbbbbbbb7bb00bb7bbbbbbbb7bb00000000000000000
05575555555575500887777777777880088777777777788008878888888878800bb7777777777bb00bb7777777777bb00bb7bbbbbbbb7bb00000000000000000
0557555555557550088777c77c777880088777c77c77788008878888888878800bb777e77e777bb00bb777e77e777bb00bb7bbbbbbbb7bb00000000000000000
0557555555557550088777cccc777880088777cccc77788008878888888878800bb777eeee777bb00bb777eeee777bb00bb7bbbbbbbb7bb00000000000000000
0557555555557550988777cccc798880088897cccc77788908878888888878803bb777eeee73bbb00bbb37eeee777bb30bb7bbbbbbbb7bb00000000000000000
05577777777775509887777777798880088897777777788908877777777778803bb777777773bbb00bbb377777777bb30bb7777777777bb00000000000000000
0004944944944000000444444444400000055555555550000005555555555000000bbbbbbbbbb000000bbbbbbbbbb00000000000000000000000000000000000
0004944444444000000444444444400000055555555550000005555555555000000bbbbbbbbbb000000bbbbbbbbbb00000000000000000000000000000000000
000444fffffff000000449444494400005555555555555500555555555555550000bbb4444444000000bbbbbbbbbb00000000000000000000000000000000000
00044ffffffff0000004494944944000000ffffffffff00000066666666660000004444444444000000bbbbbbbbbb00000000000000000000000000000000000
00f44ff4fff4f00000f4494944944f0000fffff0fff0f00000f6666666666f000044400000000000004bbbbbbbbbb40000000000000000000000000000000000
00fffffffffff00000f4494944944f0000fffffffffff00000f6666666666f000044444004400000004bbbbbbbbbb40000000000000000000000000000000000
00affffffffff00000a4494944944a0000affffffffff00000a6666666666a0000a4444444444000000bbbbbbbbbb00000000000000000000000000000000000
000ffffffffff0000004494944944000000ffffffffff00000077777777770000004444444444000000bb444444bb00000000000000000000000000000000000
00042222222240000004444944444000000077777777000000011111111110000000eeeeeeee0000000444444444400000000000000000000000000000000000
0004a222222a40000004444444444000000011177111000000011111111110000000eeeeeeee0000000044444444000000000000000000000000000000000000
02222aaaaaa222200224444444444220011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee000000000000000000000000000000000
0222222aa22222200224444444444220011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee000000000000000000000000000000000
02222222222222200222222222222220011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee000000000000000000000000000000000
02222222222222200222222222222220011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee000000000000000000000000000000000
02222222222222220222222222222220011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee000000000000000000000000000000000
02222222222222220222222222222220011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee000000000000000000000000000000000
00aaaa0000aaaa000088880000000000000000000494949022222222000000000000000000000000000000000000000000000000000000000000000000000000
0a799aa00a7777a00889978000bbb000000000009999999922222222000000000000000000000000000000000000000000000000000000000000000000000000
a777aaaaa770777a888998780bb3bb00044444409999999922222222000000000000000000000000000000000000000000000000000000000000000000000000
a97aaa9aa770777a89988998bb33b3bb445454540000000022222222000000000000000000000000000000000000000000000000000000000000000000000000
a9aaaa9aa770777a89988998bbbb33b3454545440000000022222222000000000000000000000000000000000000000000000000000000000000000000000000
aaaaa99aa770007a8889988800bbbb33004444009999999922222222000000000000000000000000000000000000000000000000000000000000000000000000
0aa999a00a7777a00889988000000bbb000000009999999922222222000000000000000000000000000000000000000000000000000000000000000000000000
00aaaa0000aaaa000088880000000000000000000999999022222222000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010101010100010101010101010100010001010101000000010100000000000000000001000101010002000000000000000001010000010100000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f414545454545454545454545456e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f524c4d4d4d4d4d4e4e4e4e4e50515f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f40576373757463636363636358445f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f40577878787878787878787858445f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f40576402016464646464646458445f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f4057645959646464646464675854465f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f40575959595959595964767758545e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f405c696969697979797969695d54445f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f4053555555555555555555555654445f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f406c6d6c6c6c6c6c6c6c6c6c6c54445f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f40544a4b6c6c6c6c6c6c4a4b5454475f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f42435a5b4343434343435a5b4343495f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5656565656565656565656565656565656565656565656565656565656565656565656565656565656565656565656565656565656560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5656565656565656565656565656565656565656565656565656565656565656565656565656565656565656565656565656565656560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
