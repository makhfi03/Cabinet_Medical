package controllers;

import entities.Medecin;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.MedecinService;

@WebServlet(name = "MedecinController", urlPatterns = {"/MedecinController"})
public class MedecinController extends HttpServlet {

   private MedecinService ms;

   @Override
   public void init() throws ServletException {
       super.init();
       ms = new MedecinService();
   }

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       
       String op = request.getParameter("op");
       if (op == null) {
           String id = request.getParameter("id");
           String nom = request.getParameter("nom");
           String email = request.getParameter("email");
           String password = request.getParameter("password");
           String specialite = request.getParameter("specialite");
           
           if (id == null || id.isEmpty()) {
               Medecin m = new Medecin(nom, email, password, specialite);
               ms.create(m);
           } else {
               Medecin m = new Medecin(nom, email, password, specialite);
               m.setId(Integer.parseInt(id));
               ms.update(m);
           }
           RequestDispatcher dispatcher = request.getRequestDispatcher("/medecins/page.jsp"); 
           dispatcher.forward(request, response); 
       } else if (op.equals("delete")) {
           int id = Integer.parseInt(request.getParameter("id"));
           ms.delete(ms.findById(id));
           RequestDispatcher dispatcher = request.getRequestDispatcher("/medecins/page.jsp"); 
           dispatcher.forward(request, response); 
       } else if (op.equals("update")) {
           Medecin m = ms.findById(Integer.parseInt(request.getParameter("id")));
           request.setAttribute("medecin", m); 
           RequestDispatcher dispatcher = request.getRequestDispatcher("/medecins/page.jsp"); 
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
       return "Medecin Controller";
   }
}
