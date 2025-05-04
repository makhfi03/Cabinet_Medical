package controllers;

import entities.Patient;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.PatientService;
import util.Util;

@WebServlet(name = "PatientController", urlPatterns = {"/PatientController"})
public class PatientController extends HttpServlet {

   private PatientService ps;

   @Override
   public void init() throws ServletException {
       super.init();
       ps = new PatientService();
   }

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       
       String op = request.getParameter("op");
       if (op == null) {
           String id = request.getParameter("id");
           String nom = request.getParameter("nom");
           String email = request.getParameter("email");
           String password = request.getParameter("password");
           int age = Integer.parseInt(request.getParameter("age"));
           String sexe = request.getParameter("sexe");
           
           // Vérifier si l'email existe déjà
           Patient existingPatient = ps.findPatientByEmail(email);
           if (existingPatient != null && (id == null || !id.equals(existingPatient.getId().toString()))) {
               request.setAttribute("error", "Cet email est déjà utilisé par un autre patient");
               RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/inscription.jsp"); 
               dispatcher.forward(request, response);
               return;
           }
           
           if (id == null || id.isEmpty()) {
               // Hachage du mot de passe
               String hashedPassword = Util.md5(password);
               
               // Création d'un nouveau patient
               Patient p = new Patient(nom, email, hashedPassword, age, sexe);
               if (ps.create(p)) {
                   // Connexion automatique après inscription
                   HttpSession session = request.getSession();
                   session.setAttribute("patient", p);
                   session.setAttribute("successMessage", "Inscription réussie ! Bienvenue " + nom);
                   
                   RequestDispatcher dispatcher = request.getRequestDispatcher("/RouteController?page=profil"); 
                   dispatcher.forward(request, response);
               } else {
                   request.setAttribute("error", "Erreur lors de l'inscription");
                   RequestDispatcher dispatcher = request.getRequestDispatcher("/auth/inscription.jsp"); 
                   dispatcher.forward(request, response);
               }
           } else {
               // Mise à jour d'un patient existant
               Patient p = ps.findById(Integer.parseInt(id));
               if (p != null) {
                   p.setNom(nom);
                   p.setEmail(email);
                   
                   // Ne mettre à jour le mot de passe que s'il est fourni
                   if (password != null && !password.isEmpty()) {
                       p.setMotDePasse(Util.md5(password));
                   }
                   
                   p.setAge(age);
                   p.setSexe(sexe);
                   
                   if (ps.update(p)) {
                       request.setAttribute("successMessage", "Patient mis à jour avec succès");
                   } else {
                       request.setAttribute("error", "Erreur lors de la mise à jour du patient");
                   }
               }
               
               // Redirection selon le rôle de l'utilisateur
               HttpSession session = request.getSession(false);
               if (session != null && session.getAttribute("medecin") != null) {
                   RequestDispatcher dispatcher = request.getRequestDispatcher("/RouteController?page=patients"); 
                   dispatcher.forward(request, response);
               } else {
                   // Mettre à jour la session si c'est le patient lui-même qui se modifie
                   if (session != null && session.getAttribute("patient") != null) {
                       session.setAttribute("patient", p);
                   }
                   RequestDispatcher dispatcher = request.getRequestDispatcher("/RouteController?page=profil"); 
                   dispatcher.forward(request, response);
               }
           }
       } else if (op.equals("delete")) {
           int id = Integer.parseInt(request.getParameter("id"));
           Patient p = ps.findById(id);
           
           if (p != null && ps.delete(p)) {
               request.setAttribute("successMessage", "Patient supprimé avec succès");
           } else {
               request.setAttribute("error", "Erreur lors de la suppression du patient");
           }
           
           RequestDispatcher dispatcher = request.getRequestDispatcher("/RouteController?page=patients"); 
           dispatcher.forward(request, response);
       } else if (op.equals("update")) {
           Patient p = ps.findById(Integer.parseInt(request.getParameter("id")));
           request.setAttribute("patient", p); 
           RequestDispatcher dispatcher = request.getRequestDispatcher("/patients/page.jsp"); 
           dispatcher.forward(request, response); 
       }
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
       return "Patient Controller";
   }
}
