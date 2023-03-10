import turtle

# reference fragment
ref_seq = "ACCGTACCGGTAGCCT"

# read sequences
read_seq_1 = "GTACCGGTAG"
read_seq_2 = "ACCGGTAGCCT"

# set up turtle
turtle.speed(0)
turtle.penup()
turtle.goto(0, 0)
turtle.pendown()

# draw reference fragment
turtle.forward(len(ref_seq) * 10)
turtle.penup()
turtle.goto(0, 20)
turtle.write(ref_seq)
turtle.goto(0, 0)
turtle.pendown()

# function to calculate hanging tail length
def calculate_tail_len(seq, ref_seq):
    tail_len = 0
    for i in range(1, len(seq)):
        if ref_seq.endswith(seq[:i]):
            tail_len = len(seq) - i
    return tail_len

# calculate overlap lengths for reads 1 and 2
overlap_1 = 0
overlap_2 = 0
for i in range(len(read_seq_1)):
    if ref_seq.endswith(read_seq_1[:i+1]):
        overlap_1 = i+1
for i in range(len(read_seq_2)):
    if ref_seq.startswith(read_seq_2[-i-1:]):
        overlap_2 = i+1

# calculate length of hanging tails for reads 1 and 2
tail_len_1 = calculate_tail_len(read_seq_1, ref_seq)
tail_len_2 = calculate_tail_len(read_seq_2, ref_seq)

# function to reverse transcribe a sequence
def reverse_transcribe(seq):
    complement = {"A": "T", "T": "A", "G": "C", "C": "G"}
    return "".join([complement[base] for base in reversed(seq)])

# reverse transcribe read 2
read_seq_2_rev = reverse_transcribe(read_seq_2)

# draw read 1
turtle.color("red")
turtle.penup()
turtle.goto(overlap_1 * -10, -20)
turtle.pendown()

if overlap_1 > 0:
    turtle.right(90)
    turtle.forward(10)
    turtle.left(90)
    turtle.forward(tail_len_1 * 10)
    turtle.right(90)
    turtle.forward(overlap_1 * 10)
    turtle.left(90)
    turtle.forward(10)
else:
    turtle.forward(len(read_seq_1) * 10)

# draw hanging tail for read 1 if necessary
if tail_len_1 > 0:
    turtle.right(90)
    turtle.forward(10)
    turtle.left(90)
    turtle.forward(tail_len_1 * 10)

turtle.penup()
turtle.goto(0, -40)
turtle.write(read_seq_1)
turtle.pendown()
turtle.penup()
turtle.goto(0, 0)
turtle.pendown()

# draw read 2
turtle.color("blue")
turtle.penup()
turtle.goto(overlap_2 * 10, 20)
turtle.pendown()

if overlap_2 > 0:
    turtle.left(90)
    turtle.forward(10)
    turtle.right(90)
    turtle.forward(tail_len_2 * 10)
    turtle.left(90)
    turtle.forward(overlap_2 * 10)
    turtle.right(90)
    turtle.forward(10)
else:
    turtle.forward(len(read_seq_2_rev) * 10)

# draw hanging tail for read 2 if necessary