package services;

import dao.ConsultationDao;
import entities.Consultation;
import entities.Patient;
import java.util.Date;
import java.util.List;

public class ConsultationService implements IService<Consultation> {
    
    private final ConsultationDao dao;
    
    public ConsultationService() {
        this.dao = new ConsultationDao();
    }
    
    @Override
    public boolean create(Consultation o) {
        return dao.create(o);
    }
    
    @Override
    public boolean delete(Consultation o) {
        return dao.delete(o);
    }
    
    @Override
    public boolean update(Consultation o) {
        return dao.update(o);
    }
    
    @Override
    public List<Consultation> findAll() {
        return dao.findAll();
    }
    
    @Override
    public Consultation findById(int id) {
        return dao.findById(id);
    }
    
    public List<Consultation> findConsultationsByPatient(int patientId) {
        return dao.findConsultationsByPatient(patientId);
    }
    
    public List<Consultation> findConsultationsByMedecin(int medecinId) {
        return dao.findConsultationsByMedecin(medecinId);
    }
    
    public List<Consultation> findConsultationsByDate(Date date) {
        return dao.findConsultationsByDate(date);
    }

    public List<Object[]> countConsultationsByMedecin() {
        return dao.countConsultationsByMedecin();
    }

    public List<Object[]> countConsultationsByMonth() {
        return dao.countConsultationsByMonth();
    }

    public List<Consultation> findByPatient(Patient patient) {
        return dao.findConsultationsByPatient(patient.getId());
    }
}
