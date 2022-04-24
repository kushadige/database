<html>
<head></head>
<body>
<?php
switch(@$_GET['in']){
    case 'sanatcilar': sanatciListele(); break;
    case 'eklemeformu': eklemeFormu(); break;
    case 'sanatciEkle': sanatciEkle($_GET['no'], $_GET['ad'], $_GET['cinsiyet'], $_GET['Status'], $_GET['field']); break;
    case 'sanatciSil': sanatciSil($_GET['id']); break;
    case 'guncelleFormu': guncellemeFormu(); break;
    case 'sanatciGuncelle': sanatciGuncelle($_GET['rt'],$_GET['no'],$_GET['ad'],$_GET['cinsiyet'],$_GET['Status'],$_GET['field']); break;
    default: anasayfa();
}
function anasayfa(){
    sanatciListele();
}
function sanatciEkle($id,$name,$gender,$Status,$field){
    $sql = "INSERT INTO artist VALUES($id,'$name','$gender',$Status,'$field');";
    echo $sql;
    $baglan = mysqli_connect('localhost','root','','odev');
    $sonuc = mysqli_query($baglan,$sql);
    sanatciListele();
}
function sanatciGuncelle($rt,$id,$name,$gender,$Status,$field){
    $sql = "UPDATE artist SET id=$id, name='$name', gender='$gender', status=$Status, field='$field' WHERE ID=$rt;";
    echo $sql;
    $baglan = mysqli_connect('localhost','root','','odev');
    $sonuc = mysqli_query($baglan,$sql);
    sanatciListele();
}
function sanatciSil($id){
    $sql = "DELETE FROM artist WHERE id=$id;";
    echo $sql;
    $baglan = mysqli_connect('localhost','root','','odev');
    $sonuc = mysqli_query($baglan,$sql);
    sanatciListele();
}
function eklemeformu(){
    echo 'sanatci olusturma formu hazirlaniyor..</br>';
    echo "
    <a href=?in=anasayfa>Anasayfaya Dön</a>
	<form action='?' method=get>
	<h3>Yeni Sanatci</h3>
    	<table>
            <tr><td>ID</td> <td><input type=text name=no></td></tr>
	        <tr><td>Adi</td> <td><input type=text name=ad></td></tr>
            <tr><td>Cinsiyet</td> <td><input type=radio name=cinsiyet value=M id='e1'> <label for='e1'>Erkek</label> 
                                      <input type=radio name=cinsiyet value=F id='k1'> <label for='k1'>Kiz</label></td></tr>
                                      <input type=hidden value=0 name=Status>
                                      <tr><td>Status</td> <td><input type=checkbox name=Status value=1 id='s1'></td></tr>
            <tr><td>Field</td> <td><select name=field><option>Music</option><option>Painting</option><option>Calligraphy</option></select></td></tr>
	        <tr><td></td> <td><input type=submit value=Olustur></td></tr>
	    </table>
	<input type=hidden name=in value=sanatciEkle>
	</form>";
}
function guncellemeFormu(){
    $rt = $_GET['ID'];
    $sql = "SELECT * FROM artist WHERE ID=$rt;";
    $baglan = mysqli_connect('localhost','root','','odev');
    $kayitlar = mysqli_query($baglan,$sql);
    $satir = mysqli_fetch_assoc($kayitlar);
    echo "guncelleme formu hazirlaniyor..";
    echo "
    <a href=?in=anasayfa>Anasayfaya Dön</a>
    <form action='?' method=get>
    <h3>Sanatci Guncelle</h3>
        <table>
            <tr><td>ID</td> <td>$rt</td></tr>
            <tr><td>Yeni ID</td> <td><input type=text name=no value={$satir['id']}></td></tr>
            <tr><td>Yeni Adi</td> <td><input type=text name=ad value={$satir['name']}></td></tr>
            <tr><td>Cinsiyet</td> <td><input type=radio name=cinsiyet value=M id='e1' ".($satir['gender']=='M' ? 'checked' : '')."> <label for='e1'>Erkek</label> 
                                      <input type=radio name=cinsiyet value=F id='k1' ".($satir['gender']=='F' ? 'checked' : '')."> <label for='e1'>Kiz</label> 
                                      <input type=hidden value=0 name=Status>
                                      <tr><td>Status</td> 
                                      <td><input type=checkbox name=Status value=1 id='s1' ".($satir['status']==1 ? 'checked' : '')."> </td></tr>
            <tr><td>Field</td> <td><select name=field><option ".($satir['field']=='Music' ? 'selected' : '').">Music</option>
                                                    <option ".($satir['field']=='Painting' ? 'selected' : '').">Painting</option>
                                                    <option ".($satir['field']=='Calligraphy' ? 'selected' : '').">Calligraphy</option></select></td></tr>
            <tr><td></td> <td><input type=submit value=Guncelle></td></tr>
        </table>
        <input type=hidden name=rt value=$rt>
        <input type=hidden name=in value=sanatciGuncelle>
    </form>";
}
function sanatciListele(){
    echo "<h1>Sanatci listesi</h1>
          <a href='?in=eklemeformu'>Yeni Ekle</a></br>
          <table class='table table-dark'> <thead><tr> <th>ID</th> <th>Adi</th> <th>Cinsiyet</th> <th>Status</th> <th>Field</th> </tr></thead><tbody>";
    $baglan = mysqli_connect('localhost','root','','odev');
    $kayitlar = mysqli_query($baglan,"SELECT * FROM artist;");
    while($satir = mysqli_fetch_assoc($kayitlar)){
        echo "
        <tr>
        <td>{$satir['id']}</td>
        <td>{$satir['name']}</td>
        <td>{$satir['gender']}</td>
        <td>{$satir['status']}</td>
        <td>{$satir['field']}</td>
        <td> <a href=?in=sanatciSil&id={$satir['id']}>Sil</a>
        <td> <a href=?in=guncelleFormu&ID={$satir['id']}>Guncelle</a>
        </tr>";
    }
}
?>
</body>
</html>