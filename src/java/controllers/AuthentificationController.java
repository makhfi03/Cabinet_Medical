package controllers;

import entities.Patient;
import entities.Medecin;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.PatientService;
import services.MedecinService;
import services.UserService;

@WebServlet(name = "AuthentificationController", urlPatterns = {"/AuthentificationController"})
public class AuthentificationController extends HttpServlet {

    private UserService us;
    private PatientService ps;
    private MedecinService ms;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
        ps = new PatientService();
        ms = new MedecinService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Si une session existe déjà, on la invalide
        if (session != null) {
            session.invalidate();
        }
        
        session = request.getSession(true);
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType"); // "patient" ou "medecin"

        // Validation des champs
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs");
            RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=login");
            dispatcher.forward(request, response);
            return;
        }

        if ("patient".equals(userType)) {
            Patient patient = ps.findPatientByEmail(email);
            if (patient != null) {
                if (patient.getMotDePasse().equals(password)) {
                    // Création d'une nouvelle session après authentification réussie
                    session.setAttribute("patient", patient);
                    session.setMaxInactiveInterval(30*60); // 30 minutes
                    
                    // Ajouter un message de succès
                    session.setAttribute("successMessage", "Connexion réussie! Bienvenue " + patient.getNom());
                    
                    RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=profil"); 
                    dispatcher.forward(request, response); 
                    return;
                } else {
                    request.setAttribute("error", "Mot de passe incorrect"); 
                    request.setAttribute("email", email); // Conserver l'email pour éviter de le retaper
                    RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=login"); 
                    dispatcher.forward(request, response); 
                    return;
                }
            }
        } else if ("medecin".equals(userType)) {
            Medecin medecin = ms.findMedecinByEmail(email);
            if (medecin != null) {
                if (medecin.getMotDePasse().equals(password)) {
                    // Création d'une nouvelle session après authentification réussie
                    session.invalidate();
                    session = request.getSession(true);
                    session.setAttribute("medecin", medecin);
                    session.setMaxInactiveInterval(30*60); // 30 minutes
                    
                    // Ajouter un message de succès
                    session.setAttribute("successMessage", "Connexion réussie! Bienvenue Dr. " + medecin.getNom());
                    
                    RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=dashboard"); 
                    dispatcher.forward(request, response); 
                    return;
                } else {
                    request.setAttribute("error", "Mot de passe incorrect"); 
                    request.setAttribute("email", email); // Conserver l'email pour éviter de le retaper
                    RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=login"); 
                    dispatcher.forward(request, response); 
                    return;
                }
            }
        }

        request.setAttribute("error", "Email introuvable ou type d'utilisateur incorrect"); 
        RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=login"); 
        dispatcher.forward(request, response); 
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Authentification Controller";
    }
}
