package entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "consultations")
@NamedQueries({
    @NamedQuery(
        name = "Consultation.countByMedecin",
        query = "SELECT m.nom AS medecinName, COUNT(c) AS consultationCount " +
                "FROM Consultation c JOIN c.medecin m " +
                "GROUP BY m.nom " +
                "ORDER BY consultationCount DESC"
    ),
    @NamedQuery(
        name = "Consultation.countByMonth",
        query = "SELECT EXTRACT(MONTH FROM c.date) AS month, COUNT(c) AS consultationCount " +
                "FROM Consultation c " +
                "WHERE c.medecin IS NOT NULL " +
                "GROUP BY EXTRACT(MONTH FROM c.date) " +
                "ORDER BY month"
    ),
    @NamedQuery(
        name = "Consultation.countByPatient",
        query = "SELECT p.nom AS patientName, COUNT(c) AS consultationCount " +
                "FROM Consultation c JOIN c.patient p " +
                "GROUP BY p.nom " +
                "ORDER BY consultationCount DESC"
    ),
    @NamedQuery(
        name = "Consultation.findByPatient",
        query = "SELECT c FROM Consultation c WHERE c.patient.id = :patientId"
    ),
    @NamedQuery(
        name = "Consultation.findByMedecin",
        query = "SELECT c FROM Consultation c WHERE c.medecin.id = :medecinId"
    ),
    @NamedQuery(
        name = "Consultation.findByDate",
        query = "SELECT c FROM Consultation c WHERE c.date = :date"
    )
})
public class Consultation {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_consultation")
    private Integer id;
    
    @Column(name = "diagnostic")
    private String diagnostic;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "date_consultation")
    private Date date;
    
    @ManyToOne
    @JoinColumn(name = "id_patient")
    private Patient patient;
    
    @ManyToOne
    @JoinColumn(name = "id_medecin")
    private Medecin medecin;
    
    // Constructeurs
    public Consultation() {
    }
    
    public Consultation(String diagnostic, Date date, Patient patient, Medecin medecin) {
        this.diagnostic = diagnostic;
        this.date = date;
        this.patient = patient;
        this.medecin = medecin;
    }
    
    // Getters et Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getDiagnostic() {
        return diagnostic;
    }
    
    public void setDiagnostic(String diagnostic) {
        this.diagnostic = diagnostic;
    }
    
    public Date getDate() {
        return date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    public Patient getPatient() {
        return patient;
    }
    
    public void setPatient(Patient patient) {
        this.patient = patient;
    }
    
    public Medecin getMedecin() {
        return medecin;
    }
    
    public void setMedecin(Medecin medecin) {
        this.medecin = medecin;
    }
}
