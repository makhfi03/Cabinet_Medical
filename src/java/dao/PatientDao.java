package dao;

import entities.Patient;
import entities.Consultation;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Query;
import util.HibernateUtil;

public class PatientDao extends AbstractDao<Patient> {
    
    public PatientDao() {
        super(Patient.class);
    }
    
    public Patient findPatientByEmail(String email) {
        Session session = null;
        Transaction tx = null;
        Patient patient = null;
        
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            
            patient = (Patient) session
                    .getNamedQuery("Patient.findByEmail")
                    .setParameter("email", email)
                    .uniqueResult();
            
            tx.commit();

            // Ajouter un log pour déboguer
            System.out.println("Patient trouvé pour l'email " + email + ": " + (patient != null ? patient.getNom() : "Aucun"));
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        
        return patient;
    }
    
    public List<Consultation> findConsultationsByPatient(int patientId) {
        Session session = null;
        Transaction tx = null;
        List<Consultation> consultations = null;
        
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            
            consultations = session
                    .getNamedQuery("Consultation.findByPatient")
                    .setParameter("patientId", patientId)
                    .list();
            
            tx.commit();

            // Ajouter un log pour déboguer
            System.out.println("Consultations trouvées pour le patient " + patientId + ": " + (consultations != null ? consultations.size() : 0));
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        
        return consultations;
    }
}
