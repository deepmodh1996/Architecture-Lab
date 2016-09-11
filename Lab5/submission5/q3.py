
f = open('data.txt','r')
costMulti = 0
costSingle = 0

for line1 in f:
	if line1.find('[')!=-1:
		list1 = line1.split(' ')
		instruction = list1[2]
		costSingle = costSingle + 1
		if instruction == 'lw':
			costMulti = costMulti + 5
		elif instruction[0] == 'b':
			costMulti = costMulti + 3
		else :
			costMulti = costMulti + 4
	
print "number of cycle in multicycle is : "
print costMulti
print '\n'

print "Number of clock cycle in single cycle is : "
print costSingle

print '\nMulti cycle is this much faster than single cycle : '
print 1/((costMulti/5.0)/costSingle)

f.close()
