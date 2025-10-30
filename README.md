# smallurl
web api smallurl.in url shorter
# Example
```nim
import asyncdispatch, smallurl, json, strformat, strutils

echo "🔗 Сокращатель ссылок"
echo "═".repeat(40)

stdout.write "Введите URL для сокращения: "
let url = stdin.readLine().strip()

if url.len > 0:
  try:
    echo "⏳ Сокращаем..."
    let result = waitFor short_link(url)
    echo result
    let data = result["data"]
    let short_url=data["shortUrl"].getStr()
    
    echo ""
    echo "✅ Ссылка успешно сокращена!"
    echo "═".repeat(40)
    echo &"🔗 Исходная: {url}"
    echo &"🎯 Сокращенная: {short_url}"
    echo "═".repeat(40)
    
  except Exception as e:
    echo "❌ Ошибка: ", e.msg
else:
  echo "❌ Вы не ввели URL"
```
# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
