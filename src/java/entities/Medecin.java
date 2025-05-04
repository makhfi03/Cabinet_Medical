package entities;

import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "medecins")
@NamedQueries({
    @NamedQuery(
        name = "Medecin.findByEmail",
        query = "SELECT m FROM Medecin m WHERE m.email = :email"
    )
})
public class Medecin extends User {
    
    @Column(name = "specialite")
    private String specialite;
    
    @OneToMany(mappedBy = "medecin")
    private List<Consultation> consultations;
    
    // Constructeurs
    public Medecin() {
        super();
    }
    
    public Medecin(String nom, String email, String motDePasse, String specialite) {
        super(nom, email, motDePasse);
        this.specialite = specialite;
    }
    
    // Getters et Setters
    public String getSpecialite() {
        return specialite;
    }
    
    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }
    
    public List<Consultation> getConsultations() {
        return consultations;
    }
    
    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
