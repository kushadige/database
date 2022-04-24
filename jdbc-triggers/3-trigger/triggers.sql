-- BASLAMADAN ONCE KAYITLARI GUNCELLEMEK ICIN KOD
UPDATE course C SET studentCount = (SELECT count(C.cid) FROM take,course WHERE take.cid=course.cid AND take.cid = C.cid);

-- KAYIT EKLENİNCE AKTİF OLACAK TRİGGER
DROP TRIGGER IF EXISTS Trigger_1;

DELIMITER //
CREATE TRIGGER Trigger_1 AFTER INSERT ON take
FOR EACH ROW
BEGIN
UPDATE course SET studentCount = (SELECT count(NEW.cid) FROM take,course
				  WHERE take.cid=course.cid AND NEW.cid=take.cid)
WHERE cid=NEW.cid;
END; //
DELIMITER ;

-- KAYIT SİLİNİNCE AKTİF OLACAK TRİGGER
DROP TRIGGER IF EXISTS Trigger_2;

DELIMITER //
CREATE TRIGGER Trigger_2 AFTER DELETE ON take
FOR EACH ROW
BEGIN
UPDATE course SET studentCount = (SELECT count(OLD.cid) FROM take,course
				  WHERE take.cid=course.cid AND OLD.cid=take.cid)
WHERE cid=OLD.cid;
END; //
DELIMITER ;

-- KAYIT GÜNCELLENİRSE AKTİF OLACAK TRİGGER
DROP TRIGGER IF EXISTS Trigger_3;

DELIMITER //
CREATE TRIGGER Trigger_3 AFTER UPDATE ON take
FOR EACH ROW
BEGIN
	IF(NEW.cid!=OLD.cid) THEN
		UPDATE course C 
		SET studentCount = (SELECT count(C.cid) 
							FROM take,course
							WHERE take.cid=course.cid 
							AND C.cid=take.cid);
	END IF;
END; //
DELIMITER ;