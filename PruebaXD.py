import requests
import json

# ------ 1. Conectarse al enlace

url = 'https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow'
data = requests.get(url).json()

# ------ 2. Obtener el número de respuestas contestadas y no contestadas

answered = 0
not_answered = 0

for item in data['items']:
  if item['is_answered'] == True:
    answered += 1
  elif item['is_answered'] == False:
    not_answered += 1

# ------- 3. Obtener la respuesta con menor número de vistas

views = []

for item in data['items']:
  info = item['question_id'], item['view_count']
  views.append(info)

views.sort(key = lambda v: v[1])

# ------- 4. Obtener la respuesta más vieja y más actual

date = []

for item in data['items']:
    info = item['question_id'], item['creation_date']
    date.append(info)

date.sort(key = lambda d: d[1])

# ------- 5. Obtener la respuesta del owner que tenga una mayor reputación
reputation = []

for item in data['items']:
    info = item['question_id'], item['owner']['reputation']
    reputation.append(info)

reputation.sort(key = lambda r: r[1])

# -------6. Imprimir en consola del punto 2 al 5

print('2. Número de preguntas contestadas: ',answered)
print('2. Número de preguntas no contestadas: ',not_answered)
print('3. question_id:', views[0][0], ', view_count: ', views[0][1])
print('4. Pregunta más vieja: question_id: ', date[-1][0], ', creation_date: ', date[-1][1])
print('4. Pregunta más actual: question_id: ', date[0][0], ', creation_date: ', date[0][1])
print('5. question_id: ',reputation[-1][0],', reputation: ',reputation[-1][1])