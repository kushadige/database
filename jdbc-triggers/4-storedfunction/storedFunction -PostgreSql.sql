CREATE FUNCTION ortakOgrenciSayisi(cid1 INTEGER, cid2 INTEGER)
RETURNS TABLE (sid INTEGER, 
			   name VARCHAR(50), 
			   did INTEGER, 
			   noOfCourses INTEGER, 
			   GPA FLOAT)
LANGUAGE 'plpgsql'
AS
$BODY$
BEGIN
RETURN QUERY
	SELECT student.sid,student.name,student.did,student.noOfCourses,student.GPA
	FROM student
	WHERE student.sid IN(SELECT t1.sid
						FROM take t1, take t2
						WHERE t1.sid = t2.sid
						AND t1.cid = cid1
						AND t2.cid = cid2);
END;
$BODY$;