package model;

public class ProductSize {
    private long productId;
    private boolean xs;
    private boolean s;
    private boolean m;
    private boolean l;
    private boolean xl;

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public boolean isXs() {
        return xs;
    }

    public void setXs(boolean xs) {
        this.xs = xs;
    }

    public boolean isS() {
        return s;
    }

    public void setS(boolean s) {
        this.s = s;
    }

    public boolean isM() {
        return m;
    }

    public void setM(boolean m) {
        this.m = m;
    }

    public boolean isL() {
        return l;
    }

    public void setL(boolean l) {
        this.l = l;
    }

    public boolean isXl() {
        return xl;
    }

    public void setXl(boolean xl) {
        this.xl = xl;
    }
    
}
