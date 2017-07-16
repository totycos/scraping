require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   

tab = {}
i = 1

while true
    while(i<973)
        name = page.xpath("//*[@id=\"currencies-all\"]/tbody/tr[#{i}]/td[2]/img/@alt")
        price = page.xpath("//*[@id=\"currencies-all\"]/tbody/tr[#{i}]/td[5]/a/@data-usd")
        i += 1
        tab.store(name.text, price.text) 
    end
    puts tab
    sleep 3600
end





=begin

AUTRE METHODE DE SELECTION :

nameCSS = page.css("img[class=currency-logo]").attribute("alt")
priceCSS = page.css("a[class=price]").attribute("data-usd")

nameSEARCH = page.search("[class=currency-logo]").attribute("alt").value
priceSEARCH = page.search("[class=price]").attribute("data-usd").value

=end


# tab.store(name, price)
 
=begin
tab = {"#{name}" => "#{price}"}
        tab.each do |clef, valeur|
            puts clef + " => " + valeur
        end

prix = page.css("a[class=price]")
prix.each{|link| puts link['data-usd']}
money = page.css("img[class=currency-logo]")
money.each{|link| puts link['alt']}
=end
