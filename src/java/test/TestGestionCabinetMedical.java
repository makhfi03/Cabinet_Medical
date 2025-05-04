package test;

import dao.PatientDao;
import dao.MedecinDao;
import dao.ConsultationDao;
import entities.Patient;
import entities.Medecin;
import entities.Consultation;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class TestGestionCabinetMedical {

    public static void main(String[] args) throws ParseException {
        
        // Initialisation des DAOs
        PatientDao patientDao = new PatientDao();
        MedecinDao medecinDao = new MedecinDao();
        ConsultationDao consultationDao = new ConsultationDao();

        // 1. Création de patients avec différentes caractéristiques
        Patient patient1 = new Patient("BENALI Karim", "karim@email.com", "pass123", 35, "M");
        Patient patient2 = new Patient("ALAOUI Fatima", "fatima@email.com", "pass456", 28, "F");
        Patient patient3 = new Patient("TAZI Ahmed", "ahmed@email.com", "pass789", 45, "M");
        
        patientDao.create(patient1);
        patientDao.create(patient2);
        patientDao.create(patient3);
        
        System.out.println("\n[SUCCESS] Patients créés:");
        System.out.println("- " + patient1.getNom() + " (Âge: " + patient1.getAge() + ", Sexe: " + patient1.getSexe() + ")");
        System.out.println("- " + patient2.getNom() + " (Âge: " + patient2.getAge() + ", Sexe: " + patient2.getSexe() + ")");
        System.out.println("- " + patient3.getNom() + " (Âge: " + patient3.getAge() + ", Sexe: " + patient3.getSexe() + ")");

        // 2. Création de médecins avec différentes spécialités
        Medecin medecin1 = new Medecin("Dr. RAMI Samira", "samira@hopital.ma", "med123", "Cardiologie");
        Medecin medecin2 = new Medecin("Dr. OUAZZANI Hassan", "hassan@hopital.ma", "med456", "Pédiatrie");
        
        medecinDao.create(medecin1);
        medecinDao.create(medecin2);
        
        System.out.println("\n[SUCCESS] Médecins créés:");
        System.out.println("- " + medecin1.getNom() + " (Spécialité: " + medecin1.getSpecialite() + ")");
        System.out.println("- " + medecin2.getNom() + " (Spécialité: " + medecin2.getSpecialite() + ")");

        // 3. Enregistrement des consultations avec différentes dates
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date dateRecente = sdf.parse("15/04/2024");
        Date dateAncienne = sdf.parse("10/01/2024");
        
        Consultation consultation1 = new Consultation("Hypertension artérielle. Prescription de bêta-bloquants.", dateRecente, patient1, medecin1);
        Consultation consultation2 = new Consultation("Rhume saisonnier. Repos et antihistaminiques recommandés.", dateAncienne, patient2, medecin2);
        Consultation consultation3 = new Consultation("Douleurs lombaires chroniques. Orientation vers un kinésithérapeute.", dateRecente, patient3, medecin1);
        
        consultationDao.create(consultation1);
        consultationDao.create(consultation2);
        consultationDao.create(consultation3);
        
        System.out.println("\n[SUCCESS] Consultations enregistrées:");
        System.out.println("- Consultation de " + patient1.getNom() + " avec " + medecin1.getNom() + " le " + sdf.format(consultation1.getDate()));
        System.out.println("- Consultation de " + patient2.getNom() + " avec " + medecin2.getNom() + " le " + sdf.format(consultation2.getDate()));
        System.out.println("- Consultation de " + patient3.getNom() + " avec " + medecin1.getNom() + " le " + sdf.format(consultation3.getDate()));

        // 4. Test des méthodes spécifiques
        System.out.println("\n=== TESTS DES MÉTHODES SPÉCIFIQUES ===");
        
        // a) Test findConsultationsByPatient
        System.out.println("\nTest findConsultationsByPatient (pour " + patient1.getNom() + "):");
        List<Consultation> consultationsPatient1 = consultationDao.findConsultationsByPatient(patient1.getId());
        if(consultationsPatient1.isEmpty()) {
            System.out.println("Aucune consultation trouvée pour ce patient");
        } else {
            consultationsPatient1.forEach(c -> 
                System.out.println("- Date: " + sdf.format(c.getDate()) + ", Médecin: " + c.getMedecin().getNom() + ", Diagnostic: " + c.getDiagnostic())
            );
        }
        
        // b) Test findConsultationsByMedecin
        System.out.println("\nTest findConsultationsByMedecin (pour " + medecin1.getNom() + "):");
        List<Consultation> consultationsMedecin1 = consultationDao.findConsultationsByMedecin(medecin1.getId());
        if(consultationsMedecin1.isEmpty()) {
            System.out.println("Aucune consultation trouvée pour ce médecin");
        } else {
            consultationsMedecin1.forEach(c -> 
                System.out.println("- Date: " + sdf.format(c.getDate()) + ", Patient: " + c.getPatient().getNom() + ", Diagnostic: " + c.getDiagnostic())
            );
        }
        
        // c) Test findConsultationsByDate
        System.out.println("\nTest findConsultationsByDate (pour le " + sdf.format(dateRecente) + "):");
        List<Consultation> consultationsDate = consultationDao.findConsultationsByDate(dateRecente);
        if(consultationsDate.isEmpty()) {
            System.out.println("Aucune consultation trouvée à cette date");
        } else {
            consultationsDate.forEach(c -> 
                System.out.println("- Patient: " + c.getPatient().getNom() + ", Médecin: " + c.getMedecin().getNom() + ", Diagnostic: " + c.getDiagnostic())
            );
        }
        
        // d) Test countConsultationsByMedecin (statistiques)
        System.out.println("\nTest countConsultationsByMedecin (statistiques):");
        List<Object[]> statsMedecins = consultationDao.countConsultationsByMedecin();
        if(statsMedecins.isEmpty()) {
            System.out.println("Aucune statistique disponible");
        } else {
            statsMedecins.forEach(stat -> 
                System.out.println("- Médecin: " + stat[0] + ", Nombre de consultations: " + stat[1])
            );
        }
        
        // e) Test countConsultationsByMonth (statistiques par mois)
        System.out.println("\nTest countConsultationsByMonth (statistiques par mois):");
        List<Object[]> statsMois = consultationDao.countConsultationsByMonth();
        if(statsMois.isEmpty()) {
            System.out.println("Aucune statistique mensuelle disponible");
        } else {
            String[] mois = {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};
            statsMois.forEach(stat -> {
                int moisIndex = ((Number) stat[0]).intValue() - 1;
                System.out.println("- Mois: " + mois[moisIndex] + ", Nombre de consultations: " + stat[1]);
            });
        }
        
        // f) Test findPatientByEmail
        System.out.println("\nTest findPatientByEmail (pour " + patient2.getEmail() + "):");
        Patient patientTrouve = patientDao.findPatientByEmail(patient2.getEmail());
        if(patientTrouve == null) {
            System.out.println("Aucun patient trouvé avec cet email");
        } else {
            System.out.println("- Patient trouvé: " + patientTrouve.getNom() + " (Âge: " + patientTrouve.getAge() + ", Sexe: " + patientTrouve.getSexe() + ")");
        }
        
        System.out.println("\n[SUCCESS] Tous les tests ont été exécutés avec succès!");
    }
}
