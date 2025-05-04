package services;

import dao.MedecinDao;
import entities.Medecin;
import entities.Consultation;
import java.util.List;

public class MedecinService implements IService<Medecin> {
    
    private final MedecinDao dao;
    
    public MedecinService() {
        this.dao = new MedecinDao();
    }
    
    @Override
    public boolean create(Medecin o) {
        return dao.create(o);
    }
    
    @Override
    public boolean delete(Medecin o) {
        return dao.delete(o);
    }
    
    @Override
    public boolean update(Medecin o) {
        return dao.update(o);
    }
    
    @Override
    public List<Medecin> findAll() {
        return dao.findAll();
    }
    
    @Override
    public Medecin findById(int id) {
        return dao.findById(id);
    }
    
    public Medecin findMedecinByEmail(String email) {
        return dao.findMedecinByEmail(email);
    }
    
    public List<Consultation> findConsultationsByMedecin(int medecinId) {
        return dao.findConsultationsByMedecin(medecinId);
    }
}
