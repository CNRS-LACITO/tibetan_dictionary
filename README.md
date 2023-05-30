
Dictionnaire français-tibétain
==============================

_projet de documentation (état provisoire)_
-------------------------------------------

1.  ### Origine
    
    1.  Le _Vocabulaire thématique de langue parlée français-tibétain_, par Eric Mélac, Françoise Robin et Camille Simon  
        776 pages, avec une préface de Nicolas Tournadre  
        a été publié par l'Asiathèque en 2014. \[[Présentation](https://asiatheque.com/fr/livre/vocabulaire-thematique-de-langue-parlee-francais-tibetain)\]  
        _Le propos de ce Vocabulaire thématique est de fournir ce qui est « suffisant, connaissable et utile », selon les termes du lexicographe Kalonji, aux locuteurs des deux langues souhaitant échanger sur autant de sujets que possible, allant des relations internationales au bouddhisme tibétain, en passant par les parties du corps et les transports. L’ouvrage compte environ 10 000 entrées, réparties en 34 sections. Il est conçu de manière analogique, chaque terme menant à un autre du point de vue sémantique, sans ordre alphabétique._  
          
        
    2.  Dans le cadre d'une action _Défis sociétaux_ du LACITO (priorité : Défi des langues minoritaires et des langues en danger) il a été décidé d'en procurer une édition électronique, sous forme d'une application pour téléphones portables.  
          
        
    3.  La première étape a converti le contenu du livre, à savoir un fichier en Word de 10,8 Mo, en un document XML, et de là en un texte en CSV propre à être manipulé par un tableur. Ce texte CSV est rétroconvertible en XML sans perte d'information.  
          
        
    4.  Le document CSV a fait l'objet d'un gros travail de relecture, correction et enrichissement, par Camille Simon et Xénia De Heering.  
        Le document final a été transmis aux informaticiens tibétains chargés d'en faire une application mobile (le _Monlam IT Research Center_ à Dharamshala).  
        Converti en XML, il est prêt à être intégré dans Lexica.  
          
        
2.  ### Logiciel
    
    *   #### Finalité
        
        1.  Dans la perspective de révisions du contenu du dictionnaire, qui se feront probablement via un tableur, il sera utile de mettrer à jour le document XML à partir du CSV.  
              
            
        2.  Il peut s'avérer utile d'engendrer un autre format XML directement à partir du CSV (au lieu d'une transformation XSLT sur le XML actuel).  
              
            
    *   #### Composition
        
        1.  Une classe Java Csv2Xml pour convertir le CSV en XML (fichier Csv2Xml.java)  
            Emploi : java Csv2Xml docIn.csv docOut.xml  
              
            
        2.  Une transformation Xml2Csv pour produire un CSV normalisé à partir du XML (fichier Xml2Csv.xsl)  
            Emploi : xsltproc Xml2Csv.xsl docIn.xml > docOut.csv  
              
            
        3.  Accessoirement, une transformation Xml2Html pour visualiser le XML en HTML (fichier Xml2Html.xsl)  
            Emploi : xsltproc Xml2Html.xsl docIn.xml > docOut.html  
            
        4.  Une DTD pour vérifier la conformité du document XML (fichier `DTD.dtd`)
            Emploi : xmllint --noout doc.xml --dtdvalid DTD.dtd
  
              
            
3.  ### Description informelle
    
    L'unité fondamentale du dictionnaire est l'entrée.  
    Les entrées sont organisées de manière thématique (et non alphabétique), en chapitres et en sections.  
      
    1.  #### Hiérarchie des chapitres et des sections
        
        Le dictionnaire est distribué en chapitres, subdivisés en sections.  
        Chaque section est composée d'une suite d'entrées.  
        Chapitres et sections sont numérotés, et chacun porte un titre en français avec sa traduction en tibétain.  
          
        *   XML : Chapitres et sections sont représentés par des Element, appelés respectivement Chapitre et Section, dont le n° est un attribut appelé Nom.  
            Leurs titres français et tibétain sont également portés par des Element, à contenu texte, fils de Chapitre et de Section, appelés TitreFr et TitreTib.  
              
            
        *   Tableur : les en-têtes de chapitre et de section sont sur une seule ligne, le n° et les titres français et tibétain occupant 3 cellules.  
            Les étiquettes des colonnes correspondantes sont données dans les deux langues (à la demande des Tibétains).  
              
            *   pour les chapitres, en colonne  0 (A),  1 (B) et 2 (C), avec comme étiquettes  
                Chapitre /  ལེའུ་ཨང་གྲངས།,  - contient le n°  
                TChapFr  / ལེའུའི་ཁ་བྱང་།  ཧྥ་སྐད། - contient le titre français  
                TChapTib / ལེའུའི་ཁ་བྱང་།   བོད་ཡིག - contient le titre tibétain.  
                  
                
            *   pour les sections, en colonne 3 (D),  4 (E) et 5 (F), avec comme étiquettes  
                Section / ལེ་ཚན་ཨ་གྲངས། - contient le n°  
                TSectFr  / ལེ་ཚན་ཁ་བྱང་།  ཧྥ་སྐད། - contient le titre français  
                TSectTib / ལེ་ཚན་ཁ་བྱང་།  བོད་ཡིག - contient le titre tibétain.
                
    2.  #### Entrées
        
        Chaque entrée est représentée en XML par un Element nommé Entrée - en tableur, voir plus loin.  
        Une entrée contient deux parties :  
          
        *   **Une** **définition** (représentée en XML par un Element nommé Définition - en tableur, voir plus loin.)  
            Cette définition comporte **une partie française** et **une partie tibétaine**,  
            représentées en XML par deux Element nommés DefFr et DefTib respectivement.  
              
            
        *   **Une liste d'exemples**, qui peut être vide  
            
            *   XML : séquence d'Element nommés Exemple, fils de Entrée.  
                  
                
            *   Tableur : suite de lignes annoncée par un marqueur Ex seul sur sa ligne, en colonne 19 (T), étiquette Ex / དཔེར་ན།.  
                S'il n'y a pas d'exemple, ce marqueur n'apparaît pas.  
                
            
            Pour la structure des exemples, voir ci-après.  
            
    3.  #### Définition française
        
        Elle se compose de  
          
        1.  **Une vedette**, distinguée par une majuscule initiale : c'est un mot français, souvent précédé d'un article (qui porte une indication de genre), parfois suivi d'une qualification. Elle peut être une phrase complète...  
            La vedette est assortie d'indications grammaticales, de niveau de langue et de "péjoratif".  
            Ces indications sont facultatives.  
              
            
            *   XML : représentée par un Element nommé Vedette, premier fils de DefFr,  
                qui contient le texte et porte 3 attributs facultatifs gram, niv et péj.  
                  
                
            *   Tableur : groupe de 4 cellules sur la même ligne, en colonnes 6 (G), 7 (H), 8 (I) et 9 (J), avec pour étiquettes  
                Entrée / མ་ཚིག། - contient le texte-vedette  
                DefGram / མ་ཚིག་གི་བརྡ་ཕྲོད་ཁྱད་ཆོས། - contient l'indication grammaticale  
                DefNiv / མ་ཚིག་གི་བེད་སྤྱོད་རིགས་དང་པོ - contient l'indication de niveau de langue  
                DefPéj / མ་ཚིག་གི་བེད་སྤྱོད་རིགས་གཉིས་པ། - contient l'indication de "péjoratif".
            
              
            
        2.  **Une liste de synonymes français**, chacun pourvu des mêmes indications de grammaire, de niveau de langue et de "péjoratif".  
            Le texte est parfois précédé du signe '≈' signalant une équivalence approximative.  
            Cette liste peut fort bien être vide, et la définition se réduire à la vedette.  
              
            *   XML : séquence d'Element nommés SyndefFr, fils de DefFr,  
                contenant du texte et portant 3 attributs facultatifs gram, niv et péj.  
                  
                
            *   Tableur : chacun occupe 4 cellules sur une ligne, en colonnes 10 (K), 11 (L), 12 (M) et 13 (N), avec pour étiquettes  
                SynFr / ཉེ་ཚིག - contient le texte-synonyme français  
                SFGram / ཉེ་ཚིག་གི་བརྡ་འཕྲོད་ཁྱད་ཆོས། - contient l'indication grammaticale  
                SFNiv / ཉེ་ཚིག་གི་བེད་སྤྱོད་རིགས་དང་པོ། - contient l'indication de niveau de langue  
                SFPéj / ཉེ་ཚིག་གི་བེད་སྤྱོད་རིགས་གཉིས་པ། - contient l'indication de "péjoratif".  
                  
                
    4.  #### Définition tibétaine
        
        Elle contient seulement **une liste de synonymes tibétains**,  
        dont chacun porte une notation phonétique en plus des trois indications de grammaire, de niveau de langue et de "péjoratif" (toutes facultatives).  
        Ici aussi, le texte est parfois précédé du signe '≈' signalant une équivalence approximative.  
          
        *   XML : séquence d'Element nommés SyndefTib, fils de DefTib,  
            contenant le texte et portant 4 attributs facultatifs phon, gram, niv et péj.  
              
            
        *   Tableur : chacun occupe 5 cellules sur une ligne, en colonnes 14 (O), 15 (P), 16 (Q), 17 (R) et 18 (S), avec pour étiquettes  
            SynTib / མ་ཚིག་གི་སྐད་སྒྱུར། - contient le texte-synonyme tibétain  
            STPhon / སྒྲ་གདངས། - contient l'indication phonétique  
            STGram /  སྐད་སྒྱུར་གྱི་བརྡ་འཕྲོད་ཁྱད་ཆོས། - contient l'indication grammaticale  
            STNiv / ཞེ་ས་ཡིན་མིན། - contient l'indication de niveau de langue  
            STPéj / དམའ་འབེབས་ཡིན་མིན། - contient l'indication de "péjoratif".  
              
            
    5.  #### Exemples
        
        Chaque exemple comporte un texte tibétain et sa traduction en français.  
        L'un comme l'autre se compose d'une liste de synonymes.  
        Les synonymes tibétains portent (de manière facultative) des indications de phonétique et de niveau de langue.  
        Les synonymes français ne portent que le niveau de langue.  
          
        *   XML :  
            1.  Le texte tibétain est représenté par un Element nommé TxtTib, fils de Exemple.  
                Chaque synonyme est représenté par un Element nommé SynEx, fils de TxtTib,  
                qui contient le texte et qui porte 2 attributs facultatifs phon et niv.  
                  
                
            2.  Le texte français est représenté par un Element nommé TxtFr, fils de Exemple.  
                Chaque synonyme est représenté par un Element nommé également SynEx, fils de TxtFr, qui porte 1 attribut facultatif niv.  
                  
                
        *   Tableur : rappelons que le marqueur Ex se trouve en colonne 19 (T)  
            1.  Les différents synonymes tibétains d'un même exemple se trouvent sur des lignes successives,  
                en colonnes 20 (U), 21 (V) et 22 (W), avec pour étiquettes  
                ExTib / དཔེ་བརྗོད། - contient le texte tibétain  
                ExTPhon / དཔེ་བརྗོད་ཀྱི་སྒྲ་གདངས། - contient l'indication phonétique  
                ExTNiv / དཔེ་བརྗོད་ཀྱི་བེད་སྤྱོད། - contient l'indication de niveau de langue.  
                  
                
            2.  Les différents synonymes français de cet exemple se trouvent sur les lignes qui suivent le tibétain  
                en colonnes 23 (X) et 24 (Y), avec pour étiquettes  
                ExFr / དཔེར་བརྗོད་ཀྱི་སྐད་བསྒྱུར། - contient le texte français  
                ExFNiv / དཔེ་བརྗོད་སྐད་སྒྱུར་གྱི་བེད་སྤྱོད། - contient l'indication de niveau de langue.  
                
    6.  #### Détails
        
        *   Rôle du caractère '྾' (`U+0FBE` = `TIBETAN KU RU KHA`)  
        Il indique normalement l'absence de synonyme tibétain acceptable : ainsi, pour la vedette "Mesdames, Messieurs", ou dans "Le gel pour
 les cheveux".  
 Mais il peut aussi être suivi d'un ou de plusieurs synonymes, ce qui peut surprendre (p.ex. "L’alcool à 90°"). Voici pourquoi :  
 Certains énoncés tibétains sont en fait du chinois, plus rarement de l'anglais. Cette circonstance est indiquée par la valeur `"chi."` (resp. `"ang."`) de l'attribut `niv`.
 Souvent, dans le cas du chinois (et dans un seul cas pour l'anglais), 
l'énoncé en question n'est pas écrit en tibétain, mais en alphabet latin
 (en pinyin pour le chinois). Si cela se produit dans le premier 
"synonyme tibétain" de la définition,  le passage de la partie française
 à la partie tibétaine de la défnition, dans le document Word à 
l'origine du projet, devient difficile à détecter. Dans ce cas, on a 
donc inséré un  '྾' postiche pour ne pas compliquer l'analyseur outre 
mesure. La configuration en question est donc un souvenir de la première
 étape du projet.
 
        *   Valeurs des attributs `gram`, `niv` et `péj` :
            1.  `gram` : comme son nom l'indique, contient des indications de genre `m.` ou `f.`, et de nature `n.`, `v.`, `adj.`, `adv.
            2.  `niv` : le niveau de langue peut être honorifique `H`, très honorifique `HH`, ou familier `fam.`
Il peut aussi indiquer l'emprunt au chinois `chi.` ou à l'anglais `ang.` : ce choix discutable est facile à modifier.
            3.  `péj` : si cet attribut est présent, sa valeur est `péj.`, signifiant que l'énoncé visé est réputé péjoratif. <br>
Serait-il préférable de le ranger aussi dans l'attribut `niv` ?
        
 
4.  ### Spécification formelle
    
    *   XML : la DTD suivante n'est pas très précise, mais elle peut rendre service.  
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!ELEMENT Vocabulaire (Chapitre+)>
<!ATTLIST Vocabulaire NomComplet CDATA #REQUIRED>
<!ELEMENT Chapitre (TitreFr, TitreTib, Section+)>
<!ATTLIST Chapitre Nom CDATA #REQUIRED>
<!ELEMENT Section (TitreFr, TitreTib, Entrée+)>
<!ATTLIST Section Nom CDATA #REQUIRED>
<!ELEMENT TitreFr (#PCDATA)>
<!ELEMENT TitreTib (#PCDATA)>

<!ELEMENT Entrée (Définition, Exemple*)>
<!ELEMENT Définition (DefFr, DefTib)>
<!ELEMENT DefFr (Vedette, SynDefFr*)>
<!ELEMENT Vedette (#PCDATA)>
<!ATTLIST Vedette gram CDATA #IMPLIED>
<!ATTLIST Vedette niv CDATA #IMPLIED>
<!ATTLIST Vedette péj CDATA #IMPLIED>
<!ELEMENT DefTib (SynDefTib)+>
<!ELEMENT SynDefFr (#PCDATA)>
<!ELEMENT SynDefTib (#PCDATA)>
<!ATTLIST SynDefFr gram CDATA #IMPLIED>
<!ATTLIST SynDefFr niv CDATA #IMPLIED>
<!ATTLIST SynDefFr péj CDATA #IMPLIED>
<!ATTLIST SynDefTib gram CDATA #IMPLIED>
<!ATTLIST SynDefTib niv CDATA #IMPLIED>
<!ATTLIST SynDefTib phon CDATA #IMPLIED>
<!ATTLIST SynDefTib péj CDATA #IMPLIED>

<!ELEMENT Exemple (TxtTib, TxtFr)>
<!ELEMENT TxtTib (SynEx+)>
<!ELEMENT TxtFr (SynEx+)>
<!ELEMENT SynEx (#PCDATA)>
<!ATTLIST SynEx niv CDATA #IMPLIED>
<!ATTLIST SynEx phon CDATA #IMPLIED>
```
        
    *   Tableur : une grammaire pour le CSV (à écrire)
