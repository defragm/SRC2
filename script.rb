require 'nokogiri'
require 'open-uri'
informationProduit = {"productName" => "", "productDescr" => ""}

if File.exists?("offreDigitec.html")
  offreDigitec = File.open("offreDigitec.html", "r")
  offreDuJour = offreDigitec
else
  File.open("offreDigitec.html", "w") {|f| f.write(Nokogiri::HTML(open("https://www.digitec.ch/fr")).css(".themeDigitec").first);}
  offreDigitec = File.open("offreDigitec.html", "r")
  offreDuJour = offreDigitec
  # exemple pour lire le contenu
  #offreDuJour = offreDigitec.read
end

informationProduit["productName"] = "#{Nokogiri::HTML(offreDuJour).css(".productName")}"
decoupNomProduit = informationProduit["productName"].split('<')
tableIntermediere = decoupNomProduit[2].split('>')
informationProduit["productName"] = tableIntermediere[1]


tableIntermediere = decoupNomProduit[5].split('>')
informationProduit["productDescr"] = "#{tableIntermediere[1]}"
puts informationProduit
