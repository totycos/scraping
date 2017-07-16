require 'nokogiri'
require 'open-uri'
   

def get_the_email_of_a_townhal_from_its_webpage(lien)
    lien.each { |x| 
    pageMairie = Nokogiri::HTML(open(x))
    extraction = pageMairie.xpath("/html/body").text
    mail = /\w+[\.|\-|\_]*[\w+]*[\.|\-|\_]*[\w+]*[\.|\-|\_]*[\w+]*@\w+[\.|\-|\_]*[\w+]*[\.|\-|\_]*[\w+]*[\.|\-|\_]*[\w+]*\.\w+/.match(extraction) 
    puts mail }
end


def get_all_the_urls_of_val_doise_townhalls
    pageDep = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")) 
    # xpath copié sur inspecteur d'élément : //*[@id="voyance-par-telephone"]/table/tbody/tr[2]/td/table/tbody/tr/td[1]/p/a[1]
    urlFin = pageDep.xpath("///table/tr[2]/td/table/tr/td/p/a/@href").text.gsub(/\.\/95/," /95")
    
    urlFinTab = urlFin.split(" ")
   
    url = []
    urlFinTab.each { |element|
        url << "http://annuaire-des-mairies.com"+element }
   
    get_the_email_of_a_townhal_from_its_webpage(url)
end
 

get_all_the_urls_of_val_doise_townhalls




=begin

AUTRE CODE :

require 'nokogiri'   
require 'open-uri'

def get_the_email_of_a_townhall_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//html/body/table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p')
	scrap.each do |node| return node.text.slice!(1..-1) end # get the contact mail adress without first character (" ")
end

def get_all_the_urls_of_val_doise_townhalls(url)
	h = {} # create hash to store results
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//table/tr[2]/td/table/tr/td/p/a')
	scrap.each do |node| 
		city = node.text.split.each do |text| text.capitalize! end # transform city name into array of words, and capitalize every word
		city = city * "-" # transform array back into string with '-' separator between words
		url = 'http://annuaire-des-mairies.com' + node['href'].slice!(1..-1) #rebuild city page whole url from scrapped partial url
		mail = get_the_email_of_a_townhall_from_its_webpage(url) # scrap city page for email adress
		h.store(city, mail) # store value pairs into result hash
	end
	puts h
end

get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html")

=end