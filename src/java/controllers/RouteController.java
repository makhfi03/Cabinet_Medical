package controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "RouteController", urlPatterns = {"/RouteController"})
public class RouteController extends HttpServlet {

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

       String page = request.getParameter("page");
       HttpSession session = request.getSession(false);
       
       // Si l'utilisateur essaie d'accéder à la page de login alors qu'il est déjà connecté
       if ("login".equals(page) && session != null && 
           (session.getAttribute("patient") != null || session.getAttribute("medecin") != null)) {
           
           // Déconnecter l'utilisateur
           session.invalidate();
           session = request.getSession(true);
           session.setAttribute("info", "Vous êtes déjà connecté");
           
           // Redirection vers la page appropriée selon le type d'utilisateur
           if (session.getAttribute("medecin") != null) {
               RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=dashboard");
               dispatcher.forward(request, response);
               return;
           } else {
               RequestDispatcher dispatcher = request.getRequestDispatcher("RouteController?page=profil");
               dispatcher.forward(request, response);
               return;
           }
       }        
       
       if (page == null) {
           // Redirection par défaut vers la page d'accueil
           RequestDispatcher dispatcher = request.getRequestDispatcher("/welcome.jsp"); 
           dispatcher.forward(request, response); 
           return;
       }
       
       // Transférer les messages d'erreur et de succès de la session vers les attributs de requête
       if (session != null) {
           if (session.getAttribute("successMessage") != null) {
               request.setAttribute("successMessage", session.getAttribute("successMessage"));
               session.removeAttribute("successMessage");
           }
           if (session.getAttribute("errorMessage") != null) {
               request.setAttribute("error", session.getAttribute("errorMessage"));
               session.removeAttribute("errorMessage");
           }
       }
       
       // Vérifier si l'utilisateur est connecté
       boolean isLoggedIn = (session != null && (session.getAttribute("patient") != null || session.getAttribute("medecin") != null));
       boolean isMedecin = (session != null && session.getAttribute("medecin") != null);
       boolean isPatient = (session != null && session.getAttribute("patient") != null);
       
       // Ajouter un attribut pour indiquer le mode lecture seule
       // Ne pas l'afficher sur les pages de connexion et d'inscription
       if (!isLoggedIn && !"login".equals(page) && !"inscription".equals(page)) {
           request.setAttribute("readOnlyMode", true);
       }
       
       switch (page) { 
           // Pages d'authentification
           case "login":
               RequestDispatcher loginDispatcher = request.getRequestDispatcher("/auth/authentification.jsp"); 
               loginDispatcher.forward(request, response); 
               break;
               
           case "inscription":
               RequestDispatcher inscriptionDispatcher = request.getRequestDispatcher("/auth/inscription.jsp"); 
               inscriptionDispatcher.forward(request, response); 
               break;
               
           // Pages principales
           case "dashboard":
               if (!isMedecin) {
                   request.setAttribute("error", "Accès réservé aux médecins");
                   RequestDispatcher errorDispatcher = request.getRequestDispatcher("/auth/authentification.jsp"); 
                   errorDispatcher.forward(request, response);
                   return;
               }
               RequestDispatcher dashboardDispatcher = request.getRequestDispatcher("/medecin/dashboard.jsp"); 
               dashboardDispatcher.forward(request, response); 
               break;
           
           case "profil":
               if (!isPatient) {
                   request.setAttribute("info", "Vous devez être connecté en tant que patient pour accéder à cette page");
               }
               RequestDispatcher profilDispatcher = request.getRequestDispatcher("/patient/profil.jsp"); 
               profilDispatcher.forward(request, response); 
               break;
               
           case "consultations":
               RequestDispatcher consultationsDispatcher = request.getRequestDispatcher("/consultations/page.jsp"); 
               consultationsDispatcher.forward(request, response); 
               break;
               
           case "patients":
               if (!isMedecin) {
                   request.setAttribute("error", "Accès réservé aux médecins");
                   RequestDispatcher errorDispatcher = request.getRequestDispatcher("/auth/authentification.jsp"); 
                   errorDispatcher.forward(request, response);
                   return;
               }
               RequestDispatcher patientsDispatcher = request.getRequestDispatcher("/patients/page.jsp"); 
               patientsDispatcher.forward(request, response); 
               break;
               
           case "medecins":
               RequestDispatcher medecinsDispatcher = request.getRequestDispatcher("/medecins/page.jsp"); 
               medecinsDispatcher.forward(request, response); 
               break;
               
           case "statistiques":
               if (!isMedecin) {
                   request.setAttribute("error", "Accès réservé aux médecins");
                   RequestDispatcher errorDispatcher = request.getRequestDispatcher("/auth/authentification.jsp"); 
                   errorDispatcher.forward(request, response);
                   return;
               }
               RequestDispatcher statsDispatcher = request.getRequestDispatcher("/statistiques.jsp"); 
               statsDispatcher.forward(request, response); 
               break;
               
           default:
               RequestDispatcher defaultDispatcher = request.getRequestDispatcher("/welcome.jsp"); 
               defaultDispatcher.forward(request, response); 
               break;
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
       return "Route Controller";
   }
}
