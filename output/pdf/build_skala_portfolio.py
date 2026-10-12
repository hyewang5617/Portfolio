from pathlib import Path
from reportlab.pdfgen import canvas
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.colors import HexColor
from reportlab.platypus import Paragraph
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.utils import ImageReader
from pypdf import PdfReader
import pypdfium2 as pdfium

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'output/pdf'
ASSETS = OUT / 'skala-assets'
PDF = OUT / '정혜원_Pre-SKALA_포트폴리오.pdf'
pdfmetrics.registerFont(TTFont('Korean', r'C:\Windows\Fonts\malgun.ttf'))
pdfmetrics.registerFont(TTFont('KoreanBold', r'C:\Windows\Fonts\malgunbd.ttf'))
W, H = 960, 600
BLACK, WHITE = '#111111', '#FFFFFF'
GREEN, DEEP = '#BEF264', '#365314'
GRAY, LIGHT = '#5B5B5B', '#F4F4F2'
c = canvas.Canvas(str(PDF), pagesize=(W, H))
c.setTitle('정혜원 | Pre-SKALA 프로젝트 포트폴리오')
c.setAuthor('정혜원')
page_no = 0
checks = []

def rect(x, y, w, h, color, radius=0):
    c.setFillColor(HexColor(color))
    if radius: c.roundRect(x, H-y-h, w, h, radius, stroke=0, fill=1)
    else: c.rect(x, H-y-h, w, h, stroke=0, fill=1)

def text(s, x, y, width, size=20, color=BLACK, bold=False, max_h=None):
    style = ParagraphStyle('p', fontName='KoreanBold' if bold else 'Korean', fontSize=size,
        leading=size*1.45, textColor=HexColor(color), wordWrap='CJK', spaceAfter=0)
    p = Paragraph(s, style)
    _, h = p.wrap(width, H)
    if max_h is not None and h > max_h + .1:
        raise ValueError(f'Page {page_no} overflow: {s[:50]} height {h} > {max_h}')
    if y+h > 555: raise ValueError(f'Page {page_no} exceeds footer: {s[:50]}')
    p.drawOn(c, x, H-y-h)
    checks.append((page_no,x,y,width,h,s))
    return h

def line(y, dark=False):
    c.setStrokeColor(HexColor('#444444' if dark else '#DDDDDD'))
    c.setLineWidth(.6); c.line(48,H-y,912,H-y)

def page(label, title=None, sub=None, dark=False):
    global page_no
    if page_no: c.showPage()
    page_no += 1
    rect(0,0,W,H,BLACK if dark else WHITE)
    text(label,48,28,820,13,GREEN if dark else DEEP,True)
    if title: text(title,48,67,860,34,WHITE if dark else BLACK,True,max_h=100)
    if sub: text(sub,48,122,860,16,'#D3D3D3' if dark else GRAY,max_h=48)
    line(560,dark)
    c.setFont('Korean',10); c.setFillColor(HexColor('#C4C4C4' if dark else GRAY))
    c.drawString(48,20,'정혜원  /  PRE-SKALA 2026')
    c.setFont('Korean',10); c.setFillColor(HexColor('#C4C4C4' if dark else GRAY))
    c.drawRightString(912,20,f'{page_no:02d} / 10')

def link(label,url,x,y,width=200,dark=False):
    text(label+' ↗',x,y,width,15,GREEN if dark else DEEP,True)
    c.linkURL(url,(x,H-y-25,x+width,H-y),relative=0,thickness=0)

def img(path,x,y,w,h,crop=None):
    from PIL import Image
    im=Image.open(path)
    if crop:
        # Crop only the source slide's surrounding layout, keeping the actual screenshot intact.
        im=im.crop(crop)
    iw,ih=im.size
    scale=min(w/iw,h/ih); dw,dh=iw*scale,ih*scale
    c.drawImage(ImageReader(im),x+(w-dw)/2,H-y-(h-dh)/2-dh,dw,dh,mask='auto')

def block(label,title,body,x,y,w=402,dark=False):
    text(label,x,y,w,14,GREEN if dark else DEEP,True)
    text(title,x,y+28,w,24,WHITE if dark else BLACK,True,max_h=75)
    text(body,x,y+107,w,20,'#E4E4E4' if dark else BLACK,max_h=180)

def flow(nodes,x,y,width=864):
    gap=18; n=len(nodes); bw=(width-gap*(n-1))/n
    for i,(a,b) in enumerate(nodes):
        xx=x+i*(bw+gap)
        rect(xx,y,bw,112,LIGHT,8)
        text(a,xx+16,y+16,bw-32,22,BLACK,True,max_h=34)
        text(b,xx+16,y+54,bw-32,16,GRAY,max_h=52)
        if i<n-1: text('›',xx+bw+3,y+39,15,20,DEEP,True)

# 01: Applicant identity, supported by concrete experience.
page('PROJECT PORTFOLIO  /  PRE-SKALA 2026',dark=True)
text('불편을 발견하고,<br/>직접 쓰는 서비스로 만듭니다.',48,103,855,44,WHITE,True,max_h=140)
rect(48,248,86,7,GREEN)
text('정혜원',48,284,450,34,WHITE,True)
text('직접 문제를 정의하고, 데이터와 소프트웨어로 구현합니다.<br/>AI를 개발에 활용하고, 사용자에게 필요한 동작으로 연결합니다.',48,343,830,23,'#E4E4E4',max_h=100)
link('GitHub','https://github.com/hyewang5617',48,483,140,True)
link('전체 프로젝트','https://hyewang5617.github.io/Portfolio/',220,483,190,True)
text('hyewon5617@naver.com',617,486,294,16,'#D3D3D3')

# 02: A quick map for a reviewer unfamiliar with these projects.
page('OVERVIEW','문제에서 출발한 세 가지 프로젝트','어떤 기술을 썼는지보다, 누구의 어떤 문제를 해결했는지 보여드립니다.')
rows=[
 ('01','Sportly','팀 매칭 백엔드 → 인증·권한·업무 규칙 구현','2025 · 팀 프로젝트 / 팀장·백엔드 개발','Node.js · TypeScript · Express · MongoDB · JWT'),
 ('02','서울과기대신문사 기사찾기','기사 탐색의 불편 → 데이터 기반 검색','2026.05 · 개인 프로젝트 / 기획·데이터 처리·웹 개발','Python · TF-IDF · 코사인 유사도 · D3.js'),
 ('03','Cooking Papa','손 인식 결과 → 실제 게임 조작','2026 · 개인 프로젝트 / 손동작 입력·게임 상호작용 구현','Python · OpenCV · MediaPipe · Kalman Filter')]
for i,(num,name,promise,role,stack) in enumerate(rows):
    y=181+i*116
    rect(48,y,50,40,GREEN,6); text(num,58,y+3,38,22,BLACK,True)
    text(name,121,y-2,770,25,BLACK,True)
    text(promise,121,y+35,770,21,BLACK)
    text(role+'<br/>'+stack,121,y+69,770,15,GRAY,max_h=45)

# 03: Sportly API output and precise contribution.
page('01 / Sportly','기능을 넘어, 권한과 데이터 규칙을 구현했습니다.','2025 · 축구 팀 매칭 서비스 · 팀장 / 백엔드 개발')
img(ROOT/'images/sportly-teams.png',48,189,477,290)
text('실제 Swagger 화면: 팀 관리와 평점 API',48,495,470,14,GRAY)
text('내 기여',569,183,343,14,DEEP,True)
text('로그인 인증, 전화번호 인증,<br/>팀 평점·알림 API 개발',569,214,343,25,BLACK,True,max_h=113)
text('Node.js · TypeScript · Express<br/>MongoDB · Mongoose · JWT<br/>Swagger · Cloudtype',569,324,343,18,GRAY,max_h=87)
text('팀장으로 회의를 이끌고 회의록과 진행 상황을 정리했습니다. API 문서로 연동 사항을 공유했습니다.',569,440,343,20,max_h=91)
link('코드 보기','https://github.com/soccerteam-matchapp/backend',48,146,170)
link('Swagger 문서','https://port-0-sportly-mg82ro7fce364845.sel3.cloudtype.app/api-docs/',245,146,190)

# 04: Actual request structure and authorization boundaries.
page('01 / 요청 처리와 권한','인증된 사용자도, 모든 데이터를 다룰 수는 없습니다.','요청 → 인증 미들웨어 → Controller → Service → MongoDB')
flow([('JWT 검증','서명·만료 확인'),('사용자 식별','req.userId 전달'),('업무 규칙','권한·입력 검증'),('데이터 처리','MongoDB 조회·저장')],48,181)
text('알림 읽음 처리에 소유자 조건을 함께 적용했습니다.',48,318,864,24,BLACK,True)
text('알림 ID만으로 조회하지 않고, 인증된 사용자의 ID도 조건에 포함했습니다.<br/>다른 사용자의 알림을 변경하지 못하도록 조회 단계에서 범위를 제한했습니다.',48,358,864,20,max_h=94)
rect(48,456,864,73,BLACK,8)
text('인증은 “누구인지”, 권한은 “무엇을 다룰 수 있는지”를 확인하는 과정입니다.<br/>전화번호 인증에는 5분 만료와 검증 시도 횟수 제한도 구현했습니다.',66,471,828,18,WHITE,max_h=59)

# 05: Concrete rating update and honest delivery limits.
page('01 / 데이터 정합성과 배포','평점 수정은, 새 평가 한 건이 아닙니다.','소스 코드의 실제 처리 흐름: rating.service.ts / notification.service.ts')
block('문제와 구현','수정 시 중복 집계를 방지','신규 평가라면 합계와 개수를 늘리고, 기존 평가라면 점수 차이만 합계에 반영했습니다. 점수 범위와 자기 팀 평가도 검증했습니다.',48,177)
rect(510,187,402,150,BLACK,8)
text('기존 평가를 수정할 때',528,201,362,14,GREEN,True)
text('delta = score - existing.score<br/>team.ratingSum += delta<br/>ratingAvg = ratingSum / ratingCount',528,244,365,17,WHITE,max_h=81)
text('배포와 협업에서 경험한 한계',510,366,402,22,BLACK,True)
text('Cloudtype 배포와 Swagger 적용 문제 수정을 경험했습니다. 프론트엔드 통합은 미완료이며, 결과물은 API와 문서 중심입니다.',510,407,402,19,max_h=119)
rect(48,452,402,77,LIGHT,8)
text('같은 사용자·팀의 기존 평가를 조회한 뒤<br/>신규와 수정을 나누어 처리했습니다.',64,469,370,18,max_h=56)

# 05: Article search snapshot.
page('02 / 서울과기대신문사 기사찾기','기사 목록을 넘어, 관련 기사를 탐색하도록','2026년 5월 · 개인 프로젝트 · 기획·데이터 처리·검색 화면·시각화 구현')
img(ASSETS/'article.png',48,188,529,306,crop=(375,180,1920,1000))
text('검색 관련도는 노드 크기로, 기사 유사도는 연결선으로 표시',48,505,535,14,GRAY)
text('1,166개 기사',620,186,292,32,BLACK,True)
text('629~715호 데이터를 구축해<br/>검색과 탐색에 활용했습니다.',620,242,292,20,max_h=90)
text('직접 겪은 문제',620,345,292,14,DEEP,True)
text('기획회의와 기사 작성 중 원하는 과거 기사를 찾기 어려웠습니다. 내용을 확인하려고 원문을 하나씩 여는 과정도 불편했습니다.',620,376,292,20,max_h=151)
link('서비스 보기','https://hyewang5617.github.io/Search-for-articles-of-seoultech/',48,147,170)
link('코드 보기','https://github.com/hyewang5617/Search-for-articles-of-seoultech',243,147,150)

# 06: Concrete architecture and choice, not claiming LLM/RAG.
page('02 / 데이터와 검색 설계','데이터 처리를 탐색 경험으로 연결했습니다.','Python · TF-IDF · 코사인 유사도 · JavaScript · D3.js · GitHub Pages')
flow([('기사 데이터','제목·본문 정리'),('특징 계산','TF-IDF 키워드'),('관계 구성','코사인 유사도'),('웹 탐색','D3.js 그래프')],48,185)
text('검색 관련도와 기사 간 유사도는 다르게 다뤘습니다.',48,321,864,24,BLACK,True)
text('검색어 등장 빈도로 관련도를 계산해 노드 크기에 반영했습니다.<br/>기사 간 연결은 TF-IDF와 코사인 유사도로 구성해, 비슷한 내용을 탐색하도록 했습니다.',48,365,864,20,max_h=93)
rect(48,462,864,67,LIGHT,8)
text('실제 활용  /  기자들의 기획회의·기사 작성에 사용했습니다.<br/>모바일에서는 키워드 확인, 그래프 이동과 두 손가락 확대·축소를 개선했습니다.',66,474,828,18,max_h=55)

# 07: Applied AI, with a real screenshot taken from the supplied portfolio.
page('03 / Cooking Papa','손을 인식하는 것에서, 손으로 조작하는 것까지','2026 · 개인 프로젝트 · Python · OpenCV · MediaPipe · NumPy · Pygame')
img(ASSETS/'cooking.png',48,190,864,198)
text('실제 게임 화면: 손을 쥐어 버튼과 도구를 선택하는 인터랙션',48,398,864,14,GRAY)
text('내 기여',48,446,145,14,DEEP,True)
text('손의 위치·속도·쥐기 상태를 게임 입력으로 변환하고,<br/>잡기·썰기·젓기·뒤집기 동작을 조리 과정과 연결했습니다.',200,439,710,22,max_h=96)
link('플레이 영상','https://youtu.be/rqzNLpTx-Jo',48,146,180)
link('코드 보기','https://github.com/hyewang5617/cooking-papa',255,146,150)

# 08: Troubleshooting with implementation evidence from the supplied PDF.
page('03 / 입력 해석과 문제 해결','인식 결과를 그대로 쓰면 조작이 되지 않았습니다.','AI 모델이 제공한 좌표와, 사용자가 의도한 행동 사이의 간극을 직접 구현으로 메웠습니다.')
flow([('웹캠','영상 입력'),('MediaPipe','21개 손 랜드마크'),('HandState','위치·속도·쥐기'),('게임 규칙','썰기·젓기·뒤집기')],48,182)
text('문제  /  보이는 손과 상호작용 판정 위치의 차이',48,320,864,24,BLACK,True)
text('21개 랜드마크의 중심점을 화면상 손 위치로 사용해,<br/>손 아바타와 상호작용 판정의 기준점을 일치시켰습니다.',48,360,864,21,max_h=87)
rect(48,455,864,73,BLACK,8)
text('속도는 Kalman Filter로 추정하고, 조리 동작마다 다른 규칙을 적용했습니다.<br/>썰기: 수직 속도 반전  /  젓기: 각도 누적  /  뒤집기: 상승 속도',66,470,828,18,WHITE,max_h=60)

# 09: Link existing capability to future learning without overstating experience.
page('NEXT / AI 활용과 팀 기여','문제를 정리하고, 구현하고, 끝까지 연결합니다.',dark=True)
cols=[
 ('AI를 개발 도구로','메뉴담기에서 직접 서비스 흐름을 기획하고 AI와 함께 구현했습니다. Unity에서는 AI Agent와 MCP를 활용한 게임 개발도 경험했습니다.'),
 ('팀의 흐름을 정리','Sportly 팀장 겸 백엔드 개발자로 회의를 진행하고 회의록을 작성했습니다. 인증·평점·알림 API와 Swagger 문서화를 담당했습니다.'),
 ('다음 단계로 확장','업무 문제를 정의한 경험을 바탕으로, 도구를 연결하는 Agent를 배우고 사용자에게 도움이 되는 자동화를 만들고 싶습니다.')]
for i,(title,body) in enumerate(cols):
    x=48+i*297
    rect(x,186,46,5,GREEN)
    text(title,x,214,270,24,WHITE,True,max_h=75)
    text(body,x,281,264,20,'#E4E4E4',max_h=212)
link('전체 프로젝트와 개발 기록','https://hyewang5617.github.io/Portfolio/',48,505,285,True)
link('GitHub','https://github.com/hyewang5617',380,505,130,True)
text('hyewon5617@naver.com',630,509,282,15,'#D3D3D3')
c.save()
assert page_no == 10
r=PdfReader(str(PDF))
assert len(r.pages)==10
assert all(p.extract_text().strip() for p in r.pages)
print('Generated',PDF,'pages=',len(r.pages),'layout checks=',len(checks))
doc=pdfium.PdfDocument(str(PDF))
for i in range(len(doc)):
    doc[i].render(scale=1.5).to_pil().save(ASSETS/f'page-{i+1:02d}.png')
from PIL import Image, ImageOps, ImageDraw
contact=Image.new('RGB',(960,840),'#DDDDDD')
for i in range(10):
    im=Image.open(ASSETS/f'page-{i+1:02d}.png')
    im.thumbnail((310,194))
    contact.paste(im,((i%3)*320+5,(i//3)*210+5))
contact.save(ASSETS/'contact-sheet.png')
print('Rendered all 10 pages')
