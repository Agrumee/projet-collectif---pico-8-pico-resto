pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--global

function _init()

scene = "start"
x=0
y=0

				music(1)
    create_player()
    create_frigo()
    list_clients()
    create_client()
    create_burger()
    client_aleatoire()
    score=0 
    burger_shiny()
    create_cuisson()  
end

function _update()
  
   if scene == "start"
   then update_start() 
 	 elseif scene == "game"
   then update_game()
   elseif scene == "timesup"
   then update_timesup()
   

end
end

function _draw()
    if scene == "start"
    then draw_start()
    elseif scene == "game"
    then draw_game()
    elseif scene == "timesup"
    then draw_timesup()   

end
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
    boisson = 0,
    burger = 0
    }
end

--mouvements basiques
function chef_movement()
    newx = chef.x
    newy = chef.y
    
    if btnp(➡️) then
    newx+=1
    chef.sprite=130
    frigo.sprite=16 
				end
 
				if btnp(⬅️) then
    newx-=1
    chef.sprite=128
    frigo.sprite=16    
				end

--chef de dos / face au frigo			
				if (chef.x == 5 or chef.x == 4) 
				and chef.y == 7
				and btnp(⬆️)	
				and chef.boisson < 9
				then
				frigo.sprite = 18
				chef.sprite = 132
				chef.boisson += 1
				sfx(1)
				end
				

--prise des ingredients	
				if chef.x == 3 
				and chef.y == 7
				and btnp(⬇️)	
				and chef.tomate < 9
				then
				chef.tomate += 1
				sfx(6)
				end
				
				if chef.x == 5
				and chef.y == 7
				and btnp(⬇️) 
				and chef.salade < 9
				then
				chef.salade += 1
				sfx(7)
				end
				
				if chef.x == 7
				and chef.y == 7
				and btnp(⬇️)
				and chef.steak < 9
				then 
				chef.steak += 1
				sfx(4)
				end
				
				if chef.x == 9
				and chef.y == 7
				and btnp (⬇️)
				and chef.pain < 9
				then
				chef.pain +=1
				sfx(5)
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

--assemblage du burger par
--rapport a la demande du 
--client
function update_assemblage()

show_burger=14


				if (chef.tomate >= burger.tomate)
and (chef.pain >= burger.pain)
and (chef.steak >= burger.steak)
and (chef.salade >= burger.salade)
and (chef.boisson >= burger.boisson)
and (chef.x == 11)
and (btnp(⬇️))
and (client.order>0)
then
--quand assemblage = commande
--client faire apparaitre le 
--burger shiny
--+score
burger.finishsprite = 59
score+=10
client.order-=1
chef.tomate -= burger.tomate
chef.steak -= burger.steak
chef.pain -= burger.pain
chef.salade -= burger.salade
chef.boisson -= burger.boisson 
chef.burger +=1
else if (btnp(⬆️))
or (btnp(➡️))
or (btnp(⬅️))
then
show_burger = 14
end
if chef.burger > 0
and chef.x == 11
then show_burger = rnd(burger_finish)
end
end
end			
			
function draw_assemblage()
spr(show_burger,92,46,1,1)
end				
-->8
--foodtruck

function check_flag(flag, x, y)
    local sprite = mget(x, y)
    return fget(sprite, flag)
end

--permet de faire passer le 
--chef derriere la caisse
function draw_caisse()
 flag1=100
 spr(102,88,56,2,2)
	spr(flag1, 88,80)
	if chef.burger==client.order then
	flag1=101
	end
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

function update_cuisson()
fumee1=14
fumee2=14
if chef.x==7
and chef.steak>0
and chef.steak<9
and btn(⬇️)
then
	fumee1=rnd(cuisson)
	fumee2=rnd(cuisson)
end
end

function create_cuisson()
cuisson={45,44}
end

--afficher les ingredients
--au premier plan
function draw_preparation()
	spr(50,24,72)
	spr(50,32,72)
	spr(51,40,72)
	spr(51,48,72)
	spr(52,56,72)
	spr(52,64,72)
	spr(53,72,72)
	spr(53,80,72)
	spr(fumee1,56,64)
	spr(fumee2,64,64)
end


-->8
--inventaire

--permet de mettre une limite au
--nombre d'ingredients qu'on 
--prendre
function draw_ingredient()
 spr(50,2,2)
 print("X" .. min(chef.tomate,9),11,3)
 
 spr(51,21,2)
 print("X" .. min(chef.salade,9),30,3)
 
 spr(52,40,2)
 print("X" ..min(chef.steak,9),49,3)
 
 spr(53,60,2)
 print("X" ..min(chef.pain,9),69,3)
 
 spr(43,80,1)
 print("X"..min(chef.boisson,9),87,3)
end


-->8
--timer et argent et timesup

timer = 60
counter = 0


function timer_count()
	counter = 1/30 --30 car 30fps
	timer -= counter
	if (flr(timer) == 0) then 
	cls()
	music(18)
	timer = counter
	end
end

--permet d'eviter les 
--secondes dans le timer
function draw_timer()
	local timer_formate = flr(timer)
 spr(49,68,119)
 print(":".. timer_formate,76,121)
end

--affiche le score
function draw_score()
	spr(48,98,119)
 print(":$"..score,106,121)
end

--affichage time's up
function draw_gameover()
	cls()
	spr(6,42,45,6,2)
	spr(48,50,65)
 print(score,62,67)
 print("recommencer ❎",40,80)
end



-->8
--gameplay client
	
	
--initialisation des clients
function list_clients()
	clients={
	'le parrain',
	'zoro',
	'thelma'
	}
end

function create_client()
	client={
	x=-1,
	y=10,
	order=ceil(rnd(4))
	--ceil permet d'enlever les 
	--chiffres decimaux
	}
end

function draw_client()
	spr(affichage_client, client.x*8, client.y*8,2,3)
end


--permet de faire apparaitre un
--client aleatoire 
function client_aleatoire()
	aleatoire=rnd(clients)
		if aleatoire == 'le parrain' then
		sprite=196
		minisprite=36
		spritedos=198
		
		else if aleatoire == 'zoro' then
		sprite=200
		minisprite = 37
		spritedos=202
		
		else if aleatoire == 'thelma' then
		sprite=204
		minisprite=38
		spritedos=206
		
	end
	end
	end 
end

--gere les mouvements du client
function client_move()
	client.x+=0.2
	affichage_client=sprite
		if check_flag(1,client.x,client.y) 
		and client.order>0
		then
		client.x=11
		affichage_client=spritedos
		spr(4,8,70,2,2)
	end
	
--son d'arrivee du client
	if client.x > 10.8
	and client.x < 11
	then sfx(3)
	end
	
	--son de remise de burger 
	if client.order == 0
	and client.x > 11.5
	and client.x <12
	then sfx(2)
	end

		if client.x > 16
		then chef.burger = 0 spawn_client()
end 
end

--permet de faire apparatre un
--nouveau client
function spawn_client()

 list_clients()
	create_client()
	draw_client()
	client_aleatoire()
	client_move()
	draw_order()
	end
	


-->8
--burger order 

function create_burger() 
	burger = {
	tomate = 1,
	salade =1,
	steak = 1, 
	pain = 1,
	sprite = 14,
	boisson = 1
	}
end

function burger_shiny()
	burger_finish = {59,60}
end

function draw_burger()
	spr(burger.sprite,103,64,2,2)
end

--faire apparaitre la commande
--du client lorsqu'il 
--s'arrete a la caisse
function update_burger()
	if client.x == 11 
	then burger.sprite=4
	else burger.sprite=14
end
end

--fait apparaitre le nombre de
--burgers commande par le client
--en bas de l'ecran
function draw_order()
if client.x==11
then
		spr(39,13,118)
		spr(minisprite,3,119)
		print("X"..client.order,23,121)
		spr(43, 35, 118)
		print("X"..client.order,41,121)
	end 
end
-->8
--ecran start + end


--permet d'afficher le start
function draw_start()
	cls()
	map(17,0,0,0)
	print("start",56,10)
	print("choose your cook",33,20)
	print("using 1-5 keys",36,28)
	
	spr(130,25,45,2,2)
	print("1",32,62)
	
	spr(136,58,45,2,2)
	print("2",65,62)
	
	spr(142,88,45,2,2)
	print("franky",85,62)
	
	spr(164,40,75,2,2)
	print("luci",40,92)
	
	spr(170,75,75,2,2)
	print("5",82,92)
	
	print("press ❎ to start",28,109)
	
end


--affiche tous les sprite du 
--jeu
function draw_game()
    cls()
    map(0,0,0,0)
 		 draw_frigo()
    draw_player()
    draw_caisse()
    draw_client()
    draw_ingredient()
    draw_timer()
    draw_preparation()
    draw_burger()
   	draw_assemblage()
   	draw_order()
   	draw_score()
end

--affiche la scene timesup
function draw_timesup()
	   draw_gameover()
end

--pour passer du start au game
function update_start()
 if btn(❎) then scene = "game"
 end
end 

--sert a lancer le jeu
function update_game() 
			 chef_movement()
    timer_count()
    client_move()
    update_burger()
    update_assemblage()
    update_cuisson()
    --pour passer du game au gameover
    if flr(timer) == 0 
    then scene = "timesup"
end
end

-- pour recommencer le jeu
function update_timesup()
	if btn(❎) then
	_init() 
	scene = "game"
	timer = 60
	end
end

--sert a mettre a jour l'ecran
-- pour passer du start au game



--sert a passer du game au 
--gameover quand le timer 
--arrive a 0



__gfx__
77777777777777777777777777777777000000000000000000000000000000000000000007000000000000000000000000000000000000000000000000000000
76777777777766777677777777776677000007777770000000000000000000000000000007000000000000000000000000000000000000000000000000000000
76677777777766777667777777776677000067776667000000777777077077000770777700077777000770770777770000000000000000000000000000000000
76667777777777777666777777777777000667777766700000777777077077707770777700077777000770770777770000000000000000000000000000000000
76676777777777777667677777777777006677944976770000007700077077777770770007700000000770770770007700000000000000000000000000000000
76677677777777777667767777777777006779999997770000007700077077070770770007700000000770770770007700000000000000000000000000000000
76677766777555777667776677755577006778888887770000007700077077000770770007700000000770770777770000000000000000000000000000000000
76666666755555777666666675555577007774444447770000007700077077000770777000077777000770770777770000000000000000000000000000000000
77777777777777777dd886886886886700777bbbbbb7760000007700077077000770777000000077000770770770000000000000000000000000000000000000
767777777777557775d7767767767767007769999997660000007700077077000770770000000077000770770770000000000000000000000000000000000000
767777777777557775d88d88d88d88d7000766777776600000007700077077000770770000000077000770770770000000000000000000000000000000000000
767777777777557775d6777766666667000076677766000000007700077077000770770000000077000770770770000000000000000000000000000000000000
767777777777757775d9969969969967067007777770000000007700077077000770777707777700000777770770000000000000000000000000000000000000
767777777777757775d9a69a69a69a67077000000000000000007700077077000770777707777700000777770770000000000000000000000000000000000000
767777777777767775d99d99d99d99d7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76777777777776777dd6777766666667700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76777777777777777d5cc6cc6cc6cc67055555500bbbbbb011111110000000006666666600088800000aaa000000000060006776000000600000000000000000
76677777777777777d5c16c16c16c167555555550b44444011fffff000000000666666660088888000aaaaa06666000000006760006600000000000000000000
76667777777777777d5ccdccdccdccd706fdfdf0041111101ff2f2f0094949006666666600898890008aaa808888000000000660007760000000000000000000
76666777777777777dd6667666666767affffff0a4114110affffff09999999066666666008989800088a8808888000000000000067776000000000000000000
76666677777776777dd66766ddd676670ffffff0044444401ffffff0888888806666666600899880008a8a808877000000760000006770000000000000000000
76666666666666777dd676666667666711777711eeeeeeeecaccccac444444406969696600898980008aaa807778000006777000000600000000000000000000
76666666666666777dd766666676666711111111eeeeeeeeccaaaaccbbbbbbb009999a0000898890008aaa808888000000776000000000770000000000000000
7777777777777777775555555555555711111111eeeeeeeecccccccc999999900a999a000088888000aaaaa08888000000060000000007760000000000000000
00aaaa0000aaaa00008888000000000000000000049494900eeeeee0900000093000000302222220625252500a0a0a0aa0a0a0a0000044444444444444440000
0a799aa00a7777a00889978000bbb00000000000999999990efffff088888888bbbbbbbb02444440665d5d50a00000000000000a000000000000000000000000
a777aaaaa770777a888998780bb3bb000444444099999999fff4f4f0088988900bbabba0444040406dd0d0d00094490aa0944900000000000000000000000000
a97aaa9aa770777a89988998bb33b3bb4454545400000000affffff0088888800bbbbbb0a44444400dddddd0a99999900999999a000000000000000000000000
a9aaaa9aa770777a89988998bbbb33b345454544000000000ffffff0088888800bbbbbb0044444400dddddd00888888aa8888880000000000000000000000000
aaaaa99aa770007a8889988800bbbb3300444400999999998788887887888878b7bbbb7b3733337357555575a44444400444444a000000000000000000000000
0aa999a00a7777a00889988000000bbb00000000999999998777777887777778b777777b37777773577777750bbbbbbaabbbbbb0000000000000000000000000
00aaaa0000aaaa0000888800000000000000000000000000877dd778877cc778b77ee77b3778877357788775a99999900999999a000000000000000000000000
33499999ccc777cc334999999999999999999433cccccccccccccccc999994333339994099292333999999999999999999988887778887778877778887778877
33499999c777444433499999999999999999943344444444444ccccc999994333333994492828233999999999999999999888777788877778887778887778887
33499999c7749999334999999999999999999433999999999994cccc999994333333999999272333999955555599999999888778888877788887778888777888
b3499999cc749999334999999999999999999433999999999994cccc999994333333399992828233999555555555999998887778888777788887777888777788
3b499999cc499999334499999b99999999999433999999999aa94ccc9999443333333333b32b2333995555000555599988887778888777788888777888777788
3b499999cc4999993334444444b444449999943399999999aaaa4ccc9999433b333333333bb33333955550550055559988877788888777888888777788877778
33499999cc4999993333333333b333b39999943399999999aa7a94cc999943b33333333333b33333955505555505559988877788888777888888777788887778
33499999cc4999993333333333333b339999943399999999aa7a94cc999943b33333333333333333955055665550559988777888887778888888877788887777
77899999999994cccc499999999ff4449999999944444444444ff99999940000000049993333333395505556655055999994444444444999aaaa943322222222
77789999999994cccc4999994fff444499999999444444444444fff499940000000049993333333395505555555055999994444444444999aaaa943322222222
87788999999994cccc4999999999999999999999999999999999999999940000000049993333333395505556555055999994444444444999aa8a943b22222222
87778899999994cccc4999999999999999999999999999999999999999940000000049993333333395550566550055b999944444444449999aa994b322222222
88778889999994cccc49999899999999999999999999999999999999999400000000499933333333bb55055555055bb99994444444444999999994b322222222
88777788899994cccc499998999999999999999999999999999999999994000000004999333333334b55505550055b4499944444444449999999943322222222
88877778889994cccc499988999999999999999999999999999999999994000000004999333333333b3555000055bb3399955444444559999999943322222222
88887778888994cccc499888999aaaaa99999999aaaaaaaaaaaaa999999400000000499933333333333355555553333399955554455559999999943322222222
cccccccc222222227777777c6666666644444444444444440000000000000000cc49999944444444000000000000000099999999334999997777777c33333333
cccccccc22222222444444446666666644444444444444440000000000000000cc499999f44444ff00000000000000009999999933499999444c77cc33333333
cccccccc22222222999999996666666699999999999999990000000055555555cc49999944444444000000000000000099999999334999999994cccc333b3333
cccccccccccccccc999999996666666699999999999999990000000055555555cc499999fff44ff4000000000000000099999999334999999994cccc33b33333
cccccccccccccccc999999996666666699999999999999990000000055333355cc499999444444440000000000000000999999993349999999994ccc3bb33333
cccccccccccccccc999999996666666699999999999999990000000055333355cc49999944fff4440000000000000000999999993349999999994ccc33333333
cccccccccc777ccc999999990000000099999999999999990000000055555555cc499999444444ff0000000000000000aaaaaaaa33499999999994cc33333333
cccccccc7777777c9999999900000000aaaaaaaaaaaaaaaa0000000055555555cc4999994444444400000000000000009999999933499999999994cc33333333
cccccccc999994cc334999996665666666656666666566660000000000005500cccccccc44444444000000000000000000000000000000003333333322222222
ccc777dc999994cc3349999966656666666d6666666566660000000000005500cc777ddd56555565000000000000000000000000000000003333333322222222
c7777777999994cc3349999966555666666566666665666600005555555555007777777d66666666000000000000000000000000000000003333333322222222
c7777777999994cc3349999966565666665556666665566600005555555555007777777c565555650000000000000000000000000000000033333333cccccccc
cc77c77c999994cc33499999665656666d65656666655666005566886666dd55c77c77cc565555650000000000000000000000000000000033333333cccccccc
cccccccc999994cc3349999966d65666656565666665d666005566886666dd55cccccccc666666660000000000000000000000000000000033333333cccccccc
cccccccc999994cc334999990050500005050500000550005555555555555555cccccccc565555650000000000000000000000000000000022222222cccccccc
cccccccc999994cc334999990000000000000000000500005555555555555555cccccccc565555650000000000000000000000000000000022222222cccccccc
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
0000000000000000000000000000000000055555555550000005555555555000000bbbbbbbbbb000000bbbbbbbbbb000000c1c11111110000001111111111000
0000000000000000000000000000000000055555555550000005555555555000000bbbbbbbbbb000000bbbbbbbbbb000000c1111111110000001111111111000
0000000000000000000000000000000005555555555555500555555555555550000bbb4444444000000bbbbbbbbbb000000111fffffff00000011c1111c11000
00000000000000000000000000000000000ffffffffff00000066666666660000004444444444000000bbbbbbbbbb00000011ffffffff00000011c1c11c11000
0000000000000000000000000000000000fffffdfffdf00000f6666666666f000044411111111000004bbbbbbbbbb40000f11ff2fff2f00000f11c1c11c11f00
0000000000000000000000000000000000fffffffffff00000f6666666666f000044444114411000004bbbbbbbbbb40000fffffffffff00000f11c1c11c11f00
0000000000000000000000000000000000affffffffff00000a6666666666a0000a4444444444000000bbbbbbbbbb00000affffffffff00000a11c1c11c11a00
00000000000000000000000000000000000ffffffffff00000077777777770000004444444444000000bb444444bb000000ffffffffff00000011c1c11c11000
00000000000000000000000000000000000077777777000000011111111110000000eeeeeeee000000044444444440000001cccccccc10000001111c11111000
00000000000000000000000000000000000011177111000000011111111110000000eeeeeeee000000004444444400000001acccccca10000001111111111000
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00ccccaaaaaacccc00cc1111111111cc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00ccccccaacccccc00cc1111111111cc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
00000000000000000000000000000000011111111111111001111111111111100eeeeeeeeeeeeee00eeeeeeeeeeeeee00cccccccccccccc00cccccccccccccc0
__gff__
0000000001000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000ff000100000001010101010001ff01010101010100010001010101000000010100000000000002000001000101010002000000000000000001010000010100000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7f7f7f617f7f7f617f7f7f7f617f7f7f7f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60414545454545454545454545456e60600e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70524c4d4d4d4d4d4e4e4e4e4e505170600e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60685763737574632863636363587160600e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7868577c292a7c3637393a387c587160600e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6068577c02013d3e3e3e3e3e3f587178600e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6068577c7c7c7c7c7c7c7c7c67585446600e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f40577c7c7c7c7c7c7c7c767758545e590e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f405c696969697979797969695d54446f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f4053555555555555555564555654446f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
59406c6c6c6c6c6c6c6c6c6c6c6c5444590e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f40544a4b6c6c6c6c6c6c4a4b5454476f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6f42435a5b4343434343435a5b434349590e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
__sfx__
000100000565007650096500c6500c6500c650116501e200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000b5100d510105201252014520175201a5301b530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000140501805015050200501d0501c05020050260502f05033010391103f1100010005100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c00200003d5303d5303d5203d5203d5203d5103d5103d5003d5003d5303d5303d5203d5203d5203d5103d5103d5003d5000000000000000000000000000000000000000000000000000000000000000000000000
000200000862007620056200562004620026200162001620006200661005610056100561004610016000060010500135001150012500135000050001500005000050000500005000050000500005000050000500
000300000b05006050040500105000050006000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000e1300e1200e1100e1000e1000e1000e1000e1000e1300e1200e1100e1000e1000d1000d1000d1000e1300e1200e1100e1000c1000c1000c1000d1000e1300e1200e1100e1000d1003b1003b1003b100
00020000147301473016720197201671013750107500f7500e7500d7500c7500b7500975007750077500270002700017000070000700007000070000700007000070000700007000070000700007000070000700
001e00002b0002e0002e720320002900014500000002b700187300070013500000000300001000337500600016500000000700017000107002575003000160001900000000170000000000000137500000000000
001e00000577000000000000577000700000000577000000000000577000000000000577000000000000577026700000000577000000000000577022700000000577000000002000577000000000000577000000
001e000005750303002d3002e3001d750203002230018750047500375017300203000e7502730000300157100000000000167001f7000d700087000670001700137500000000000000000e750087500175000750
0112000003744030250a7040a005137441302508744080251b7110a704037440302524615080240a7440a02508744087250a7040c0241674416025167251652527515140240c7440c025220152e015220150a525
001200000c013247151f5152271524615227151b5051b5151f5101f5101f5121f510225112251022512225150c0131b7151b5151b715246151b5151b5151b515275102751027512275151f5111f5101f5121f515
011200000c0330802508744080250872508044187151b7151b7000f0251174411025246150f0240c7440c0250c0330802508744080250872508044247152b715275020f0251174411025246150f0240c7440c025
011200002452024520245122451524615187151b7151f71527520275202751227515246151f7151b7151f715295202b5212b5122b5152461524715277152e715275002e715275022e715246152b7152771524715
011200002352023520235122351524615177151b7151f715275202752027512275152461523715277152e7152b5202c5212c5202c5202c5202c5222c5222c5222b5202b5202b5222b515225151f5151b51516515
011200000c0330802508744080250872508044177151b7151b7000f0251174411025246150f0240b7440b0250c0330802508744080250872524715277152e715080242e715080242e715246150f0240c7440c025
__music__
01 0b0c4344
00 0b0c4344
00 0d0e4344
02 0f104344

