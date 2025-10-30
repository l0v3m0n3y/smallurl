import asyncdispatch, httpclient, json, uri

proc short_link*(
  url: string,
  customCode: string = "",
  title: string = "", 
  description: string = "",
  createdBy: string = ""
): Future[JsonNode] {.async.} =
  
  let client = newAsyncHttpClient()
  try:
    var data = %*{
      "originalUrl": url,
      "customShortCode": newJNull(),
      "title": newJNull(),
      "description": newJNull(),
      "createdBy": newJNull()
    }
    
    # Заменяем поля только если они не пустые
    if customCode.len > 0:
      data["customShortCode"] = %customCode  # Обрати внимание - должно быть customShortCode, а не customCode
    
    if title.len > 0:
      data["title"] = %title
      
    if description.len > 0:
      data["description"] = %description
      
    if createdBy.len > 0:
      data["createdBy"] = %createdBy
    client.headers = newHttpHeaders({"Connection": "keep-alive", "content-type": "application/json","host": "urlshortner.orangesmoke-119c66f5.eastus.azurecontainerapps.io", "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36","Origin":"https://smallurl.in"})
    let response = await client.post("https://urlshortner.orangesmoke-119c66f5.eastus.azurecontainerapps.io/api/url/shorten",body = $data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc user_info*(user:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = newHttpHeaders({"Connection": "keep-alive", "content-type": "application/json","host": "urlshortner.orangesmoke-119c66f5.eastus.azurecontainerapps.io", "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36","Origin":"https://smallurl.in"})
    let response = await client.get("https://urlshortner.orangesmoke-119c66f5.eastus.azurecontainerapps.io/api/url/user/" & user)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
