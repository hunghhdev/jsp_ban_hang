package UtilCommon;

public class Constants {

    public static String FACEBOOK_APP_ID = "1111495145565142";
    public static String FACEBOOK_APP_SECRET = "a7ac35b1b0bf29013125079a064498c0";
    public static String FACEBOOK_REDIRECT_URL = "https://localhost:8443/GOM-NB/login-facebook";
    public static String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";

    public static String GOOGLE_CLIENT_ID = "480987340761-49kq3abph4d02uosnk80luredhabcgeh.apps.googleusercontent.com";
    public static String GOOGLE_CLIENT_SECRET = "6K6CeoTltBoVOXnoGVLn1jsd";
    public static String GOOGLE_REDIRECT_URI = "https://localhost:8443/GOM-NB/login-google";
    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";
}
