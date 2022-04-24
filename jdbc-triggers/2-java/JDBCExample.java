import java.sql.*;
import java.util.Scanner;

public class JDBCExample extends Functions{

    private static String kullanici_adi = "root";
    private static String parola = "";
    private static String db_adi = "odev";
    private static String host = "localhost";
    private static int port = 3306;
    //"jdbc:mysql://localhost:3306/odev"
    private static String url = "jdbc:mysql://" + host + ":" + port + "/" + db_adi;
    
    public static void main(String []args){
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Where is your JDBC Driver? " + "Include in your library path!");
            e.printStackTrace();
            return;
        }
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url , kullanici_adi, parola);
	    } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;
	    }
        if (connection != null)
            System.out.println("You made it, take control your database now!");
	    else
            System.out.println("Failed to make connection!");
        try {
            Statement st = connection.createStatement();

            anasayfa(st);
            
            st.close(); 
	        } catch (SQLException e) {
            System.out.println("Error occurred");
	        e.printStackTrace();
	        return;
        }     
    }
    
}
class Functions {
    public static int id;
    public static String name;
    public static String gender;
    public static int status;
    public static String field;
    public static Scanner in = new Scanner(System.in);
    
    public static void anasayfa(Statement st){

        sanatciListele(st);
        while(true){
            
            int islem = in.nextInt();
            in.nextLine();
            
            if(islem==1)
                sanatciEkle(st);
            else if(islem==2)
                sanatciSil(st);
            else if(islem==3)
                sanatciGuncelle(st);
            else if(islem==5)
                break;
            else if(islem==4)
                sanatciListele(st);
            else
                System.out.println("HATALİ SECİM...");
        }
    }
    //SANATÇI EKLEME
    public static void sanatciEkle(Statement st){    
        System.out.print("ID:");
        id = in.nextInt();
        in.nextLine();
        System.out.print("Name:");
        name = in.nextLine();
        System.out.println(name);
        System.out.print("Gender:(M/F)");
        gender = in.nextLine();
        System.out.println(gender);
        while(!("M".equals(gender) || "F".equals(gender)) ){
            System.out.println("Lütfen cinsiyeti dogru giriniz..(give input like M or F)");
            gender = in.nextLine();
        }
        System.out.print("Status:(0 or 1)");
        status = in.nextInt();
        in.nextLine();
        while(!(status == 1 || status == 0)){
            System.out.println("Lütfen durum bilgisini 1 veya 0 olacak sekilde giriniz...");
            status = in.nextInt();
            in.nextLine();
        }
        System.out.print("Field:(Music/Painting/Calligraphy)");
        field = in.nextLine();
        while(!("Music".equals(field) || "Painting".equals(field) || "Calligraphy".equals(field)) ){
            System.out.println("Lütfen alan bilgisini seceneklerden biri olarak giriniz...(Music/Painting/Calligraphy)");
            field = in.nextLine();
        }
        try {
            st.executeUpdate("INSERT INTO artist VALUES("+id+",'"+name+"','"+gender+"',"+status+",'"+field+"')");
        } catch (SQLException ex) {
            System.out.println("Could not insert tuple");
        }
        sanatciListele(st);
    }
    //SANATÇI LİSTELEME
    public static void sanatciListele(Statement st) {
        //System.out.println("SANATCI LİSTESİ---------------------\n");
        String s = "\nID\tName\tGender\tStatus\tField";
        System.out.println(s);
        try {
            ResultSet rs = st.executeQuery("SELECT * FROM artist");
            while(rs.next()){
                System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" +
                        rs.getString(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5));
            }
        } catch (SQLException ex) {
            System.out.println("HATA.... SANATCİ EKLENEMEDİ");
            ex.getStackTrace();
        }
        menu();
    }   
    //SANATÇI SİLME
    public static void sanatciSil(Statement st){
        System.out.println("Silmek istediginiz sanatci IDsi?(anasayfaya dönmek icin -1 i tuslayin..)");
        int del_id = in.nextInt();
        in.nextLine();
        if(del_id == -1){
            anasayfa(st);
        }
        else{
            try {
                st.executeUpdate("DELETE FROM artist WHERE id="+del_id);
            } catch (SQLException ex) {
                System.out.println("HATA.... SANATCİ SİLİNEMEDİ...");
                ex.getStackTrace();
            }
            sanatciListele(st);
        }
    }
    //SANATÇI GÜNCELLEME
    public static void sanatciGuncelle(Statement st){
        System.out.println("Güncellemek istediginiz sanatci IDsi?");
        int upd_id = in.nextInt();
        in.nextLine();
        
        System.out.print("Update Name:");
        name = in.nextLine();
        System.out.println(name);
        System.out.print("Update Gender:(M/F)");
        gender = in.nextLine();
        System.out.println(gender);
        while(!("M".equals(gender) || "F".equals(gender)) ){
            System.out.println("Lütfen cinsiyeti dogru giriniz..(give input like M or F)");
            gender = in.nextLine();
        }
        System.out.print("Update Status:(0 or 1)");
        status = in.nextInt();
        in.nextLine();
        while(!(status == 1 || status == 0)){
            System.out.println("Lütfen durum bilgisini 1 veya 0 olacak sekilde giriniz...");
            status = in.nextInt();
            in.nextLine();
        }
        System.out.print("Update Field:(Music/Painting/Calligraphy)");
        field = in.nextLine();
        while(!("Music".equals(field) || "Painting".equals(field) || "Calligraphy".equals(field)) ){
            System.out.println("Lütfen alan bilgisini seceneklerden biri olarak giriniz...(Music/Painting/Calligraphy)");
            field = in.nextLine();
        }
        try {//UPDATE artist SET name=.., gender=.., status=.., field=.. WHERE id=upd_id
            st.executeUpdate("UPDATE artist SET name='"+name+"', gender='"+gender+"', status="+status+", field='"+field+"' WHERE id="+upd_id);
        } catch (SQLException ex) {
            System.out.println("Could not update tuple");
        }
        sanatciListele(st);
    }
    public static void menu(){
        System.out.println("-------------------------------------\n"
                + "\t(1)SANATCİ EKLE\n\t(2)SANATCİ SİL\n"
                + "MENU\t(3)SANATCİ GUNCELLE\n\t(4)SANATCİ LİSTELE\n\t(5)ÇIKIŞ");
    }
}