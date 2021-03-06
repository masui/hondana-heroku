require 'json'
require 'uri'
require 'net/https'

#
# 常識問題と答のMD5を得る
#
# def get_joushiki()
#   url = "https://joushiki.herokuapp.com/"
#   begin
#     uri = URI.parse(URI.escape(url)) # 何故かescape必要?
#     http = Net::HTTP.new(uri.host, uri.port)
#     http.use_ssl = true
#     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
#     req = Net::HTTP::Get.new(uri.path)
#     res = http.request(req)
#     return ["", "", ""] unless res
#     JSON.parse(res.body)
#   rescue
#     return ["", "", ""]
#   end
# end

def get_joushiki()
  url = "http://joushiki.herokuapp.com/"
  # url = "http://joushiki.com/"
  url = "http://joushiki.herokuapp.com/"
  begin
    uri = URI.parse(URI.escape(url)) # 何故かescape必要?
    http = Net::HTTP.new(uri.host, uri.port)
    # req = Net::HTTP::Get.new(uri.path)
    req = Net::HTTP::Get.new(url)
    res = http.request(req)
    return "" unless res
    JSON.parse(res.body)
  rescue
    return ""
  end
end

def check_joushiki(q,a)
  url = "https://joushiki.herokuapp.com/"
  # url = "http://joushiki.com/"
  puts "check_joushiki('#{q}','#{a}')"
  return false if q.to_s == '' || a.to_s == ''
  text = q.sub(/■/,a)

  return true # test
  
  begin
    uri = URI.parse(URI.escape(url)) # 何故かescape必要?
    http = Net::HTTP.new(uri.host, uri.port)
    # req = Net::HTTP::Get.new("#{uri.path}?q=#{q}&a=#{a}")
    # req = Net::HTTP::Get.new("#{uri.path}#{text}")
    req = Net::HTTP::Get.new("#{url}#{text}")
    res = http.request(req)
    puts "BODY = #{res.body}"
    return false unless res
    return JSON.parse(res.body)
  rescue
    return false
  end
  false
end

if __FILE__ == $0 then
  puts get_joushiki()
  puts check_joushiki('備え■憂いなし','あれば')
  puts check_joushiki('備え■憂いなし','あっても')
end

