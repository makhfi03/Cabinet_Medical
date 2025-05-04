package entities;

import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "patients")
@NamedQueries({
    @NamedQuery(
        name = "Patient.findByEmail",
        query = "SELECT p FROM Patient p WHERE p.email = :email"
    )
})
public class Patient extends User {
    
    @Column(name = "age")
    private Integer age;
    
    @Column(name = "sexe")
    private String sexe;
    
    @OneToMany(mappedBy = "patient")
    private List<Consultation> consultations;
    
    // Constructeurs
    public Patient() {
        super();
    }
    
    public Patient(String nom, String email, String motDePasse, Integer age, String sexe) {
        super(nom, email, motDePasse);
        this.age = age;
        this.sexe = sexe;
    }
    
    // Getters et Setters
    public Integer getAge() {
        return age;
    }
    
    public void setAge(Integer age) {
        this.age = age;
    }
    
    public String getSexe() {
        return sexe;
    }
    
    public void setSexe(String sexe) {
        this.sexe = sexe;
    }
    
    public List<Consultation> getConsultations() {
        return consultations;
    }
    
    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
