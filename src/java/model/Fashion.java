package model;

public class Fashion {
    private long fashionId;
    private String fashionName;

    public Fashion() {
    }

    public Fashion(String fashionName) {
        this.fashionName = fashionName;
    }

    public Fashion(long fashionId, String fashionName) {
        this.fashionId = fashionId;
        this.fashionName = fashionName;
    }

    public long getFashionId() {
        return fashionId;
    }

    public void setFashionId(long fashionId) {
        this.fashionId = fashionId;
    }

    public String getFashionName() {
        return fashionName;
    }

    public void setFashionName(String fashionName) {
        this.fashionName = fashionName;
    }
}
