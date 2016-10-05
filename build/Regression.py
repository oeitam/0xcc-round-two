
prog1 = '''as        principal admin password "admin" do    
create principal bob "B0BPWxxd"
        set x = "my string"
    create principal master "FlexPWd"
        default delegator = master
       set y ={f1=x,f2="field2"}
       set z = [4,x,"a literal"]
    return z
   set     delegation x admin read-> bob
   set records = []
   append to records with { name = "mike", date = "1-1-90" } 
   append to records with { name = "dave", date = "1-1-85" }
   local names = records
   foreach rec in names replacewith rec.name
   return names
   return records
   ***'''

# x exist must exit ok
prog2 = '''as        principal admin password "admin" do    
        set x = "my string"
   return x
   ***'''

# bob Exist
prog3 = '''    as principal admin password "admin" do
create principal bob "B0BPWxxd"
set x = "my string"
return x
   ***'''
# variable not owned by bob   
prog4 = '''    as principal bob password "B0BPWxxd" do
set y = "ok"
set w = y
return x
   ***'''
# must exit ok
prog5 = '''    as principal admin password "admin" do
set z = "ko"
return x
   ***'''


prog6= '''set principal admin password  do
set x = "ss"
return x
   ***'''

prog7= '''set principal admin password "admin" do
set x = "ss"
return x
   ***'''

prog8 = '''as        principal admin password "admin" do    
        set x = "my string"
        return "success
   ***'''

prog9 = '''as        principal admin password "admin" do    
        set x = "my string"
        return success"
   ***'''

prog10= '''as principal admin password "admin" do
create principal bon "B0BPWxxd"
set x = "my string"
set delegation x admin read -> bob
return x
   ***'''

prog11= '''as principal admin password "admin" do
set x > "hello"
return x
***'''

        
print "#### prog1 OK #####"
print(parse(prog1))
print "#### prog2 OK #####"
print(parse(prog2))
print "#### prog3 FAILED #####"
print(parse(prog3))
print "#### prog4 #####"
print(parse(prog4))
print "#### prog5 OK #####"
print(parse(prog5))
print "#### prog6 #20 FAILED #####"
print(parse(prog6))
print "#### prog7 #21 FAILED #####"
print(parse(prog7))
print "#### prog8 #22 FAILED #####"
print(parse(prog8))
print "#### prog9 #22 FAILED #####"
print(parse(prog9))
print "#### prog10 #24 #####"
print(parse(prog10))
print "#### prog11 #28 FAILED #####"
print(parse(prog11))




