import tkinter as tk
from PIL import ImageTk,Image
import pandas as pd 
import random
from tkinter import messagebox

w = tk.Tk()
w.title("더 인기, 더 팔로워")
w.geometry("1800x950")



df = pd.read_csv("follower.csv",encoding='CP949')


#r1 이랑 r2랑 복수검사
    
def more():
    global r1
    global r2
    global stop
    
    if(df['팔로워수'][r1]>df['팔로워수'][r2]):

        r1 = r2
        r2 = random.randint(0,20)
        messagebox.showinfo("정답","맞았어요~ 당신도 혹시 인기쟁이?^^")
        w.quit()
    else:
        messagebox.showinfo("땡","땡 틀렸습니다~ 아쉽네요 다음엔 맞춰봐요!^^")
        w.quit()
    

def less():
    global r1
    global r2
    global stop
    
    if(df['팔로워수'][r1]<df['팔로워수'][r2]):
        r1 = r2
        r2 = random.randint(0,20)
        messagebox.showinfo("정답","맞았어요~ 당신도 혹시 인기쟁이?^^")
        w.quit()
    else:
        messagebox.showinfo("땡","땡 틀렸습니다~ 아쉽네요 다음엔 맞춰봐요!^^")
        w.quit()
    

while 1:
    r1 = random.randint(0,20)
    r2 = random.randint(0,20)
    check = 1
    stop = 0
    while check:
        if(r1 == r2):
            r2= random.randint(0,20)
        else:
            check = 0

#테스트
#print(df['이름'])

#인물 왼쪽 
    figure1 = tk.Frame(w)
    figure1.grid(row=0, column=0, sticky=tk.W)

    name1 = tk.Label(figure1,text=df['이름'][r1])
    name1.grid(row=0,column=1)



    img1 = ImageTk.PhotoImage(file=f"{r1}.png")
    widget1 = tk.Label(figure1, image=img1).grid(row=0,column=0)

#인물오른쪽
    figure2 = tk.Frame(w)
    figure2.grid(row=0, column=1, sticky=tk.E)

    name2 = tk.Label(figure2,text=df['이름'][r2])
    name2.grid(row=0,column=0)

    img2 = ImageTk.PhotoImage(file=f"{r2}.png")
    
    widget2 = tk.Label(figure2, image=img2).grid(row=0,column=1)

#버튼
    button_frame = tk.Frame(w)
    button_frame.grid(row=1, column=0, sticky=tk.S)
    b1 = tk.Button(button_frame, text="더 많이", command=more).grid(row=0,column=0)
    b2 = tk.Button(button_frame, text="더 적게", command=less).grid(row=0,column=1)
#b1_e,b2_e = tk.IntVar(), tk.IntVar()
    while stop:
        print("")
    w.mainloop()
