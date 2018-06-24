--[[
Surface 2

The MIT License (MIT)
Copyright (c) 2017 CrazedProgrammer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local e={}
do local t={}e.surf=t;local a,o,i=table.concat,math.floor,math.atan2;local n,s={},{}for q=0,15
do n[2^q]=string.format("%01x",q)s[string.format("%01x",q)]=
2^q end;local h={}for q=0,255 do
h[q]=string.char(q)end;local r={}for q=0,1023 do r[q]=tostring(q)end
local d,l,u=20,{},{}for q=0,d-1 do
l[q+1]=(1-math.sin(q/d*math.pi*2))/2
u[q+1]=(1+math.cos(q/d*math.pi*2))/2 end;local c,m,f,w,y,p=16
local function v(q,j,x)local z,_,E,T,A,O=0,0,0,0,j,x;for I=1,#
q do z=z+q[I].ox;_=_+q[I].oy;E=E+q[I].x;T=T+q[I].y
A=q[I].width;O=q[I].height end;return z,_,E,T,A,O end
local function b(q,j,x,z,_,E,T,A)if q<_ then x=x+q-_;q=_ end;if j<E then z=z+j-E;j=E end
if q+x>_+T then x=T+_-q end;if j+z>E+A then z=A+E-j end;return q,j,x,z end
function e.create(q,j,x,z,_)local e=setmetatable({},{__index=e.surf})e.width=q
e.height=j;e.buffer={}e.overwrite=false;e.stack={}
e.ox,e.oy,e.cx,e.cy,e.cwidth,e.cheight=v(e.stack,q,j)local E=e.buffer;for T=1,q*j*3,3 do E[T]=x or false;E[T+1]=z or false
E[T+2]=_ or false end;E[q*j*3+1]=false;if not x then for T=1,q*j*3,3 do
E[T]=x end end
if not z then for T=2,q*j*3,3 do E[T]=z end end;if not _ then for T=3,q*j*3,3 do E[T]=_ end end;return e end
function e.getPlatformOutput(q)q=q or
(term or gpu or(love and love.graphics)or io)
if q.blit and q.setCursorPos then return
"cc",q,q.getSize()elseif
q.write and q.setCursorPos and q.setTextColor and q.setBackgroundColor then return"cc-old",q,q.getSize()elseif
q.blitPixels then return"riko-4",q,320,200 elseif q.points and q.setColor then
return"love2d",q,q.getWidth(),q.getHeight()elseif q.drawPixel then return"redirection",q,64,64 elseif
q.setForeground and q.setBackground and q.set then return"oc",q,q.getResolution()elseif q.write then
return"ansi",q, (os.getenv and
(os.getenv("COLUMNS")))or 80, (os.getenv and
(os.getenv("LINES")))or 43 else error("unsupported platform/output object")end end
function t:output(q,j,x,z,_,E,T)local A,q,O,I=e.getPlatformOutput(q)j=j or 0;x=x or 0;z=z or 0
_=_ or 0;E=E or self.width;T=T or self.height
z,_,E,T=b(z,_,E,T,0,0,self.width,self.height)local N=self.buffer;local S=self.width;local H,R,D
if A=="cc"then local L,U,C={},{},{}
for M=0,T-1 do
R=(M+_)*S+z
for F=0,E-1 do H=(R+F)*3;D=F+1;L[D]=N[H+3]or" "
U[D]=n[N[H+2]or 1]C[D]=n[N[H+1]or 32768]end;q.setCursorPos(j+1,x+M+1)q.blit(a(L),a(U),a(C))end elseif A=="cc-old"then local L,U,C,M,F={}
for W=0,T-1 do q.setCursorPos(j+1,x+W+1)
R=(W+_)*S+z
for Y=0,E-1 do H=(R+Y)*3;M=N[H+1]or 32768;F=N[H+2]or 1
if M~=U then if#L~=0 then
q.write(a(L))L={}end;U=M;q.setBackgroundColor(U)end
if F~=C then if#L~=0 then q.write(a(L))L={}end;C=F;q.setTextColor(C)end;L[#L+1]=N[H+3]or" "end;q.write(a(L))L={}end elseif A=="riko-4"then local L={}
for U=0,T-1 do R=(U+_)*S+z;for C=0,E-1 do L[U*E+C+1]=
N[(R+C)*3+1]or 0 end end;q.blitPixels(j,x,E,T,L)elseif A=="love2d"then local L,U,C,M,F,W,Y={}
for P=0,T-1 do
R=(P+_)*S+z
for V=0,E-1 do H=(R+V)*3;F=N[H+1]W=N[H+2]Y=N[H+3]
if F~=U or W~=C or Y~=M then if#L~=
0 then
q.setColor((U or 0)*255,(C or 0)*255,(M or 0)*255,
(U or C or M)and 255 or 0)q.points(L)end
U,C,M=F,W,Y;L={}end;L[#L+1]=V+j+1;L[#L+1]=P+x+1 end end
q.setColor((U or 0)*255,(C or 0)*255,(M or 0)*255,
(U or C or M)and 255 or 0)q.points(L)elseif A=="redirection"then local L=q.drawPixel;for U=0,T-1 do for C=0,E-1 do
L(j+C,x+U,N[
((U+_)*S+ (C+z))*3+1]or 0)end end elseif A=="oc"then
local L,U,C,M,F,W={}
for Y=0,T-1 do U=j;R=(Y+_)*S+z
for P=0,E-1 do H=(R+P)*3;F=N[H+1]or 0x000000;W=
N[H+2]or 0xFFFFFF;if F~=C then
if#L~=0 then q.set(U+1,Y+x+1,a(L))U=P+j;L={}end;C=F;q.setBackground(C)end;if W~=M then if#
L~=0 then q.set(U+1,Y+x+1,a(L))U=P+j;L={}end
M=W;q.setForeground(M)end;L[#L+1]=N[
H+3]or" "end;q.set(U+1,Y+x+1,a(L))L={}end elseif A=="ansi"then local L,U,C,M,F={}
for W=0,T-1 do L[#L+1]="\x1b["..
r[x+W+1]..";"..r[j+1].."H"R=(W+_)*S+z
for Y=0,E-1 do
H=(R+Y)*3;M=N[H+1]or 0;F=N[H+2]or 7
if M~=U then U=M
if U<8 then
L[#L+1]="\x1b["..r[40+U].."m"elseif U<16 then L[#L+1]="\x1b["..r[92+U].."m"elseif U<232 then
L[#L+1]="\x1b[48;2;"..r[o((U-
16)/36*85/2)]..";"..

r[o((U-16)/6%6*85/2)]..";"..r[o((U-16)%6*85/2)].."m"else local P=r[U*10-2312]L[#L+1]="\x1b[48;2;"..
P..";"..P..";"..P.."m"end end
if F~=C then C=F
if C<8 then L[#L+1]="\x1b["..r[30+C].."m"elseif C<16 then L[#L+1]="\x1b["..r[
82+C].."m"elseif C<232 then
L[#L+1]="\x1b[38;2;"..r[o(
(C-16)/36*85/2)]..";"..

r[o((C-16)/6%6*85/2)]..";"..r[o((C-16)%6*85/2)].."m"else local P=r[C*10-2312]L[#L+1]="\x1b[38;2;"..
P..";"..P..";"..P.."m"end end;L[#L+1]=N[H+3]or" "end end;q.write(a(L))end end
function t:push(q,j,x,z,_)q,j=q+self.ox,j+self.oy
local E,T=_ and self.ox or q,_ and self.oy or j
q,j,x,z=b(q,j,x,z,self.cx,self.cy,self.cwidth,self.cheight)
self.stack[#self.stack+1]={ox=E-self.ox,oy=T-self.oy,x=q-self.cx,y=j-
self.cy,width=x,height=z}
self.ox,self.oy,self.cx,self.cy,self.cwidth,self.cheight=v(self.stack,self.width,self.height)end
function t:pop()
if#self.stack==0 then error("no stencil to pop")end;self.stack[#self.stack]=nil
self.ox,self.oy,self.cx,self.cy,self.cwidth,self.cheight=v(self.stack,self.width,self.height)end
function t:copy()local e=setmetatable({},{__index=e.surf})for q,j in pairs(self)do
e[q]=j end;e.buffer={}for q=1,self.width*self.height*3+1
do e.buffer[q]=false end
for q=1,
self.width*self.height*3 do e.buffer[q]=self.buffer[q]end;e.stack={}
for q=1,#self.stack do e.stack[q]=self.stack[q]end;return e end
function t:clear(q,j,x)local z,_
for E=0,self.cheight-1 do
_=(E+self.cy)*self.width+self.cx;for T=0,self.cwidth-1 do z=(_+T)*3;self.buffer[z+1]=q
self.buffer[z+2]=j;self.buffer[z+3]=x end end end
function t:drawPixel(q,j,x,z,_)q,j=q+self.ox,j+self.oy;local E
if q>=self.cx and q<
self.cx+self.cwidth and j>=self.cy and j<self.cy+
self.cheight then E=(
j*self.width+q)*3;if x or self.overwrite then
self.buffer[E+1]=x end
if z or self.overwrite then self.buffer[E+2]=z end;if _ or self.overwrite then self.buffer[E+3]=_ end end end
function t:drawString(q,j,x,z,_)j,x=j+self.ox,x+self.oy;local E=j;local T=x>=self.cy and x<
self.cy+self.cheight;local A;local O=self.cx;local I=
self.cx+self.cwidth;local N=z or self.overwrite
local S=_ or self.overwrite
for H=1,#q do local R=q:sub(H,H)
if R=="\n"then j=E;x=x+1;if T then
if x>=self.cy+self.cheight then return end else T=x>=self.cy end else A=
(x*self.width+j)*3
if j>=O and j<I and T then
if N then self.buffer[A+1]=z end;if S then self.buffer[A+2]=_ end;self.buffer[A+3]=R end;j=j+1 end end end
function e.load(q,j)local x=q
if not j then local z=io.open(q,"rb")if not z then return end;local _={}
local E=z:read(1)
if type(E)=="number"then while E do _[#_+1]=h[E]E=z:read(1)end else while E do
_[#_+1]=E;E=z:read(1)end end;z:close()x=a(_)end
if x:sub(1,3)=="RIF"then local z,_=x:byte(4)*256+x:byte(5),x:byte(6)*256+
x:byte(7)local t=e.create(z,_)
local E=t.buffer;local T,A=8,false;local A=x:byte(index)for O=0,_-1 do
for I=0,_-1 do if not T then
E[(O*z+I)*3+1]=o(A/16)else E[(O*z+I)*3+1]=A%16;index=index+1
x=x:byte(index)end;T=not T end end;return t elseif
x:sub(1,2)=="BM"then
local z=x:byte(0x13)+x:byte(0x14)*256;local _=x:byte(0x17)+x:byte(0x18)*256;if

x:byte(0xF)~=0x28 or x:byte(0x1B)~=1 or x:byte(0x1D)~=0x18 then
error("unsupported bmp format, only uncompressed 24-bit rgb is supported.")end;local E,T=0x36,math.ceil((
z*3)/4)*4;local t=e.create(z,_)
local A=t.buffer
for O=0,_-1 do
for I=0,z-1 do A[(O*z+I)*3+1]=
x:byte((_-O-1)*T+I*3+E+3)/255
A[(O*z+I)*3+2]=x:byte(
(_-O-1)*T+I*3+E+2)/255;A[(O*z+I)*3+3]=
x:byte((_-O-1)*T+I*3+E+1)/255 end end;return t elseif x:find("\30")then local z,_,E=0,1,0
for H=1,#x do
if x:byte(H)==10 then _=_+1;if E>z then z=E end;E=0 elseif
x:byte(H)==30 or x:byte(H)==31 then E=E-1 elseif x:byte(H)~=13 then E=E+1 end end;if x:byte(#x)==10 then _=_-1 end;local t=e.create(z,_)local T=t.buffer
local A,O,I,N,S=1,0,0
while A<=#x do
if x:byte(A)==10 then O,I=0,I+1 elseif x:byte(A)==30 then A=A+1;N=s[x:sub(A,A)]elseif
x:byte(A)==31 then A=A+1;S=s[x:sub(A,A)]elseif x:byte(A)~=13 then
T[(I*z+O)*3+1]=N;T[(I*z+O)*3+2]=S
if N or S then
T[(I*z+O)*3+3]=x:sub(A,A)elseif x:sub(A,A)~=" "then T[(I*z+O)*3+3]=x:sub(A,A)end;O=O+1 end;A=A+1 end;return t else local z,_,E=0,1,0
for I=1,#x do if x:byte(I)==10 then _=_+1;if E>z then z=E end;E=0 elseif x:byte(I)~=13 then
E=E+1 end end;if x:byte(#x)==10 then _=_-1 end;local t=e.create(z,_)local T=t.buffer
local A,O=0,0
for I=1,#x do if x:byte(I)==10 then A,O=0,O+1 elseif x:byte(I)~=13 then
T[(O*z+A)*3+1]=s[x:sub(I,I)]A=A+1 end end;return t end end
function t:save(q,j)j=j or"nfp"local x={}
if j=="nfp"then
for z=0,self.height-1 do
for _=0,self.width-1 do x[#x+1]=
n[self.buffer[(
z*self.width+_)*3+1]]or" "end;x[#x+1]="\n"end elseif j=="nft"then
for z=0,self.height-1 do local _,E,T,A
for O=0,self.width-1 do T=self.buffer[
(z*self.width+O)*3+1]A=self.buffer[(
z*self.width+O)*3+2]if
T~=_ then x[#x+1]="\30".. (n[T]or" ")_=T end;if
A~=E then x[#x+1]="\31".. (n[A]or" ")E=A end;x[
#x+1]=
self.buffer[(z*self.width+O)*3+3]or" "end;x[#x+1]="\n"end elseif j=="rif"then x[1]="RIF"
x[2]=string.char(o(self.width/256),self.width%256)
x[3]=string.char(o(self.height/256),self.height%256)local z,_,E=0,false
for T=0,self.width-1 do for A=0,self.height-1 do
E=self.buffer[
(T*self.width+A)*3+1]or 0
if not _ then z=E*16 else z=z+E;x[#x+1]=string.char(z)end;_=not _ end end;if _ then x[#x+1]=string.char(z)end elseif j=="bmp"then x[1]="BM"
x[2]=string.char(0,0,0,0)x[3]=string.char(0,0,0,0,0x36,0,0,0,0x28,0,0,0)
x[4]=string.char(
self.width%256,o(self.width/256),0,0)
x[5]=string.char(self.height%256,o(self.height/256),0,0)x[6]=string.char(1,0,0x18,0,0,0,0,0)
x[7]=string.char(0,0,0,0)
x[8]=string.char(0x13,0x0B,0,0,0x13,0x0B,0,0,0,0,0,0,0,0,0,0)local z=math.ceil((self.width*3)/4)*4-
self.width*3
for E=self.height-1,0,-1 do
for T=0,self.width-1
do
x[#x+1]=string.char((
self.buffer[(E*self.width+T)*3+1]or 0)*255)
x[#x+1]=string.char((
self.buffer[(E*self.width+T)*3+2]or 0)*255)
x[#x+1]=string.char((
self.buffer[(E*self.width+T)*3+3]or 0)*255)end;x[#x+1]=("\0"):rep(z)end;local _=#a(x)
x[2]=string.char(_%256,o(_/256)%256,o(_/65536),0)_=_-54
x[7]=string.char(_%256,o(_/256)%256,o(_/65536),0)else error("format not supported")end;x=a(x)if q then local z=io.open(q,"wb")
for _=1,#x do z:write(x:byte(_))end;z:close()end;return x end
function t:drawLine(q,j,x,z,_,E,T)
if q==x then
q,j,x,z=q+self.ox,j+self.oy,x+self.ox,z+self.oy
if q<self.cx or q>=self.cx+self.cwidth then return end;if z<j then local A=j;j=z;z=A end;if j<self.cy then j=self.cy end
if z>=self.cy+
self.cheight then z=self.cy+self.cheight-1 end;if _ or self.overwrite then for A=j,z do
self.buffer[(A*self.width+q)*3+1]=_ end end;if E or
self.overwrite then for A=j,z do
self.buffer[(A*self.width+q)*3+2]=E end end;if T or
self.overwrite then for A=j,z do
self.buffer[(A*self.width+q)*3+3]=T end end elseif j==z then q,j,x,z=q+
self.ox,j+self.oy,x+self.ox,z+self.oy
if j<self.cy or j>=
self.cy+self.cheight then return end;if x<q then local A=q;q=x;x=A end;if q<self.cx then q=self.cx end
if x>=self.cx+
self.cwidth then x=self.cx+self.cwidth-1 end;if _ or self.overwrite then for A=q,x do
self.buffer[(j*self.width+A)*3+1]=_ end end;if E or
self.overwrite then for A=q,x do
self.buffer[(j*self.width+A)*3+2]=E end end;if T or
self.overwrite then for A=q,x do
self.buffer[(j*self.width+A)*3+3]=T end end else
local A=x-q;local O=A>0 and 1 or-1;A=2*math.abs(A)local I=z-j
local N=I>0 and 1 or-1;I=2*math.abs(I)self:drawPixel(q,j,_,E,T)
if A>=I then
local S=I-A/2
while q~=x do
if(S>=0)and((S~=0)or(O>0))then S=S-A;j=j+N end;S=S+I;q=q+O;self:drawPixel(q,j,_,E,T)end else local S=A-I/2
while j~=z do
if(S>=0)and((S~=0)or(N>0))then S=S-I;q=q+O end;S=S+A;j=j+N;self:drawPixel(q,j,_,E,T)end end end end
function t:drawRect(q,j,x,z,_,E,T)self:drawLine(q,j,q+x-1,j,_,E,T)
self:drawLine(q,j,q,j+z-1,_,E,T)self:drawLine(q+x-1,j,q+x-1,j+z-1,_,E,T)self:drawLine(q,
j+z-1,q+x-1,j+z-1,_,E,T)end
function t:fillRect(q,j,x,z,_,E,T)
q,j,x,z=b(q+self.ox,j+self.oy,x,z,self.cx,self.cy,self.cwidth,self.cheight)
if _ or self.overwrite then for A=0,z-1 do
for O=0,x-1 do self.buffer[
((A+j)*self.width+O+q)*3+1]=_ end end end
if E or self.overwrite then for A=0,z-1 do
for O=0,x-1 do self.buffer[
((A+j)*self.width+O+q)*3+2]=E end end end
if T or self.overwrite then for A=0,z-1 do
for O=0,x-1 do self.buffer[
((A+j)*self.width+O+q)*3+3]=T end end end end
function t:drawTriangle(q,j,x,z,_,E,T,A,O)self:drawLine(q,j,x,z,T,A,O)
self:drawLine(x,z,_,E,T,A,O)self:drawLine(_,E,q,j,T,A,O)end
function t:fillTriangle(q,j,x,z,_,E,T,A,O)if j>z then local F,W=q,j;q,j=x,z;x,z=F,W end
if j>E then local F,W=q,j;q,j=_,E;_,E=F,W end;if z>E then local F,W=x,z;x,z=_,E;_,E=F,W end
if j==z and q>x then local F=q;q=x;x=F end;if z==E and x>_ then local F=x;x=_;_=F end;local I,N
if q<=x then I=q+
(z-j)/ (E-j)* (_-q)N=z;local F,W=x,z;x,z=I,N;I,N=F,W else I=q+
(z-j)/ (E-j)* (_-q)N=z end;local S=(x-q)/ (z-j)local H=(I-q)/ (N-j)
local R=(_-x)/ (E-z)local D=(_-I)/ (E-N)local L,U,C,M
for F=math.ceil(j+0.5)-0.5,
math.floor(E-0.5)+0.5,1 do if F<=z then L=q+S* (F-j)U=q+H* (F-j)else
L=_-R* (E-F)U=_-D* (E-F)end;C,M=math.ceil(L-0.5),math.floor(
U-0.5)if C<=M then
self:drawLine(C,F-0.5,M,F-0.5,T,A,O)end end end
function t:drawEllipse(q,j,x,z,_,E,T)for A=0,d-1 do
self:drawLine(o(q+u[A+1]* (x-1)+0.5),o(j+l[A+1]*
(z-1)+0.5),o(
q+u[(A+1)%d+1]* (x-1)+0.5),o(
j+l[(A+1)%d+1]* (z-1)+0.5),_,E,T)end end
function t:fillEllipse(q,j,x,z,_,E,T)q,j=q+self.ox,j+self.oy;local A,O
for I=0,z-1 do
for N=0,x-1 do A,O=N+q,I+j
if


(
(N+0.5)/x*2-1)^2+ ((I+0.5)/z*2-1)^2 <=1 and A>=self.cx and A<
self.cx+self.cwidth and O>=self.cy and O<self.cy+self.cheight then if _ or self.overwrite then
self.buffer[(O*self.width+A)*3+1]=_ end
if E or self.overwrite then self.buffer[
(O*self.width+A)*3+2]=E end;if T or self.overwrite then
self.buffer[(O*self.width+A)*3+3]=T end end end end end
function t:drawArc(q,j,x,z,_,E,T,A,O)if _>E then local I=_;_=E;I=E end
_=o(_/math.pi/2*d+0.5)E=o(E/math.pi/2*d+0.5)-1
for I=_,E do
local N=I%d
self:drawLine(o(q+u[N+1]* (x-1)+0.5),o(
j+l[N+1]* (z-1)+0.5),o(q+u[(N+1)%d+1]* (x-1)+0.5),o(
j+l[(N+1)%d+1]* (z-1)+0.5),T,A,O)end end
function t:fillArc(q,j,x,z,_,E,T,A,O)q,j=q+self.ox,j+self.oy;if _>E then local L=_;_=E;L=E end
local I=E-_;_=_% (math.pi*2)local N,S,H,R,D
for L=0,z-1 do
for U=0,x-1 do N,S=(U+0.5)/x*2-1,
(L+0.5)/z*2-1;H,R=U+q,L+j
D=i(-S,N)% (math.pi*2)
if


N^2+S^2 <=1 and((D>=_ and D-_<=I)or
(D<= (_+I)% (math.pi*2)))and H>=self.cx and
H<self.cx+self.cwidth and R>=self.cy and R<self.cy+self.cheight then if T or self.overwrite then
self.buffer[(R*self.width+H)*3+1]=T end
if A or self.overwrite then self.buffer[
(R*self.width+H)*3+2]=A end;if O or self.overwrite then
self.buffer[(R*self.width+H)*3+3]=O end end end end end
function t:drawSurface(q,j,x,z,_,E,T,A,O)j,x,z,_,E,T,A,O=j+self.ox,x+self.oy,z or q.width,_ or q.height,E or 0,T or 0,A or q.width,O or
q.height
if z==A and _==O then local I,N
I,N,z,_=b(j,x,z,_,self.cx,self.cy,self.cwidth,self.cheight)A,O=z,_;if I>j then E=E+I-j;j=I end;if N>x then T=T+N-x;x=N end
I,N,A,O=b(E,T,A,O,0,0,q.width,q.height)z,_=A,O;if I>E then j=j+I-E;E=I end;if N>T then x=x+N-T;T=N end;local S,H,R
for D=0,_-1 do
for L=0,z-1 do
S=q.buffer[((
D+T)*q.width+L+E)*3+1]
H=q.buffer[((D+T)*q.width+L+E)*3+2]
R=q.buffer[((D+T)*q.width+L+E)*3+3]
if S or self.overwrite then self.buffer[
((D+x)*self.width+L+j)*3+1]=S end
if H or self.overwrite then self.buffer[
((D+x)*self.width+L+j)*3+2]=H end
if R or self.overwrite then self.buffer[
((D+x)*self.width+L+j)*3+3]=R end end end else local I,N=false,false;if z<0 then I=true;j=j+z end;if _<0 then N=true;x=x+_ end;if A<0 then
I=not I;E=E+A end;if O<0 then N=not N;T=T+O end
z,_,A,O=math.abs(z),math.abs(_),math.abs(A),math.abs(O)local S,H,R,D,L,U,C,M,F=A/z,O/_
for W=0,_-1 do
for Y=0,z-1 do
R,D=o((Y+0.5)*S),o((W+0.5)*H)if I then L=j+z-Y-1 else L=Y+j end;if N then U=x+_-W-1 else U=W+x end
if



L>=self.cx and L<self.cx+self.cwidth and U>=self.cy and U<self.cy+self.cheight and
R>=0 and R<q.width and D>=0 and D<q.height then C=q.buffer[(D*q.width+R)*3+1]M=q.buffer[(
D*q.width+R)*3+2]F=q.buffer[(D*
q.width+R)*3+3]if
C or self.overwrite then
self.buffer[(U*self.width+L)*3+1]=C end
if M or self.overwrite then self.buffer[
(U*self.width+L)*3+2]=M end;if F or self.overwrite then
self.buffer[(U*self.width+L)*3+3]=F end end end end end end
function t:drawSurfaceRotated(q,j,x,z,_,E)local T,A,O,I,N,S=math.sin(E),math.cos(E)
for H=math.floor(-q.height*0.75),math.ceil(
q.height*0.75)do
for R=math.floor(-q.width*0.75),math.ceil(q.width*0.75)
do
O,I,N,S=j+R,x+H,o(A* (R+0.5)-T* (H+0.5)+z),o(T*
(R+0.5)+A* (H+0.5)+_)
if


O>=self.cx and O<self.cx+self.cwidth and I>=self.cy and I<self.cy+self.cheight and N>=
0 and N<q.width and S>=0 and S<q.height then b=q.buffer[(S*q.width+N)*3+1]t=q.buffer[(
S*q.width+N)*3+2]c=q.buffer[(S*
q.width+N)*3+3]if
b or self.overwrite then
self.buffer[(I*self.width+O)*3+1]=b end
if t or self.overwrite then self.buffer[
(I*self.width+O)*3+2]=t end;if c or self.overwrite then
self.buffer[(I*self.width+O)*3+3]=c end end end end end
function t:drawSurfacesInterlaced(q,j,x,z)j,x,z=j+self.ox,x+self.oy,z or 0
local _,E=q[1].width,q[1].height
for D=2,#q do if q[D].width~=_ or q[D].height~=E then
error("surfaces should be the same size")end end
local T,A,O,I,N,S,H,R=b(j,x,_,E,self.cx,self.cy,self.cwidth,self.cheight)
for D=A,A+I-1 do
for L=T,T+O-1 do N=(L+D+z)%#q+1
S=q[N].buffer[(
(D-A)*q[N].width+L-T)*3+1]
H=q[N].buffer[((D-A)*q[N].width+L-T)*3+2]
R=q[N].buffer[((D-A)*q[N].width+L-T)*3+3]if S or self.overwrite then
self.buffer[(D*self.width+L)*3+1]=S end
if H or self.overwrite then self.buffer[
(D*self.width+L)*3+2]=H end;if R or self.overwrite then
self.buffer[(D*self.width+L)*3+3]=R end end end end
function t:drawSurfaceSmall(q,j,x)j,x=j+self.ox,x+self.oy;if q.width%2 ~=0 or
q.height%3 ~=0 then
error("surface width must be a multiple of 2 and surface height a multiple of 3")end
local z,_,E,T,A,O,I,N=32768
for S=0,q.height/3-1 do
for H=0,q.width/2-1 do
if H+j>=self.cx and
H+j<self.cx+self.cwidth and S+x>=self.cy and S+x<self.cy+
self.cheight then
_,E,T,A,O,I,N=0,q.buffer[((
S*3)*q.width+H*2)*3+1],q.buffer[((
S*3)*q.width+H*2+1)*3+1],q.buffer[((
S*3+1)*q.width+H*2)*3+1],q.buffer[((
S*3+1)*q.width+H*2+1)*3+1],q.buffer[((
S*3+2)*q.width+H*2)*3+1],q.buffer[((
S*3+2)*q.width+H*2+1)*3+1]if E~=N then z=E;_=1 end;if T~=N then z=T;_=_+2 end;if A~=N then z=A;_=_+4 end;if O~=N then z=O
_=_+8 end;if I~=N then z=I;_=_+16 end
self.buffer[(
(S+x)*self.width+H+j)*3+1]=N
self.buffer[((S+x)*self.width+H+j)*3+2]=z;self.buffer[((S+x)*self.width+H+j)*3+3]=h[
128+_]end end end end
function t:flip(q,j)local x,z,_,E,T,A,O
if q then
for I=0,math.ceil(self.cwidth/2)-1 do
for N=0,self.cheight-1
do
x,z,_,E=I+self.cx,N+self.cy,self.cx+self.cwidth-I-1,N+self.cy
T=self.buffer[(z*self.width+x)*3+1]
A=self.buffer[(z*self.width+x)*3+2]
O=self.buffer[(z*self.width+x)*3+3]
self.buffer[(z*self.width+x)*3+1]=self.buffer[(
E*self.width+_)*3+1]
self.buffer[(z*self.width+x)*3+2]=self.buffer[(
E*self.width+_)*3+2]
self.buffer[(z*self.width+x)*3+3]=self.buffer[(
E*self.width+_)*3+3]
self.buffer[(E*self.width+_)*3+1]=T
self.buffer[(E*self.width+_)*3+2]=A
self.buffer[(E*self.width+_)*3+3]=O end end end
if j then
for I=0,math.ceil(self.cheight/2)-1 do
for N=0,self.cwidth-1 do
x,z,_,E=N+self.cx,
I+self.cy,N+self.cx,self.cy+self.cheight-I-1
T=self.buffer[(z*self.width+x)*3+1]
A=self.buffer[(z*self.width+x)*3+2]
O=self.buffer[(z*self.width+x)*3+3]
self.buffer[(z*self.width+x)*3+1]=self.buffer[(
E*self.width+_)*3+1]
self.buffer[(z*self.width+x)*3+2]=self.buffer[(
E*self.width+_)*3+2]
self.buffer[(z*self.width+x)*3+3]=self.buffer[(
E*self.width+_)*3+3]
self.buffer[(E*self.width+_)*3+1]=T
self.buffer[(E*self.width+_)*3+2]=A
self.buffer[(E*self.width+_)*3+3]=O end end end end
function t:shift(q,j,x,z,_)local E,T=q<0,j<0
local A,O=self.cx,self.cx+self.cwidth-1;local I,N=self.cy,self.cy+self.cheight-1;local S,H
for R=T and I or N,
T and N or I,T and 1 or-1 do
for D=E and A or O,E and O or A,E and 1 or-1 do S,H=D-q,R-j
if S>=0 and S<
self.width and H>=0 and H<self.height then
self.buffer[(
R*self.width+D)*3+1]=self.buffer[(
H*self.width+S)*3+1]
self.buffer[(R*self.width+D)*3+2]=self.buffer[(
H*self.width+S)*3+2]
self.buffer[(R*self.width+D)*3+3]=self.buffer[(
H*self.width+S)*3+3]else
self.buffer[(R*self.width+D)*3+1]=x
self.buffer[(R*self.width+D)*3+2]=z
self.buffer[(R*self.width+D)*3+3]=_ end end end end
function t:map(q)local j
for x=self.cy,self.cy+self.cheight-1 do
for z=self.cx,self.cx+self.cwidth-
1 do
j=q[self.buffer[(x*self.width+z)*3+1]]if j or self.overwrite then
self.buffer[(x*self.width+z)*3+1]=j end end end end;e.palette={}
e.palette.cc={[1]="F0F0F0",[2]="F2B233",[4]="E57FD8",[8]="99B2F2",[16]="DEDE6C",[32]="7FCC19",[64]="F2B2CC",[128]="4C4C4C",[256]="999999",[512]="4C99B2",[1024]="B266E5",[2048]="3366CC",[4096]="7F664C",[8192]="57A64E",[16384]="CC4C4C",[32768]="191919"}
e.palette.riko4={"181818","1D2B52","7E2553","008651","AB5136","5F564F","7D7F82","FF004C","FFA300","FFF023","00E755","29ADFF","82769C","FF77A9","FECCA9","ECECEC"}e.palette.redirection={[0]="040404",[1]="FFFFFF"}
local function g(q)
if q==m then return end;m=q;f,w,y,p={},{},{},{}local j={}
for O,I in pairs(m)do
if type(I)=="string"then w[O]=
tonumber(I:sub(1,2),16)/255
y[O]=tonumber(I:sub(3,4),16)/255;p[O]=tonumber(I:sub(5,6),16)/255 elseif
type(I)=="number"then w[O]=math.floor(I/65536)/255;y[O]=(
math.floor(I/256)%256)/255
p[O]=(I%256)/255 end;j[#j+1]=O end;local x,z,_,E,T,A
for O=0,c-1 do
for I=0,c-1 do
for N=0,c-1 do x=(O+0.5)/c;z=(I+0.5)/c;_=(N+0.5)/c
E=1e10
for S=1,#j do T=(x-w[j[S]])^2+ (z-y[j[S]])^2+
(_-p[j[S]])^2;if T<E then E=T;A=S end end;f[O*c*c+I*c+N+1]=j[A]end end end end
function t:toRGB(q)g(q)local j
for x=0,self.height-1 do
for z=0,self.width-1 do j=self.buffer[
(x*self.width+z)*3+1]
self.buffer[(
x*self.width+z)*3+1]=w[j]
self.buffer[(x*self.width+z)*3+2]=y[j]
self.buffer[(x*self.width+z)*3+3]=p[j]end end end
function t:toPalette(q,j)g(q)local x,z,_,E,T,A,O,I,N,S,H=c-1
for R=0,self.height-1 do
for D=0,self.width-1 do z=self.buffer[(
R*self.width+D)*3+1]
_=self.buffer[(
R*self.width+D)*3+2]
E=self.buffer[(R*self.width+D)*3+3]z=(z>1)and 1 or z;z=(z<0)and 0 or z
_=(_>1)and 1 or _;_=(_<0)and 0 or _;E=(E>1)and 1 or E
E=(E<0)and 0 or E;T=(z==1)and x or o(z*c)
A=(_==1)and x or o(_*c)O=(E==1)and x or o(E*c)
I=f[T*c*c+A*c+O+1]
if j then N=(z-w[I])/16;S=(_-y[I])/16;H=(E-p[I])/16
if D<
self.width-1 then self.buffer[(R*self.width+D+1)*3+1]=
self.buffer[(
R*self.width+D+1)*3+1]+N*7;self.buffer[(R*
self.width+D+1)*3+2]=
self.buffer[(
R*self.width+D+1)*3+2]+S*7;self.buffer[(R*
self.width+D+1)*3+3]=
self.buffer[(
R*self.width+D+1)*3+3]+H*7 end
if R<self.height-1 then
if D>0 then
self.buffer[
((R+1)*self.width+D-1)*3+1]=self.buffer[(
(R+1)*self.width+D-1)*3+1]+N*3;self.buffer[((R+1)*self.width+D-1)*3+2]=
self.buffer[((
R+1)*self.width+D-1)*3+2]+S*3;self.buffer[((
R+1)*self.width+D-1)*3+3]=
self.buffer[((
R+1)*self.width+D-1)*3+3]+H*3 end;self.buffer[((R+1)*self.width+D)*3+1]=
self.buffer[((
R+1)*self.width+D)*3+1]+N*5;self.buffer[(
(R+1)*self.width+D)*3+2]=
self.buffer[((
R+1)*self.width+D)*3+2]+S*5;self.buffer[(
(R+1)*self.width+D)*3+3]=
self.buffer[((
R+1)*self.width+D)*3+3]+H*5
if D<
self.width-1 then
self.buffer[
((R+1)*self.width+D+1)*3+1]=self.buffer[
((R+1)*self.width+D+1)*3+1]+N*1;self.buffer[((R+1)*self.width+D+1)*3+2]=
self.buffer[((
R+1)*self.width+D+1)*3+2]+S*1;self.buffer[((
R+1)*self.width+D+1)*3+3]=
self.buffer[((
R+1)*self.width+D+1)*3+3]+H*1 end end end
self.buffer[(R*self.width+D)*3+1]=I
self.buffer[(R*self.width+D)*3+2]=nil
self.buffer[(R*self.width+D)*3+3]=nil end end end
function e.loadFont(t)local q={width=t.width,height=t.height-1}q.buffer={}
q.indices={0}q.widths={}
local j,x,z=t.buffer[((t.height-1)*t.width)*3+1]for E=0,t.width-1 do z=t.buffer[
((t.height-1)*t.width+E)*3+1]
if z~=j then x=z;break end end;for E=0,t.height-2 do
for T=0,t.width-1 do q.buffer[E*
q.width+T+1]=
t.buffer[(E*t.width+T)*3+1]==x end end;local _=1
for E=0,t.width-1 do if
t.buffer[((
t.height-1)*t.width+E)*3+1]==x then q.widths[_]=E-q.indices[_]_=_+1;q.indices[_]=
E+1 end end;q.widths[_]=q.width-q.indices[_]return q end
function e.getTextSize(q,j)local x,z,_=0,0,0;local E,T=x
for A=1,#q do T=q:byte(A)-31
if T+31 ==10 then x=E
z=z+j.height+1 elseif j.indices[T]then x=x+j.widths[T]+1 else x=x+j.widths[1]end;if x>_ then _=x end end;return _-1,z+j.height end
function t:drawText(q,j,z,_,E,T,A)local x,O=z+self.ox,_+self.oy;local I,N,S=x
for H=1,#q do N=q:byte(H)-31
if
N+31 ==10 then x=I;O=O+j.height+1 elseif j.indices[N]then
for H=0,j.widths[N]-1 do
for R=0,j.height-1 do z,_=x+H,
O+R
if
j.buffer[R*j.width+H+j.indices[N]+1]then
if
z>=self.cx and z<self.cx+self.cwidth and _>=self.cy and _<self.cy+self.cheight then S=(
_*self.width+z)*3;if E or self.overwrite then self.buffer[
S+1]=E end;if T or self.overwrite then
self.buffer[S+2]=T end
if A or self.overwrite then self.buffer[S+3]=A end end end end end;x=x+j.widths[N]+1 else x=x+j.widths[1]end end end;local k={}e.smap=k
function e.loadSpriteMap(t,q,j,x)if t.width%q~=0 or t.height%j~=0 then
error("sprite width/height does not match smap width/height")end
local k=setmetatable({},{__index=e.smap})k.surf=t;k.spwidth=q;k.spheight=j;k.sprites=x or
((t.width/q)* (t.height/j))k.perline=t.width/q;return k end
function k:pos(q,j)if q<0 or q>=self.sprites then
error("sprite index out of bounds")end
return
(q%self.perline)*self.spwidth,math.floor(q/self.perline)*self.spheight end
function k:sprite(q,j,x,z,_)local E,T=self:pos(q)return self.surf,j,x,z or self.spwidth,_ or self.spheight,E,T,
self.spwidth,self.spheight end end;return e