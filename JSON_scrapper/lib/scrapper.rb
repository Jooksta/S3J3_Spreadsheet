require 'nokogiri'
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage (url_to_city) #url_to_city correspond au href de chaque ville
  city_page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{url_to_city}")) #city_page prend en valeur tout le code HTML de la page dont l'url est spécifié, complétée par url_to_city

  city_page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each do |mail| #Récupère chaque adresse mail dans city_page via le chemin xpath
    print("#{mail.content}\n"); #Affiche les précieuses adresses mail de chaque mairie
  end
end

def get_all_the_urls_of_val_doise_townhalls
    department_page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")) #department_page prend en valeur tout le code HTML de la page dont l'url est spécifié

    a_links = department_page.css("a.lientxt") #On récupère dans un tableau tout le contenu des balises "a" qui ont la class "lientxt".
    a_links.each {|link| get_the_email_of_a_townhal_from_its_webpage(link['href']) } #Pour chaque cellule du tableau. On ne garde que le href et on l'envoie en paramètre dans la méthode "get_the_email_of_a_townhal_from_its_webpage"
end

def get_all_emails (array)
	list_emails = Array.new
	array.length.times do |i|
		if i == 135
			list_emails[i] = nil
		else
			list_emails[i] = get_the_email_of_a_townhal_from_its_webpage(array[i])
		end
	end
	array.length.times do |i|
		return list_emails.flatten
	end
end

def perform
  #get_all_the_urls_of_val_doise_townhalls
  get_all_emails
end

perform
