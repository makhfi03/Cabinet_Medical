package controllers;

import entities.Consultation;
import entities.Patient;
import entities.Medecin;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.ConsultationService;
import services.PatientService;
import services.MedecinService;

@WebServlet(name = "ConsultationController", urlPatterns = {"/ConsultationController"})
public class ConsultationController extends HttpServlet {

   private ConsultationService cs;
   private PatientService ps;
   private MedecinService ms;

   @Override
   public void init() throws ServletException {
       super.init();
       cs = new ConsultationService();
       ps = new PatientService();
       ms = new MedecinService();
   }

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       
       String op = request.getParameter("op");
       if (op == null) {
           try {
               String dateStr = request.getParameter("dateConsultation");
               if (dateStr == null || dateStr.trim().isEmpty()) {
                   throw new ServletException("La date de consultation est requise");
               }
               
               SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               Date dateConsultation = sdf.parse(dateStr);
               String diagnostic = request.getParameter("diagnostic");
               if (diagnostic == null || diagnostic.trim().isEmpty()) {
                   throw new ServletException("Le diagnostic est requis");
               }
               
               String patientIdStr = request.getParameter("patientId");
               String medecinIdStr = request.getParameter("medecinId");
               if (patientIdStr == null || medecinIdStr == null) {
                   throw new ServletException("Le patient et le médecin sont requis");
               }
               
               int patientId = Integer.parseInt(patientIdStr);
               int medecinId = Integer.parseInt(medecinIdStr);
               
               Patient patient = ps.findById(patientId);
               if (patient == null) {
                   throw new ServletException("Patient non trouvé");
               }
               
               Medecin medecin = ms.findById(medecinId);
               if (medecin == null) {
                   throw new ServletException("Médecin non trouvé");
               }
               
               Consultation consultation = new Consultation(diagnostic, dateConsultation, patient, medecin);
               cs.create(consultation);
               
               RequestDispatcher dispatcher = request.getRequestDispatcher("/consultations/page.jsp"); 
               dispatcher.forward(request, response); 
           } catch (ParseException e) {
               throw new ServletException("Format de date invalide", e);
           } catch (NumberFormatException e) {
               throw new ServletException("Format d'ID invalide", e);
           }
       } else if (op.equals("delete")) {
           int id = Integer.parseInt(request.getParameter("id"));
           Consultation consultation = cs.findById(id);
           cs.delete(consultation);
           
           RequestDispatcher dispatcher = request.getRequestDispatcher("/consultations/page.jsp"); 
           dispatcher.forward(request, response); 
       } else if (op.equals("update")) {
           try {
               String idStr = request.getParameter("id");
               if (idStr == null || idStr.trim().isEmpty()) {
                   throw new ServletException("L'ID de la consultation est requis");
               }
               
               int id = Integer.parseInt(idStr);
               Consultation consultation = cs.findById(id);
               if (consultation == null) {
                   throw new ServletException("Consultation non trouvée");
               }
               
               String dateStr = request.getParameter("dateConsultation");
               if (dateStr == null || dateStr.trim().isEmpty()) {
                   throw new ServletException("La date de consultation est requise");
               }
               
               SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               Date dateConsultation = sdf.parse(dateStr);
               
               String diagnostic = request.getParameter("diagnostic");
               if (diagnostic == null || diagnostic.trim().isEmpty()) {
                   throw new ServletException("Le diagnostic est requis");
               }
               
               consultation.setDate(dateConsultation);
               consultation.setDiagnostic(diagnostic);
               
               cs.update(consultation);
               
               RequestDispatcher dispatcher = request.getRequestDispatcher("/consultations/page.jsp"); 
               dispatcher.forward(request, response); 
           } catch (ParseException e) {
               throw new ServletException("Format de date invalide", e);
           } catch (NumberFormatException e) {
               throw new ServletException("Format d'ID invalide", e);
           }
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
       return "Consultation Controller";
   }
}
