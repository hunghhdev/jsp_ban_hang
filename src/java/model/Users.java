package model;

import java.util.Date;

public class Users {
    private long userId;
    private String userName;
    private String userPhone;
    private String userEmail;
    private String userPass;
    private boolean userSex;
    private Date userBirthday;
    private String userFBId;
    private String userGGId;
    private float userDollar;

    public Users() {
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public boolean isUserSex() {
        return userSex;
    }

    public void setUserSex(boolean userSex) {
        this.userSex = userSex;
    }

    public Date getUserBirthday() {
        return userBirthday;
    }

    public void setUserBirthday(Date userBirthday) {
        this.userBirthday = userBirthday;
    }

    public String getUserFBId() {
        return userFBId;
    }

    public void setUserFBId(String userFBId) {
        this.userFBId = userFBId;
    }

    public String getUserGGId() {
        return userGGId;
    }

    public void setUserGGId(String userGGId) {
        this.userGGId = userGGId;
    }

    public float getUserDollar() {
        return userDollar;
    }

    public void setUserDollar(float userDollar) {
        this.userDollar = userDollar;
    }
    
}
