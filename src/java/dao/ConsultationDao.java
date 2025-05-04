package dao;

import entities.Consultation;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Query;
import util.HibernateUtil;

public class ConsultationDao extends AbstractDao<Consultation> {
    
    public ConsultationDao() {
        super(Consultation.class);
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
    
    public List<Consultation> findConsultationsByDate(Date date) {
        Session session = null;
        Transaction tx = null;
        List<Consultation> consultations = null;
        
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            
            consultations = session
                    .getNamedQuery("Consultation.findByDate")
                    .setParameter("date", date)
                    .list();
            
            tx.commit();

            // Ajouter un log pour déboguer
            System.out.println("Consultations trouvées pour la date " + date + ": " + (consultations != null ? consultations.size() : 0));
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
    
    public List<Object[]> countConsultationsByMedecin() {
        Session session = null;
        Transaction tx = null;
        List<Object[]> stats = null;
        
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            
            stats = session
                    .getNamedQuery("Consultation.countByMedecin")
                    .list();
            
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        
        return stats;
    }
    
    public List<Object[]> countConsultationsByMonth() {
        Session session = null;
        Transaction tx = null;
        List<Object[]> stats = null;
        
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            
            stats = session
                    .getNamedQuery("Consultation.countByMonth")
                    .list();
            
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        
        return stats;
    }
}
