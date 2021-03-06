extends Sprite

var masterlist = "res://texts/master-texts.csv"
var totalcount = 1
var shuff = [1]
var shuffdex = 0
var file = ""
var data = ""

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func new_message(text, r1, r2, r3):
	$Notification.play()
	
	$thirdMessage.text = $secondMessage.text
	$secondMessage.text = $latestMessage.text
	
	$latestMessage.text = text
	
	$Reply.text = r1
	$Reply.show()
	$Reply2.text = r2
	$Reply2.show()
	$Reply3.text = r3
	$Reply3.show()

func sample(list,amt):
	var shuffled = list.duplicate()
	shuffled.shuffle()
	var sampled = []
	for _i in range(amt):
		sampled.append( shuffled.pop_front() )
	return sampled

func _on_HUD_filestuff():
	file = iterate_file(masterlist)
	data = read_file(file)
	var index = range(1,data.size())
	shuff = sample(index, index.size())
	

func iterate_file(filename):
	var dir = Directory.new()
	var newfn = str(String(filename), String(OS.get_system_time_msecs()))
	dir.copy(filename, newfn)
	return newfn
	
func read_file(filename):
	var result = {}
	var f = File.new()
	f.open(filename, f.READ)
	var index = 1
	while not f.eof_reached():
		var line = f.get_line()
		result[str(index)] = line
		index += 1
	f.close()
	return result

func _on_MessageTimer_timeout():
	var newtime = $MessageTimer.wait_time + rng.randf_range(-1, 1)
	if newtime < 1:
		newtime += 1
	$MessageTimer.wait_time = newtime
	
	totalcount += 1
	#print(totalcount)
	$Count.text = str(totalcount)
	
	var ln = str(shuff[shuffdex])
	#print(ln)
	var lnspt = data[ln].split(",",true)
	new_message(lnspt[0], lnspt[1], lnspt[2], lnspt[3])
	if shuffdex < shuff.size()-1:
		shuffdex += 1
	else:
		var index = range(1,data.size()) #reshuffle
		shuff = sample(index, index.size())
		shuffdex = 1

func write_rep_to_file(filename, linecont, replynum):
	var f = File.new()
	if(f.open(filename, f.READ_WRITE) == OK):
		f.seek_end()
		f.store_line(linecont + "," + replynum)
	f.close()

func _on_Reply_pressed():
	if totalcount > 0:
		totalcount -= 1
	$Reply2.hide()
	$Reply3.hide()
	if shuffdex > 0:
		write_rep_to_file(file, data[str(shuff[shuffdex-1])], "reply1")
	
func _on_Reply2_pressed():
	if totalcount > 0:
		totalcount -= 1
	$Reply.hide()
	$Reply3.hide()
	if shuffdex > 0:
		write_rep_to_file(file, data[str(shuff[shuffdex-1])], "reply2")
	
func _on_Reply3_pressed():
	if totalcount > 0:
		totalcount -= 1
	$Reply.hide()
	$Reply2.hide()
	if shuffdex > 0:
		write_rep_to_file(file, data[str(shuff[shuffdex-1])], "reply3")
