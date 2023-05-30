
import org.w3c.dom.Document; 
import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Element; 

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory; 

import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.OutputKeys;  

import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader; 

public class Csv2Xml{

   /* La procédure-maîtresse :
      Création d'un document XML à partir du texte CSV lu ligne à ligne, 
   */
    public static Document docFromText (BufferedReader in) throws Exception{
    	DocumentBuilder parser = DocumentBuilderFactory.newInstance().newDocumentBuilder();
    	DOMImplementation domi = parser.getDOMImplementation(); 
	
		Document doc = domi.createDocument(null, "Vocabulaire", null);
		Element root = doc.getDocumentElement();
		root.setAttribute("NomComplet", "Vocabulaire thématique bilingue de langue parlée français-tibétain");
		
		/* Une pile de variables globales par rapport à la boucle de lecture,
  			avec des initialisations bidon pour satisfaire le compilateur :
 		   "error: variable XXX might not have been initialized"
 		   Elles matérialisent la pile qui gère la hiérarchie XML
 		   On ne mentionne que les éléments qui sont nécessairement créés,
 		   les autres seront produits en cas de besoin seulement.
		*/

		Element chapitre = doc.createElement("Chapitre");
		Element section = doc.createElement("Section");
		Element entree = doc.createElement("Entrée");
		Element definition = doc.createElement("Définition");
		Element defFr = doc.createElement("DefFr");
		Element vedette = doc.createElement("Vedette");
		boolean dansDefTib = false;
		Element defTib = doc.createElement("DefTib");
		Element expl = doc.createElement("Exemple");
		boolean dansExTib = false;
		Element txtTib = doc.createElement("TxtTib");
		boolean dansExFr = false;
		Element txtFr = doc.createElement("TxtFr");
		
		// La boucle ligne à ligne (du tableur)
		String[] tline; // pour analyser la ligne
		int ntl ; // pour loger le rang de la première cellule non vide
		
		String line = in.readLine(); // la 1ère ligne, formée d'en-têtes
		line = in.readLine(); // on la saute !
        do {
        	tline = line.split(";", -2); //toutes les cases séparées par ';' même vides !
        	ntl = numCol(line); // le rang de la première cellule non vide
        	switch( ntl ){
        		
        		case 0 :{ // col A : chapitre
//					System.out.println(line);
					chapitre = doc.createElement("Chapitre");
					root.appendChild(chapitre); 
					chapitre.setAttribute("Nom", tline[0]); // à savoir "1", "2", etc
					Element titreFr = doc.createElement("TitreFr");
					chapitre.appendChild(titreFr);
					titreFr.appendChild(doc.createTextNode(tline[1]));
					Element titreTib = doc.createElement("TitreTib");
					chapitre.appendChild(titreTib);
					titreTib.appendChild(doc.createTextNode(tline[2]));
					
					break;
				}
        		
        		case 3 :{ // col D : section
//					System.out.println(line);
					section = doc.createElement("Section");
					chapitre.appendChild(section);
					section.setAttribute("Nom", tline[3]); // à savoir "1.1.", "1.2.", etc
					Element titreFr = doc.createElement("TitreFr");
					section.appendChild(titreFr);
					titreFr.appendChild(doc.createTextNode(tline[4]));
					Element titreTib = doc.createElement("TitreTib");
					section.appendChild(titreTib);
					titreTib.appendChild(doc.createTextNode(tline[5]));
					
					break;
				}
        		
        		case 6 :{ // col G : entrée : vedette fr.
//					System.out.println(line);
//					System.out.println(tline.length);
					entree = doc.createElement("Entrée");
					section.appendChild(entree);
					definition = doc.createElement("Définition");
					entree.appendChild(definition);
					defFr = doc.createElement("DefFr");
					definition.appendChild(defFr);
					vedette = doc.createElement("Vedette");
					defFr.appendChild(vedette);
					vedette.appendChild(doc.createTextNode(tline[6]));
					if( tline[7].length() > 0 ) vedette.setAttribute("gram", tline[7]);
					if( tline[8].length() > 0 ) vedette.setAttribute("niv", tline[8]);
					if( tline[9].length() > 0 ) vedette.setAttribute("péj", tline[9]);

					dansDefTib = false; //préparer la liste SynDefTib
					
					break;
				}
				
				case 10 :{ // col K : Entrée / Définition/ DefFr/SynDefFr
//					System.out.println(line);
//					System.out.println(tline.length);
					Element synDefFr = doc.createElement("SynDefFr");
					defFr.appendChild(synDefFr);
					synDefFr.appendChild(doc.createTextNode(tline[10]));
					if( tline[11].length() > 0 ) synDefFr.setAttribute("gram", tline[11]);
					if( tline[12].length() > 0 ) synDefFr.setAttribute("niv", tline[12]);
					if( tline[13].length() > 0 ) synDefFr.setAttribute("péj", tline[13]);
			
					break;
				}

				case 14 :{// col O : Entrée / Définition/ DefTib/SynDefTib
//					System.out.println(line);
//					System.out.println(tline.length);
					if( !dansDefTib ){
						defTib = doc.createElement("DefTib");
						definition.appendChild(defTib);
						dansDefTib = true;
					}
					Element synDefTib = doc.createElement("SynDefTib");
					defTib.appendChild(synDefTib);
					synDefTib.appendChild(doc.createTextNode(tline[14]));
					if( tline[15].length() > 0 ) synDefTib.setAttribute("phon", tline[15]);
					if( tline[16].length() > 0 ) synDefTib.setAttribute("gram", tline[16]);
					if( tline[17].length() > 0 ) synDefTib.setAttribute("niv", tline[17]);
					if( tline[18].length() > 0 ) synDefTib.setAttribute("péj", tline[18]);
					
					break;
				}
				
 				case 19 :{ // col T : Entrée / Exemples
//					System.out.println(line);
//					System.out.println(tline.length);
					expl = doc.createElement("Exemple");
					entree.appendChild(expl);
					dansExTib = false;
					dansExFr = false;
					
					break;
				}

				case 20 :{ // col U : Entrée /Exemple/TxtTib/SynEx
//					System.out.println(line);
//					System.out.println(tline.length);
					if( !dansExTib ){
						txtTib = doc.createElement("TxtTib");
						expl.appendChild(txtTib);
						dansExTib = true;
					}
					Element synEx = doc.createElement("SynEx");
					txtTib.appendChild(synEx);
					synEx.appendChild(doc.createTextNode(tline[20]));
					if( tline[21].length() > 0 ) synEx.setAttribute("phon", tline[21]);
					if( tline[22].length() > 0 ) synEx.setAttribute("niv", tline[22]);
					
					break;
				}				

				case 23 :{ // col X : Entrée /Exemple/TxtFr/SynEx
//					System.out.println(line);
//					System.out.println(tline.length);
					if( !dansExFr ){
						txtFr = doc.createElement("TxtFr");
						expl.appendChild(txtFr);
						dansExFr = true;
					}
					Element synEx = doc.createElement("SynEx");
					txtFr.appendChild(synEx);
					synEx.appendChild(doc.createTextNode(tline[23]));
					if( tline[24].length() > 0 ) synEx.setAttribute("niv", tline[24]);
					
					break;
				}
				
	       		default : throw  new Exception ("Ligne csv incorrecte : "+line);
	       		/* Attention ! ce contrôle risque de détecter des lignes blanches
	       		   dans un csv travaillé "à la main".
	       		   Le désactiver si nécessaire. */
        	}// fin du switch

			line = in.readLine(); 
        } while ( line != null );

		return doc;
	}//docFromText

//========================================================================================
	
	public static int numCol (String line){// le rang de la première cellule non vide
		int k = 0;
		int lln = line.length();
		while( k < lln && line.charAt(k) == ';' ){
			k++;
		}
		return k;
	}
	

//========================================================================================
	
	public static void out2File (Document doc, String fileName) throws Exception {
		DOMSource src = new DOMSource(doc);
    	StreamResult res = new StreamResult(new File(fileName));
    	
    	Transformer trans = TransformerFactory.newInstance().newTransformer();
		trans.setOutputProperty(OutputKeys.INDENT, "yes"); // easy reading

		trans.transform(src, res);
	}// out2File

//========================================================================================

	
    public static void main(String[] args) throws Exception{
    
    	String usage = "java Csv2Xml doc1.csv doc2.xml";
		if( args.length < 2 ){
			System.out.println ("usage : "+usage);
			System.exit(1);
		}
		String fileIn = args[0];
		String fileOut = args[1];

		BufferedReader in = 
			new BufferedReader (new FileReader (fileIn));

	    Document doc = docFromText(in);
		
		out2File(doc, fileOut);
   
    } // main
}//class Csv2Xml