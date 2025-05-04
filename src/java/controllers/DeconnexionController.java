package controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DeconnexionController", urlPatterns = {"/DeconnexionController"})
public class DeconnexionController extends HttpServlet {

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

       HttpSession session = request.getSession(false);
        if (session != null) {
            // Supprimer les attributs de session
            session.removeAttribute("patient");
            session.removeAttribute("medecin");
            
            // Invalider la session
            session.invalidate();
        }
        
        // Ajouter un message de déconnexion
        request.setAttribute("successMessage", "Vous avez été déconnecté avec succès.");
        
        // Rediriger vers la page d'accueil
        RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp"); 
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
       return "Deconnexion Controller";
   }
}
