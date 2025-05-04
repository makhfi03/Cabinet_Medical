package services;

import dao.PatientDao;
import entities.Patient;
import entities.Consultation;
import java.util.List;

public class PatientService implements IService<Patient> {
    
    private final PatientDao dao;
    
    public PatientService() {
        this.dao = new PatientDao();
    }
    
    @Override
    public boolean create(Patient o) {
        return dao.create(o);
    }
    
    @Override
    public boolean delete(Patient o) {
        return dao.delete(o);
    }
    
    @Override
    public boolean update(Patient o) {
        return dao.update(o);
    }
    
    @Override
    public List<Patient> findAll() {
        return dao.findAll();
    }
    
    @Override
    public Patient findById(int id) {
        return dao.findById(id);
    }
    
    public Patient findPatientByEmail(String email) {
        return dao.findPatientByEmail(email);
    }
    
    public List<Consultation> findConsultationsByPatient(int patientId) {
        return dao.findConsultationsByPatient(patientId);
    }
}
