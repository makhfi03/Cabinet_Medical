package mapper;

public class ConsultationStats {
    private String name;
    private int consultationCount;

    public ConsultationStats(String name, int consultationCount) {
        this.name = name;
        this.consultationCount = consultationCount;
    }

    public String getName() {
        return name;
    }

    public int getConsultationCount() {
        return consultationCount;
    }
}