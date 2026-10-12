from pathlib import Path
from reportlab.pdfgen import canvas
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.colors import HexColor
from reportlab.platypus import Paragraph
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.utils import ImageReader
from PIL import Image
import pypdfium2 as pdfium
from pypdf import PdfReader

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'output/pdf'; A=OUT/'skala-assets'; R=A/'redesign'; R.mkdir(exist_ok=True)
PDF=OUT/'정혜원_Pre-SKALA_포트폴리오_키워드삭제.pdf'
F=A/'fonts'
pdfmetrics.registerFont(TTFont('K',str(F/'Pretendard-Regular.ttf')))
pdfmetrics.registerFont(TTFont('KB',str(F/'Pretendard-Bold.ttf')))
pdfmetrics.registerFont(TTFont('KX',str(F/'Pretendard-ExtraBold.ttf')))
pdfmetrics.registerFont(TTFont('AB',str(F/'Pretendard-Black.ttf')))
W,H=960,600
BG='#EEEDEB'; WHITE='#FFFFFF'; INK='#111111'; GRAY='#60605E'; GREEN='#BCEB77'; DEEP='#466622'
c=canvas.Canvas(str(PDF),pagesize=(W,H)); c.setTitle('정혜원 | Pre-SKALA 포트폴리오'); c.setAuthor('정혜원')
n=0

def box(x,y,w,h,fill=WHITE,r=22):
    c.setFillColor(HexColor(fill)); c.roundRect(x,H-y-h,w,h,r,stroke=0,fill=1)
def txt(s,x,y,w,size=18,color=INK,bold=False,maxh=None,align=0):
    p=Paragraph(s,ParagraphStyle('x',fontName=('KX' if size>=24 else 'KB') if bold else 'K',fontSize=size,leading=size*1.38,textColor=HexColor(color),wordWrap='CJK',alignment=align))
    _,h=p.wrap(w,1000)
    if maxh is not None and h>maxh+.1: raise ValueError(f'page {n} text overflow {h}>{maxh}: {s[:60]}')
    if y+h>565: raise ValueError(f'page {n} footer collision: {s[:60]}')
    p.drawOn(c,x,H-y-h); return h
def rule(x,y,w):
    c.setStrokeColor(HexColor('#D9D9D6')); c.setLineWidth(.7); c.line(x,H-y,x+w,H-y)
def pill(s,x,y,w=120,h=27,filled=True,green=False,size=12,url=None):
    fill=GREEN if green else INK
    c.setFillColor(HexColor(fill if filled else WHITE)); c.setStrokeColor(HexColor(INK)); c.setLineWidth(1)
    c.roundRect(x,H-y-h,w,h,h/2,stroke=0 if filled else 1,fill=1)
    c.setFont('KB',size); c.setFillColor(HexColor(INK if green or not filled else WHITE))
    c.drawCentredString(x+w/2,H-y-h/2-size*.34,s)
    if url: c.linkURL(url,(x,H-y-h,x+w,H-y),relative=0,thickness=0)
def dot(x,y):
    c.setFillColor(HexColor(GREEN)); c.circle(x,H-y,4,stroke=0,fill=1)
def heading(s,x,y,w,size=25):
    dot(x-10,y+12); txt(s,x,y,w,size,bold=True,maxh=75)
def image(path,x,y,w,h,crop=None,r=12):
    im=Image.open(path).convert('RGB')
    if crop: im=im.crop(crop)
    iw,ih=im.size; scale=min(w/iw,h/ih); dw,dh=iw*scale,ih*scale
    c.saveState(); p=c.beginPath(); p.roundRect(x,H-y-h,w,h,r); c.clipPath(p,stroke=0)
    c.setFillColor(HexColor('#F8F8F7')); c.rect(x,H-y-h,w,h,stroke=0,fill=1)
    c.drawImage(ImageReader(im),x+(w-dw)/2,H-y-(h-dh)/2-dh,dw,dh)
    c.restoreState()
def page():
    global n
    if n: c.showPage()
    n+=1
    c.radialGradient(895 if n%2 else 40,585,460,[HexColor('#E0F1C9'),HexColor(BG)],[0,1])
    for j in range(3):
        c.setFillColor(HexColor(WHITE if j==0 else '#D5D6D1')); c.circle(28+j*13,H-17,3.4,stroke=0,fill=1)
    c.setFont('K',10); c.setFillColor(HexColor(GRAY)); c.drawString(28,25,'정혜원  /  PRE-SKALA')
    c.setFont('K',10); c.setFillColor(HexColor(GRAY)); c.drawRightString(932,25,f'{n:02d} / 14')
def top(label,title,sub=None):
    pill(label,28,46,125)
    heading(title,174,43,755,30)
    if sub: txt(sub,174,91,740,17,GRAY,maxh=48)
def badges(items,x,y,w=254):
    for i,s in enumerate(items): pill(s,x,y+i*34,w,27,filled=i%2==1,size=12)
def arrow(x,y): txt('→',x,y,28,20,DEEP,bold=True)
def links(y,project,live=None):
    pill('GitHub ↗',50,y,116,url=project)
    if live: pill('결과물 보기 ↗',180,y,140,filled=False,url=live)

# 01 / Reference-inspired cover.
page()
txt('hyewon5617@naver.com',675,40,255,15,GRAY)
txt('github.com/hyewang5617',675,67,255,15,GRAY)
c.setFont('AB',76); c.setFillColor(HexColor(INK)); c.drawCentredString(480,310,'PORTFOLIO')
txt('불편을 발견하고, 데이터와 소프트웨어로 해결하는',96,323,768,24,bold=True,maxh=60,align=1)
txt('개발자 정혜원입니다.',96,365,768,27,bold=True,align=1)
txt('Pre-SKALA 2026 지원 포트폴리오',96,437,768,14,GRAY,align=1)

# 02 / Identity card and capability panels; no invented proficiency metrics.
page(); box(24,38,912,211)
txt('직접 겪은 불편을<br/>기획과 구현으로 해결하는<br/><font color="#466622">개발자 정혜원</font>입니다.',58,68,440,31,bold=True,maxh=145)
c.saveState()
portrait_clip=c.beginPath(); portrait_clip.circle(574,H-142,53)
c.clipPath(portrait_clip,stroke=0)
# Position the unchanged source photo within a circular PDF viewport.
portrait=Image.open(A/'profile.jpg')
portrait_scale=106/912
c.drawImage(ImageReader(portrait),521-120*portrait_scale,
            H-(89-30*portrait_scale)-portrait.height*portrait_scale,
            portrait.width*portrait_scale,portrait.height*portrait_scale)
c.restoreState()
txt('정혜원',655,78,230,28,bold=True)
txt('학생회 기획부장<br/>신문사 뉴미디어 기자·부장',655,117,250,16,GRAY,maxh=45)
txt('hyewon5617@naver.com',655,172,250,15)
pill('전체 프로젝트 ↗',655,199,225,filled=False,url='https://hyewang5617.github.io/Portfolio/')
box(24,270,912,272)
heading('Core Competencies',57,291,600,28)
for i,(a,b,d) in enumerate([
 ('문제를 직접 정의','신문사에서 발견한 불편','메뉴담기와 기사찾기를 직접 기획하고, 실제 업무에 활용했습니다.'),
 ('구현 규칙을 설계','사용자와 데이터의 경계','Sportly에서 인증·알림 소유자 조건과 평점 갱신 로직을 구현했습니다.'),
 ('AI를 동작으로 연결','인식 결과를 사용자 입력으로','손 좌표를 가공해 게임의 쥐기·썰기·젓기·뒤집기 입력으로 연결했습니다.')]):
    x=57+i*295
    if i: rule(x-16,337,0)
    pill(a,x,339,260)
    txt(b,x,387,265,20,bold=True,maxh=58)
    txt(d,x,439,265,18,GRAY,maxh=90)

# 03 / Project journey instead of invented academic credentials.
page(); box(24,38,293,504); box(333,38,603,504)
heading('활동 연혁',54,67,225,26)
txt('서울과학기술대학교',54,114,229,18,GRAY)
for yy,date,org,role in [
    (167,'2024.03 - 2024.12','컴퓨터공학과 학생회','Airdrop 기획부원'),
    (290,'2025.01 - 2025.12','컴퓨터공학과 학생회','Well com 기획부장'),
    (413,'2025.03 - 2026.07','한글신문사','뉴미디어 기자·부장')]:
    txt(date,54,yy,231,16,DEEP,bold=True)
    txt(org,54,yy+34,231,17,GRAY)
    txt(role,54,yy+68,231,20,bold=True,maxh=57)
    if yy<400: rule(54,yy+104,227)
heading('프로젝트 타임라인',371,68,500,27)
milestones=[('2025.03','메뉴담기','신문사 주문 관리 서비스 기획·배포'),('2025','Sportly','팀장 / 인증·평점·알림 API 개발'),('2026.05','기사찾기','기사 데이터와 검색·시각화 구현'),('2026','Cooking Papa','손동작 인식 기반 게임 입력 구현')]
c.setStrokeColor(HexColor('#D7E6C2')); c.setLineWidth(2); c.line(383,H-143,383,H-489)
for i,(date,title,desc) in enumerate(milestones):
    y=141+i*94; dot(383,y+12)
    txt(date+'  |  '+title,409,y,485,23,bold=True)
    txt(desc,409,y+42,470,19,GRAY,maxh=58)

# 04 / Project overview: tall left panel, large image above problem/solution panel.
page(); box(24,38,288,504); box(330,38,606,257); box(330,313,606,229)
pill('Project 01',49,65,124)
heading('Sportly',51,111,233,33)
txt('2025 · 팀 프로젝트<br/>팀장 / 백엔드 개발',51,163,233,17,GRAY,maxh=65)
txt('축구 팀의 가입과<br/>경기 매칭을 돕는<br/>서비스를 기획했습니다.',51,250,233,23,bold=True,maxh=130)
txt('인증·전화번호 인증·평점·알림 API를 담당하고, 회의와 회의록을 정리했습니다.',51,375,233,19,maxh=114)
pill('GitHub ↗',51,494,230,url='https://github.com/soccerteam-matchapp/backend')
image(ROOT/'images/sportly-teams.png',348,55,570,209)
txt('실제 Swagger 문서: 팀 관리와 평점 API · 클릭하면 문서 열기',352,269,540,13,GRAY)
c.linkURL('https://port-0-sportly-mg82ro7fce364845.sel3.cloudtype.app/api-docs/',(348,H-295,918,H-55),relative=0,thickness=0)
heading('서비스 목표',358,338,260,21)
txt('팀 가입·경기 신청과 수락을<br/>하나의 흐름으로 관리',358,379,249,19,maxh=95)
heading('직접 구현',650,338,255,21)
txt('JWT 인증, 평점·알림<br/>Swagger 문서화와 서버 배포',650,379,253,19,maxh=95)
pill('Node.js · TypeScript',358,487,260,filled=False,size=13)
pill('Express · MongoDB',643,487,261,size=13)

# 05 / Technical details: three result cards and real pseudocode.
page(); pill('Project 01',416,40,128)
heading('Sportly | 구현한 규칙과 경계',263,83,640,31)
cards=[
 ('01','인증과 입력 검증','JWT 서명·만료를 검증하고 사용자 ID를 요청에 전달했습니다. 전화번호 인증에는 만료와 시도 횟수 제한을 적용했습니다.',['JWT 인증 미들웨어','인증번호 5분 만료'], 'Bearer token\n↓\nreq.userId'),
 ('02','알림의 소유자 확인','알림 ID와 인증된 사용자 ID를 함께 조회 조건에 넣었습니다. 다른 사용자의 알림을 변경할 수 없도록 범위를 제한했습니다.',['본인 알림만 조회','본인 알림만 읽음 처리'], 'notificationId\n+ userId\n→ findOne'),
 ('03','평점 수정과 집계','신규 평가에서는 합계·개수를 늘리고, 수정에서는 점수 차이만 반영했습니다. 자기 팀 평가와 점수 범위도 검증했습니다.',['신규 / 수정 분리','수정 시 개수 유지'], 'delta = new - old\nsum += delta\navg = sum / count')]
for i,(num,title,body,tags,code) in enumerate(cards):
    x=24+i*310; box(x,147,292,395)
    txt(num,x+22,169,70,28,bold=True)
    txt(title,x+22,213,250,23,bold=True,maxh=70)
    txt(body,x+22,257,246,18,GRAY,maxh=141)
    badges(tags,x+22,396,248)
    txt(code.replace('\n','<br/>'),x+27,471,240,14,DEEP,maxh=66)

# 06 / Architecture and actual delivery boundary.
page(); top('Project 01','요청부터 데이터까지, 처리 흐름을 분리했습니다.','Node.js · TypeScript · Express · Mongoose · MongoDB · Swagger')
box(24,162,912,156)
nodes=[('요청','Bearer token'),('인증','사용자 식별'),('Controller','입력·응답 처리'),('Service','업무 규칙'),('MongoDB','조회·저장')]
for i,(a,b) in enumerate(nodes):
    x=48+i*176; box(x,190,160,100,'#F3F6EE',14)
    txt(a,x+14,207,136,21,bold=True,maxh=42); txt(b,x+14,251,137,14,GRAY)
    if i<4: arrow(x+161,225)
box(24,336,440,206); box(480,336,456,206)
heading('협업과 문서화',52,360,377,23)
txt('팀장으로 회의와 진행 상황을 정리하고, API 문서로 연동 사항을 공유했습니다. UX/UI 디자인은 선배의 도움을 받아 구체화했습니다.',52,404,379,19,maxh=130)
heading('협업에서 배운 점',508,360,394,23)
txt('프론트 구현 지연과 시험기간으로 연동을 마무리하지 못했습니다. 자율 진행에만 맡긴 점을 돌아보며, 정기 대면 점검·중간 시연·조기 연동 일정의 필요성을 배웠습니다.',508,404,394,18,maxh=130)

# 07 / Article: target / problem / response panel layout.
page(); top('Project 02','서울과기대신문사 기사찾기','2026년 5월 · 개인 프로젝트 · 기획 / 데이터 처리 / 검색 화면 / 시각화')
cols=[('사용자','신문사 기자','기획회의와 기사 작성 중<br/>과거 기사를 찾아야 했습니다.'),('발견한 문제','관련 기사 탐색의 불편','원하는 기사를 찾기 어렵고,<br/>내용을 확인하려면 원문을<br/>하나씩 열어야 했습니다.'),('구현한 해결','관련도와 유사도 시각화','빈도는 노드 크기에,<br/>기사 간 유사도는 연결선에<br/>반영했습니다.')]
for i,(k,t,b) in enumerate(cols):
    x=24+i*310; box(x,155,292,387)
    heading(k,x+28,180,236,23); txt(t,x+28,229,239,22,bold=True,maxh=70)
    txt(b,x+28,292,238,18,GRAY,maxh=108)
    if i<2:
        box(x+24,390,244,117,'#F3F6EE',12)
        txt('기획회의 → 과거 기사' if i==0 else '검색 → 원문 개별 확인',x+39,414,214,19,bold=True,maxh=55)
        txt('관련 자료 탐색' if i==0 else '내용 확인에 반복 작업',x+39,459,214,16,DEEP,maxh=36)
    else:
        image(A/'article.png',x+24,390,244,117,crop=(375,180,1920,1000))
    pill(['업무 문제 정의','기획·개발 담당','Python · D3.js'][i],x+24,510,244,23,filled=i==1,size=12)

# Article detail: large screenshot, independently viewable original.
page(); top('Project 02','기사찾기 | 실제 검색 화면')
box(24,112,912,430)
image(A/'article.png',44,128,872,379,crop=(375,180,1920,1000))
txt('관련도: 노드 크기  /  유사도: 기사 연결선  /  키워드 미리보기 후 원문으로 이동',52,518,855,15,GRAY)
c.linkURL('https://hyewang5617.github.io/Search-for-articles-of-seoultech/',(44,H-507,916,H-128),relative=0,thickness=0)

# Article results: left feature block, right compact result rows.
page(); pill('Project 02',416,40,128); heading('기획회의와 후속 기사 작성에 활용됐습니다.',177,83,760,30)
box(24,151,418,391)
txt('1,166',56,177,330,62,bold=True)
txt('629~715호 기사 데이터',57,257,343,24,bold=True)
txt('기자 1명에게서<br/>서비스를 잘 사용하고 있다는<br/>피드백을 받았습니다.',57,318,343,21,maxh=115)
pill('기사찾기 서비스 보기 ↗',57,416,343,24,filled=False,url='https://hyewang5617.github.io/Search-for-articles-of-seoultech/')
rule(57,449,342)
txt('구현한 기능이 기자의<br/>실제 업무에 쓰였습니다.',57,471,343,18,GRAY,maxh=64)
for i,(title,body,tag) in enumerate([
 ('기획회의의 참고 자료','기획안에 참고할 과거 기사를 찾아 제시하는 데 활용됐습니다.','기획안 작성'),
 ('후속 기사 작성 지원','앞선 보도를 찾아 맥락을 확인하고 후속 기사를 준비하는 데 도움이 됐습니다.','기존 보도 탐색'),
 ('기자의 자료 탐색 지원','기사 작성에 참고할 과거 보도를 검색하는 데 활용됐습니다.','취재·작성 참고 자료')]):
    y=151+i*134; box(460,y,476,123)
    txt(title,485,y+15,426,22,bold=True)
    txt(body,485,y+48,423,16,GRAY,maxh=44.2)
    pill(tag,485,y+92,185,22,filled=i==1,size=11)

# 09 / Cooking: screen and three compact implementation cards.
page(); top('Project 03','Cooking Papa | 손동작을 게임 조작으로','2026 · 개인 프로젝트 · Python / OpenCV / MediaPipe / NumPy / Pygame')
box(24,152,912,174); image(A/'cooking.png',46,168,869,136)
txt('실제 게임 화면: 손을 쥐어 버튼과 도구를 선택 · 클릭하면 플레이 영상',46,308,840,12,GRAY)
c.linkURL('https://youtu.be/rqzNLpTx-Jo',(46,H-326,915,H-168),relative=0,thickness=0)
for i,(k,t,b) in enumerate([
 ('입력 데이터','21개 손 랜드마크','위치·속도·쥐기를 HandState로 가공해 게임 입력으로 연결했습니다.'),
 ('상호작용','조리 동작 판정','잡기·썰기·젓기·뒤집기에 다른 판정 규칙을 적용해 손 움직임을 조리 과정으로 변환했습니다.'),
 ('직접 구현','인식과 플레이를 연결','손 인식 결과를 가공하고, 손 아바타·판정 위치·도구 조작의 연결을 구현했습니다.')]):
    x=24+i*310; box(x,342,292,200)
    pill(k,x+24,362,244,24,size=12)
    txt(t,x+24,402,244,21,bold=True,maxh=62)
    txt(b,x+24,447,244,17,GRAY,maxh=85)

# 10 / Cooking troubleshooting, preserving the technical depth of the first version.
page(); top('Project 03','손 좌표를 그대로 쓰지 않았습니다.','인식 결과 → 입력 상태 → 동작 판정 → 게임 상호작용')
box(24,154,440,388); box(480,154,456,388)
heading('보이는 손과 판정 위치 일치',53,181,377,24)
txt('손 아바타와 실제 상호작용 기준점이 달라 조작이 어긋나는 문제가 있었습니다.',53,242,378,20,maxh=110)
pill('해결 방법',53,334,376,27)
txt('21개 랜드마크의 중심점을 화면상 손 위치로 사용해, 아바타와 판정의 기준점을 맞췄습니다.',53,382,378,20,maxh=112)
heading('4개 상태값으로 속도 추정',510,181,395,24)
txt('cv2.KalmanFilter(4, 2)로 상태 [x, y, vx, vy]와 관측 [x, y]를 구성했습니다. 프레임 간 시간차 dt를 전이 행렬에 반영해 속도를 추정했습니다.',510,242,395,18,maxh=110)
pill('동작 해석',510,334,396,27)
txt('썰기  /  수직 속도의 방향 반전<br/>젓기  /  그릇 중심 기준 각도 누적<br/>뒤집기  /  손의 상승 속도',510,382,397,20,maxh=125)

# Technical implementation details, verified in hand_tracker.py and minigames.
page(); top('Project 03','좌표를 예측·보정하고, 동작별로 해석했습니다.','hand_tracker.py / minigames/cutting.py / stirring.py / flipping.py')
box(24,154,440,388); box(480,154,456,388)
heading('predict() → correct()',53,181,377,26)
txt('predict()로 다음 상태를 예측하고, correct([x, y])로 측정 위치를 반영했습니다. 보정 상태의 vx·vy를 HandState에 전달해 조작에 사용했습니다.',53,238,378,19,maxh=134)
pill('NumPy 행렬로 모델 구성',53,373,376,27)
txt('관측 행렬은 x·y만 측정하도록 설정했습니다. 과정·관측 잡음 공분산을 지정하고, 손이 사라지면 tracker.reset()으로 추정을 초기화했습니다.',53,419,378,18,maxh=105)
heading('동작마다 다른 판정 함수',510,181,395,24)
txt('썰기  /  이전 vy와 현재 vy가 임계값을 넘으며 반전되는 순간을 한 번의 칼질로 판정했습니다.',510,240,395,18,maxh=77)
txt('젓기  /  atan2(dy, dx)로 각도를 구하고 ±π 경계의 변화량을 보정했습니다. 누적 각도 2π를 한 바퀴로 집계했습니다.',510,333,395,18,maxh=101)
txt('뒤집기  /  손을 쥔 상태에서 vy가 FLIP_SPEED를 넘으면 동작을 실행했습니다.',510,452,395,18,maxh=76)

# 11 / Other work, supporting evidence without adding major project chapters.
page(); top('Other Works','문제를 발견하고 구현해 온 경험','주요 프로젝트 외에도, 업무 자동화와 AI 개발 도구 활용을 경험했습니다.')
others=[
 ('메뉴담기',ROOT/'images/menudamgi-dashboard.png','신문사 주문 관리의 불편을 직접 기획한 서비스로 해결했습니다. AI와 함께 구현하고 실제 사용 후 모바일 화면을 개선했습니다.','실제 업무에 사용'),
 ('에브리타임 집계',ROOT/'images/article-search-network.png','기자의 요청으로 키워드 게시글 집계 프로그램을 제작했습니다. 집계 결과는 학생 관심 변화를 설명하는 기사 근거로 활용됐습니다.','Python · Selenium · pandas'),
 ('Unity AI 개발',ROOT/'images/avoid-trend-memes.gif','AI Agent·Unity MCP를 개발에 활용했습니다. DOTween·UniTask·R3·VContainer·Addressables 적용 경험이 있습니다.','AI Agent · MCP')]
for i,(title,path,body,tag) in enumerate(others):
    x=24+i*310; box(x,154,292,388)
    if i==1:
        box(x+24,178,244,131,'#F0F4E9',12)
        txt('반복 집계',x+43,198,210,23,bold=True)
        txt('→ CSV 정리<br/>→ 기사 근거 활용',x+43,236,213,19,DEEP,maxh=69)
    else: image(path,x+24,178,244,131)
    pill('Work '+str(i+1).zfill(2),x+87,321,116,24,size=11)
    txt(title,x+24,361,244,24,bold=True,maxh=66)
    rule(x+24,402,244)
    txt(body,x+24,421,244,17,GRAY,maxh=111)

# 12 / Closing, airy like the supplied reference.
page(); txt('hyewon5617@naver.com',675,43,255,15)
txt('github.com/hyewang5617',675,72,255,15)
txt('현장의 문제를 발견하고,<br/>AI와 함께 해결할 준비가 되어 있습니다.',63,148,845,37,bold=True,maxh=140)
rule(64,274,86)
txt('직접 겪은 업무 문제를 정의한 경험을 바탕으로,<br/>도구를 연결하는 Agent와 사용자에게 도움이 되는 자동화를 배우고 싶습니다.',64,307,790,21,maxh=100)
txt('기획부터 데이터·구현·사용까지 연결하는<br/>개발자 정혜원입니다.',64,426,790,23,bold=True,maxh=79)
c.save()
r=PdfReader(str(PDF)); assert len(r.pages)==14; assert all(p.extract_text().strip() for p in r.pages)
doc=pdfium.PdfDocument(str(PDF))
for i in range(len(doc)): doc[i].render(scale=1.4).to_pil().save(R/f'page-{i+1:02d}.png')
sheet=Image.new('RGB',(1200,1262),'#DDDDDD')
for i in range(14):
    im=Image.open(R/f'page-{i+1:02d}.png'); im.thumbnail((390,244)); sheet.paste(im,((i%3)*400+5,(i//3)*252+5))
sheet.save(R/'contact-sheet.png')
print('Generated',PDF,'pages',len(r.pages),'bytes',PDF.stat().st_size)
