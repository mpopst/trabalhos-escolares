#Trabalho desenvolvido com o software Processing para o curso de Modelagem Matemática 2, em Outubro de 2017, 
#em conjunto com @viguardieiro para a disciplina do #professor Paulo Cezar.
Origem = PVector(50, 550)
v = PVector(0,0)
Bola = PVector(Origem.x, Origem.y)
t0 = 1
k=True
meta = 0
H = 350
d = 700
Arremecos = 0
Cestas = 0
l = False
ch = True
C = [1, 2]

class bola:
    def __init__(self):
        self.x = Origem.x
        self.y = Origem.y
        self.cor = 0
        self.diametro = 25
    def acerta(self):
        self.cor = 1
    def move(self, x, y):
        self.x = x
        self.y=y
    def desenha(self):
        stroke(0,0,0)
        if self.cor==0:
            fill(255, 83, 13)
        else:
            fill(95,148,198)
        ellipse(self.x,self.y,self.diametro,self.diametro)
    
B = [bola()]

def setup():
    size(1000, 600)  
        
def draw():
    global Bola, k, v, t0, meta, Arremecos, Cestas, l, B, ch, C
    background(0,230,230)
    img = loadImage("wooden.jpg")
    for i in range(4):
        image(img, i*250, 500)
    textSize(20)
    text("Arremecos: "+str(Arremecos), 100, 100)
    text("Cestas: "+str(Cestas), 100, 120)
    if k:
        l = False
        xz, yz = mouseX , mouseY
        modu = ((xz-Origem.x)**2 + (yz-Origem.y)**2 )**0.5
        if modu > 400:
            xzao, yzao = (400*(xz-Origem.x)/modu) +Origem.x, (400*(yz-Origem.y)/modu) +Origem.y
            modu = 400
        else:
            xzao, yzao = xz, yz
        line(Origem.x, Origem.y, xzao, yzao)
        stroke(255, 0, 0)
        textSize(12)
        text(str(modu), 50, 525)
        if mousePressed:
            Arremecos += 1
            k = False
            v = PVector(xzao - Origem.x, -yzao + Origem.y)
            v = v*0.5
            t0 = millis()/100.0
            meta = v.y/9.8
            ch = True
    else:
        t = (millis()/100.0-t0)
        C = [C[1], B[-1].y]
        if l:
            B[-1].move(Bola.x - v.x * t, Bola.y + v.y * t + 4.9*t**2)
        else:
            B[-1].move(Origem.x + v.x * t, y = Origem.y - v.y * t + 4.9*t**2)
            if B[-1].x>=d+45 and B[-1].x<=d+80 and B[-1].y>180 and B[-1].y<265:
                l=True
                Bola.x, Bola.y =B[-1].x, B[-1].y
                t0 = millis()/100.0
        if ch and (l or t>meta) and abs(H-100-B[-1].y)<30 and B[-1].x-d> 0 and (B[-1].x-d)<70 and C[1]>C[0]:
            print("Cesta!")
            B[-1].acerta()
            ch = False
            Cestas+=1
        if B[-1].x>1025 or B[-1].x<0 or B[-1].y>550:
            B[-1].move(B[-1].x, 550)
            B.append(bola())
            k = True
    for a in B:
        a.desenha()
    cesta()
    
def cesta():
    #Aro
    stroke(0, 0, 0)
    fill(255,0,0)
    rect(d, 600-H, 45, 5)
    rect(d+45, 600-H+1, 5, 2)
    #Rede da cesta
    line(d, 600-H+3, d+10, 600-H+30)
    line(d+10, 600-H+30, d+35, 600-H+30)
    line(d+45, 600-H+3, d+35, 600-H+30)
    #Apoio
    fill(100,100,100)
    rect(d+53, 225, 50, 5)
    rect(d+103, 225, 5, 345)
    #Tabela
    fill(0,0,0)
    rect(d+50, 600-415, 10, 80)
