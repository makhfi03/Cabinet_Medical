package dao;

import entities.Medecin;
import entities.Consultation;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Query;
import util.HibernateUtil;

public class MedecinDao extends AbstractDao<Medecin> {
    
    public MedecinDao() {
        super(Medecin.class);
    }
    
    public Medecin findMedecinByEmail(String email) {
        Session session = null;
        Transaction tx = null;
        Medecin medecin = null;
        
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            
            medecin = (Medecin) session
                    .getNamedQuery("Medecin.findByEmail")
                    .setParameter("email", email)
                    .uniqueResult();
            
            tx.commit();

            // Ajouter un log pour déboguer
            System.out.println("Médecin trouvé pour l'email " + email + ": " + (medecin != null ? medecin.getNom() : "Aucun"));
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
        
        return medecin;
    }
    
    public List<Consultation> findConsultationsByMedecin(int medecinId) {
        Session session = null;
        Transaction tx = null;
        List<Consultation> consultations = null;
        
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            
            consultations = session
                    .getNamedQuery("Consultation.findByMedecin")
                    .setParameter("medecinId", medecinId)
                    .list();
            
            tx.commit();

            // Ajouter un log pour déboguer
            System.out.println("Consultations trouvées pour le médecin " + medecinId + ": " + (consultations != null ? consultations.size() : 0));
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
