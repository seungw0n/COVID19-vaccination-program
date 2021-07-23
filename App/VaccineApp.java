import java.sql.* ;
import java.util.Scanner;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

class VaccineApp {
    static Connection con;
    static Statement statement;
    static LocalDate dateObj = LocalDate.now();
    static DateTimeFormatter formatObj = DateTimeFormatter.ofPattern("MM-dd-yyyy");
    static String dateToday= dateObj.format(formatObj);

    public static boolean updatePerson(String name, String gender, String phone, String date, String city,  String postalCode, String address, int priority, String hInsurNum)
    {
        try
        {
            String updateSQL = "UPDATE PEOPLE SET (name, gender, phone, dob, city, postalcode, streetaddress, priority) = (\'"  +
    				name + "\', \'" + gender + "\', \'" + phone + "\', \'" + date + "\', \'" + city + "\', \'" + postalCode + "\', \'" + address + "\', " + priority +
    				") WHERE hinsurnum = \'" + hInsurNum + "\'";
            System.out.println(updateSQL);
            statement.executeUpdate(updateSQL);
            System.out.println("UPDATE INFORMATION COMPLETED");
            return true;
        }
        catch (SQLException e)
        {
          int sqlCode = e.getErrorCode(); // Get SQLCODE
          String sqlState = e.getSQLState(); // Get SQLSTATE

          // Your code to handle errors comes here;
          // something more meaningful than a print would be good
          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
          System.out.println(e);
          return false;
        }
    }

    public static boolean addPerson(Scanner sc, String name, String gender, String phone, String date, String city,  String postalCode, String address, int priority, String hInsurNum) {
        try {
            String querySQL = "SELECT * from PEOPLE WHERE hinsurnum = \'" + hInsurNum + "\'";
            // System.out.println("Add person: " + querySQL);
            java.sql.ResultSet rs = statement.executeQuery(querySQL);

            if(rs.next()) {
                System.out.println("Do you want to update information? (Y/N)");
                String input = sc.nextLine();
                if(input.equals("Y"))
                    return updatePerson(name, gender, phone, date, city, postalCode, address, priority, hInsurNum);
                else
                    return true;
            } else {
                // Insert new people, make sure that inserting registrations and appointments too.
                String insertSQL = "INSERT INTO PEOPLE VALUES (\'" + name + "\', \'" + gender + "\', \'" + phone + "\', \'" + date + "\', \'" + city + "\', \'" + postalCode + "\', \'" + address + "\', " + priority + ", \'" + hInsurNum + "\')";
                System.out.println ( insertSQL ) ;
                statement.executeUpdate ( insertSQL ) ;
                System.out.println ( "ADD A PERSON COMPLETED" ) ;

                // Insert new REGISTRATIONS
                String rId = "RID" + date.substring(6,10) + hInsurNum + priority;

                insertSQL = "INSERT INTO REGISTRATIONS VALUES (\'" + rId + "\', \'" + dateToday + "\')";
                System.out.println ( insertSQL ) ;
                statement.executeUpdate ( insertSQL ) ;
                System.out.println ( "ADD A REGISTRATION COMPLETED" ) ;

                // Insert new APPOINTMENTS
                insertSQL = "INSERT INTO APPOINTMENTS VALUES (\'" + rId + "\', \'" + hInsurNum + "\')";
                System.out.println ( insertSQL ) ;
                statement.executeUpdate ( insertSQL ) ;
                System.out.println ( "ADD AN APPOINTMENT COMPLETED" ) ;

                return true;
            }
        } catch (SQLException e) {
            int sqlCode = e.getErrorCode(); // Get SQLCODE
            String sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            return false;
         }
        // Query to check if there exists hInsurNum
        // If no exists, add a person <-> register
        // Otherwise call method updatePerson
    }

    public static boolean isValidDate(String date) {
        String[] arr1 = date.split("-");
        String[] arr2 = dateToday.split("-");


        int year1 = Integer.parseInt(arr1[0]);
        int year2 = Integer.parseInt(arr2[2]);

        int m1 = Integer.parseInt(arr1[1]);
        int m2 = Integer.parseInt(arr2[0]);

        int d1 = Integer.parseInt(arr1[2]);
        int d2 = Integer.parseInt(arr2[1]);

        if(year1 > year2)
        	return true;
        else if (year1 == year2) {
        	if (m1 > m2)
        		return true;
        	else if (m1 == m2) {
        		if (d1 > d2)
        			return true;
        		else
        			return false;
        	} else
        		return false;
        } else
        	return false;
    }

    public static boolean insertAssigned(String lname, String vtime, int vslot, String hinsurnum) {
        try {
            String insertSQL = "INSERT INTO ASSIGNED VALUES (\'" + lname + "\', \'" + vtime + "\', " + vslot + ", \'" + hinsurnum + "\', \'" + dateToday + "\')";
            System.out.println ( insertSQL ) ;
            statement.executeUpdate ( insertSQL ) ;
            System.out.println ( "DONE" ) ;
            return true;
        } catch (SQLException e) {
            int sqlCode = e.getErrorCode(); // Get SQLCODE
            String sqlState = e.getSQLState(); // Get SQLSTATE
            System.out.println("****Insert Assigned ERROR****");
            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            return false;
         }
    }

    public static boolean assignSlot(String lname, String vtime, int vslot, String hinsurnum) {
        // Check the slot is available to be assigned
        try {
            String querySQL = "SELECT LOCATIONS.LDATE FROM LOCATIONS, SLOTS WHERE LOCATIONS.LNAME = SLOTS.LNAME AND SLOTS.LNAME = \'" + lname + "\' AND SLOTS.VTIME = \'" + vtime + "\' AND SLOTS.VSLOT = \'" + vslot + "\'";
            java.sql.ResultSet rs = statement.executeQuery(querySQL);

            if ( rs.next() ) {

                String date = rs.getString(1);
                System.out.println("Date: " + date);
                System.out.println("Today: " + dateToday);

                if (isValidDate(date)) {
                    querySQL = "SELECT * FROM ASSIGNED WHERE LNAME = \'" + lname + "\' AND VTIME = \'" + vtime + "\' AND VSLOT = \'" + vslot + "\'";
                    System.out.println(querySQL);
                    rs = statement.executeQuery(querySQL);

                    if ( rs.next() ) {
                        System.out.println("ERROR: The slot has been assigned");
                        return false;
                    }

                    // If the slot is available to be assigned,
                    querySQL = "SELECT VNAME, COUNT(*) AS COUNT FROM SHOTS WHERE HINSURNUM = \'" + hinsurnum + "\' GROUP BY VNAME";
                    System.out.println(querySQL);
                    rs = statement.executeQuery(querySQL);
                    if ( rs.next() ) {
                        String vname = rs.getString(1);
                        int count = rs.getInt(2);
                        querySQL = "SELECT NUMDOSES FROM VACCINES WHERE VNAME = \'" + vname + "\'";
                        System.out.println(querySQL);
                        rs = statement.executeQuery(querySQL);

                        if (rs.next()) {
                            int numdoses = rs.getInt(1);
                            System.out.println("Number doses: " + numdoses);
                            if (count == numdoses) {
                                System.out.println("ERROR: No more vaccine is required");
                                return false;
                            } else {
                                System.out.println("Call insert");
                                return insertAssigned(lname, vtime, vslot, hinsurnum);
                            }
                        }
                    }

                    System.out.println("Call insert");
                    return insertAssigned(lname, vtime, vslot, hinsurnum);

                }
                System.out.println("ERROR: SLOT DATE IS INVALID");
                return false;
            }

            System.out.println("ERROR: SLOT IS INVALID");
            return false;

        } catch (SQLException e) {
            int sqlCode = e.getErrorCode(); // Get SQLCODE
            String sqlState = e.getSQLState(); // Get SQLSTATE
            System.out.println("****ASSIGNED SLOT ERROR****");
            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            return false;
         }
    }

    public static boolean addShot(String vialnum, String lname, String vtime, int vslot, String hinsurnum, String vname) {
        try {
            String querySQL = "SELECT VNAME FROM SHOTS WHERE HINSURNUM = \'" + hinsurnum + "\'";
             java.sql.ResultSet rs = statement.executeQuery(querySQL);
             if(rs.next()) {
                 String prevName = rs.getString(1);
                 if (!prevName.equals(vname)) {
                     System.out.println("ERROR: Previous vaccine and current vaccine are not matched!");
                     return true;
                 }
             }
             String insertSQL = "INSERT INTO SHOTS VALUES (\'" + vialnum + "\', \'" + lname + "\', \'" + vtime + "\', " + vslot + ", \'" + hinsurnum + "\', \'" + vname + "\')";
             System.out.println ( insertSQL ) ;
             statement.executeUpdate ( insertSQL ) ;
             System.out.println ( "DONE" ) ;
             return true;

        } catch (SQLException e) {
            int sqlCode = e.getErrorCode(); // Get SQLCODE
            String sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            return false;
         }
    }

    public static void main ( String [ ] args ) throws SQLException
    {
        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now !
        String url = "jdbc:db2://winter2021-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = null;
        String your_password = null;

        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        con = DriverManager.getConnection (url,your_userid,your_password) ;
        statement = con.createStatement ( ) ;

        // Scanner object to read command input
        Scanner sc = new Scanner(System.in);

        String userInput = "";
        while(true) {
            System.out.println("\nVaccineApp Main Menu");
            System.out.println("\t1. Add a Person");
            System.out.println("\t2. Assign a slot to a Person");
            System.out.println("\t3. Enter Vaccination information");
            System.out.println("\t4. Exit Application");
            System.out.println("Please Enter Your Option: ");

            userInput = sc.nextLine();
            if(userInput.equals("4")) {
                System.out.println("Good Bye");
                break;
            } else if(userInput.equals("1")) {
            	System.out.println("Please enter health insurance number: ");
                String hInsurNum = sc.nextLine();
                System.out.println("Please enter name: ");
                String name = sc.nextLine();
                System.out.println("Please enter gender: (m,f)");
                String gender = sc.nextLine();
                System.out.println("Please enter phone number: (11 digits with country code)");
                String phone  = sc.nextLine();
                System.out.println("Please enter dob: (MM-dd-YEAR)");
                String date = sc.nextLine();
                System.out.println("Please enter street address: ");
                String address = sc.nextLine();
                System.out.println("Please enter city:");
                String city = sc.nextLine();
                System.out.println("Please enter postal code:");
                String postalCode = sc.nextLine();
                System.out.println("Please enter priority number: ");
                int priority = Integer.parseInt(sc.nextLine());

                boolean result = addPerson(sc, name, gender, phone, date, city, postalCode, address, priority, hInsurNum);
                System.out.println(result);
            } else if(userInput.equals("2")) {
                System.out.println("Please enter health insurance number: ");
                String hInsurNum = sc.nextLine();
                System.out.println("Please enter location name: ");
                String lname = sc.nextLine();
                System.out.println("Please enter time: ");
                String vtime = sc.nextLine();
                System.out.println("Please enter slot number: ");
                String vslot = sc.nextLine();
                int slot = Integer.parseInt(vslot);
                boolean result  = assignSlot(lname, vtime, slot, hInsurNum);
                System.out.println(result);
            } else if(userInput.equals("3")) {
                System.out.println("Please enter health insurance number: ");
                String hinsurnum = sc.nextLine();
                System.out.println("Please enter vial number: ");
                String vialnum = sc.nextLine();
                System.out.println("Please enter location name: ");
                String lname = sc.nextLine();
                System.out.println("Please enter time: ");
                String vtime = sc.nextLine();
                System.out.println("Please enter slot number: ");
                String vslot = sc.nextLine();
                int slot = Integer.parseInt(vslot);
                System.out.println("Please enter vaccine name: ");
                String vname = sc.nextLine();

                boolean result = addShot(vialnum, lname, vtime, slot, hinsurnum, vname);
            }
        }


      // Finally but importantly close the statement and connection
      statement.close ( ) ;
      con.close ( ) ;
    }
}
