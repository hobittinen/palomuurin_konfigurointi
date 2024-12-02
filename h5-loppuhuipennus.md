# Loppuhuipennus

## a) Miniprojektin valmiiksi tekeminen

Jatkoin palomuurin konfigurointityökalun jalostamista 30.11. klo 15.23. Ensimmäiseksi päätin tarkistaa, että viime sessiossani tekemät muutokset olivat kunnossa.

![image](https://github.com/user-attachments/assets/2292c8c2-88bc-45ae-9e5d-bc0ba1cc6ad4)

Huomattuani kaiken olevan kunnossa, pystyin jatkamaan työni tekoa rauhallisin mielin. Päätin katsoa ufw:n oletuskäytännöt seuraavaa komentoa käyttäen.

    sudo grep -i '^default_' /etc/default/ufw

Komento tulosti tällaisen maiseman:

![image](https://github.com/user-attachments/assets/7e2143fd-03f5-473a-96cf-b158739f0257)

Seuraavaksi muutin muutamaa oletuskäytäntöä kuvan mukaisesti:

![image](https://github.com/user-attachments/assets/20f0fc2a-5fc7-48e1-8e31-cb964fffdb75)

Äsken siis sallin kaiken saapuvan liikenteen ja estin kaiken lähtevän liikenteen. Nyt päätin kääntää asiat toisinpäin eli estää saapuvan liikenteen ja sallia lähtevän liikenteen. Käytin seuraavia komentoja:

    sudo ufw default deny incoming
    sudo ufw default allow outgoing

Sain uuden idean: reititetty liikenne! Toteutin sen, jonka jälkeen tarkistin asetukset.

![image](https://github.com/user-attachments/assets/c7a341c4-1bc1-48db-ab86-2e317d04fc22)

Seuraava siirtoni oli suoraan [täältä](https://www.cyberciti.biz/faq/set-up-a-firewall-with-ufw-on-debian-12-linux/). Sallin kaiken liikenteen LXD-säilölle Debian Linux by lxdbr0 -käyttöliittymässä.

![image](https://github.com/user-attachments/assets/0a7885cb-3e85-4f13-b8fa-06c396128c4f)

Nyt oli vuorossa ufw-palvelun hallintaa. Käytin seuraavia komentoja hallintaan.

    sudo ufw status
    sudo ufw status verbose
    sudo ufw status numbered

Tässä välissä päätin pitää tauon. Kello oli 15.46.

Palasin tauoltani samana päivänä klo 18.25. Ensimmäinen asia, jonka tein taukoni jälkeen oli sääntöjen lisääminen. Aloitin sääntöjen lisäämisen "allow"-säännöistä.

![image](https://github.com/user-attachments/assets/3654ffe3-5c93-419e-aaa8-e42edb1318b7)
![image](https://github.com/user-attachments/assets/c2db500b-51c4-4ce7-9e5a-114bb47473dc)

"Allow"-sääntöjen jälkeen vuorossa oli "deny"- ja "reject"-säännöt. Tein ne kuvassa näkyvillä tavoilla.

![image](https://github.com/user-attachments/assets/ffb9a318-32d6-430d-94e7-550e890b9ac3)

En ollut tyytyväinen sääntöihin, joten muokkailin niitä vähän. Lopputuloksena sain aikaiseksi tällaisen taulukon:

![image](https://github.com/user-attachments/assets/c9ac4598-2baf-4bf3-ba9d-255979b91c0c)

Luulin sääntöjen kanssa sekoilun olevan ohi, mutta ei se ollutkaan. Vilkaisin ohjesivua ja totesin, ettei tänään enää jaksaisi asennella sääntöjä. Päätin lopettaa tämän päivän työt klo 18.55.

Sain kerättyä noin vuorokaudessa tarpeeksi voimia, jotta jaksoin jatkaa moduuliani. Avasin virtuaalikoneeni 1.12. klo 17.30. Heti alkuun tarkistin ufw-konfiguraation.

![image](https://github.com/user-attachments/assets/2e88da3c-a5db-43fa-9186-7d3b16018079)

Kaikki oli kunnossa, joten pääsin jatkamaan sääntöjen asentelua. Ensitöikseni asetin rajoituksia SSH:n liikenteelle allaolevalla komennolla.

    sudo ufw limit ssh/tcp

Seuraavaksi suuntasin sääntöjen järjestyksen hallintaan. Priorisoin sysadminin IP-osoitteen, hätäavasin tietyn portin, estin tietyn IP-osoitteen ennen yleisiä sääntöjä, sallin kaiken saapuvan liikenteen porttiin 180 ja asetin VPN-liikenteen etusijalle.

![image](https://github.com/user-attachments/assets/ac577adf-bf66-4e00-88cf-0479cf74159a)

Huomasin, etten ollut hätäpriorisoinut SSH-yhteyksiä! Onneksi ongelma ratkesi helposti seuraavalla komennolla:

    sudo ufw insert 1 allow 22/tcp

Tarkistin ufw-konfiguraation.

    sudo ufw status numbered

Ufw-konfiguraation ollessa paikkansapitävä, siirryin sääntöjen lisäämiseen palomuurin alkuun. Tein seuraavanlaisia sääntöjä:

![image](https://github.com/user-attachments/assets/e9842e3f-17e6-4a3d-9715-a9016736a852)

Nyt oli tauon aika! Siirryin tauolle klo 18.12.

Taukoni vähän venähti. Pääsin takaisin koneen ääreen vasta 2.12. klo 11.45. Jatkoin kuuliaisesti moduulini tekemistä. Aloitin tämän päivän hommat palomuuriraporttien katsomisella. Katsoin raportteja seuraavilla komennoilla:

    sudo ufw show raw | less
    sudo ufw show builtins | more
    sudo ufw show listening
    sudo ufw show added

Viimeinen ylläolevista komennoista tulosti seuraavanlaisen listan:

![image](https://github.com/user-attachments/assets/522ea9b7-1db9-4592-aaf4-4e98c3337422)

Raporttien tutkailun jälkeen varmistin ufw-lokien käytössäolon. Tein myös varmuuskopion ufw-asetuksista.

![image](https://github.com/user-attachments/assets/6e1edfbc-5705-4b2f-a3b1-4f857ef0a092)

Mielestäni olin nyt saanut ufw-asiat hyvään jamaan. En kuitenkaan ollut täysin tyytyväinen moduuliini. Voisinko tehdä jotain muuta? Hetken pohdinnan jälkeen päädyin siihen vaihtoehtoon, että lisään iptables-juttuja moduuliini. Hain sitä varten [ohjeen](https://upcloud.com/resources/tutorials/configure-iptables-debian).

Aloitin retkeni iptablesin kanssa tarkastamalla iptablesin tilan ja version.

    sudo iptables -L
    sudo iptables --version

Jatkoin tehtävää soveltamalla ohjeena käyttämäni verkkosivun komentoja. Tarvittaessa käytin apuna ChatGPT-ohjelmaa.

Seuraavaksi vuorossa oli iptables-sääntöjen lisäämistä. Lisäsin reitityksen NAT-taulun avulla, muokkasin lähtevää liikennettä ja lisäsin kirjaussääntöjä.

![image](https://github.com/user-attachments/assets/1ae85d89-5689-4efb-a42f-f758d8e14a75)

Sääntöjen lisäilyn jälkeen oli aika tallentaa ne! Käytin seuraavia komentoja:

    sudo apt install iptables-persistent
    sudo netfilter-persistent save

Tarkistin sääntöjen yhteensopivuuden seuraavilla komennoilla:

    sudo ufw status verbose
    sudo iptables -L -v -n
    sudo iptables -t nat -L -v -n

Seuraavaksi vuorossa oli tauko. Kello oli tässä kohtaa 12.44.

Palasin tauoltani klo 15.14. Aloin heti viimeistelemään moduuliani. Päätin testata ufw:n ja iptablesin yhteiseloa.

![image](https://github.com/user-attachments/assets/7c928f74-9e30-4fa5-b38b-a2a36afbb072)

Seuraavaksi tarkastin ufw:n idempotenttiutta. Käytin siihen seuraavaa komentosarjaa:

    sudo ufw status verbose
    sudo ufw allow ssh
    sudo ufw status verbose
    sudo ufw allow ssh

Totesin idempotenttiuden olevan läsnä, koska tulokset eivät muuttuneet, vaikka kuinka monta kertaa toistelin komentoja. Tämän jälkeen tarkistin iptables-säännöt.

    sudo iptables -L -v -n

Halusin vielä tarkistaa uudelleen ufw:n ja iptablesin yhteiselon onnistumisen.

![image](https://github.com/user-attachments/assets/0e4da975-c97c-4dbc-acc5-e5bba032f24c)

Totesin olevani nyt tyytyväinen moduuliini. Työni tuli päätökseen 2.12. klo 15.55.

