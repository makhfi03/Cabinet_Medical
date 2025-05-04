<%@page import="entities.Patient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Consultation"%>
<%@page import="entities.Medecin"%>
<%@page import="services.ConsultationService"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<style>
    .consultation-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        background-color: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .consultation-table th {
        background: linear-gradient(135deg, #40e0d0, #36c9b7); /* Turquoise clair à foncé */
        color: white;
        padding: 15px;
        text-align: left;
        font-weight: 500;
    }
    
    .consultation-table td {
        padding: 15px;
        border-bottom: 1px solid #e0e0e0;
        background-color: white;
    }
    
    .consultation-table tr:last-child td {
        border-bottom: none;
    }
    
    .consultation-table tr:hover {
        background-color: #f0f9f8; /* Très léger turquoise clair */
    }
    
    .status-badge {
        padding: 8px 12px;
        border-radius: 20px;
        font-weight: 500;
        text-transform: uppercase;
        font-size: 0.8em;
        color: white;
    }
    
    .status-coming {
        background: linear-gradient(135deg, #40e0d0, #36c9b7); /* Turquoise clair à foncé */
        box-shadow: 0 2px 5px rgba(64, 224, 208, 0.3);
    }
    
    .status-done {
        background: linear-gradient(135deg, #28a745, #218838); /* Vert conservé pour le contraste */
        box-shadow: 0 2px 5px rgba(40, 167, 69, 0.3);
    }

    .alert-info {
        background-color: #e0f7fa; /* Turquoise très clair */
        border-left: 4px solid #40e0d0;
        color: #006064; /* Texte foncé pour contraste */
        padding: 15px;
        border-radius: 8px;
    }
</style>

<%
    Patient patient = (Patient) session.getAttribute("patient");
    ConsultationService cs = new ConsultationService();
    List<Consultation> consultations = cs.findByPatient(patient);
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>

<% if (consultations.isEmpty()) { %>
    <div class="alert alert-info">
        <i class="bi bi-info-circle-fill"></i> Vous n'avez pas encore de rendez-vous.
    </div>
<% } else { %>
    <div class="table-responsive">
        <table class="consultation-table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Médecin</th>
                    <th>Spécialité</th>
                    <th>Motif</th>
                    <th>Statut</th>
                </tr>
            </thead>
            <tbody>
                <% for (Consultation c : consultations) { %>
                    <tr>
                        <td><%= sdf.format(c.getDateConsultation()) %></td>
                        <td>Dr. <%= c.getMedecin().getNom() %></td>
                        <td><%= c.getMedecin().getSpecialite() %></td>
                        <td><%= c.getDiagnostic() %></td>
                        <td>
                            <% if (c.getDateConsultation().after(new Date())) { %>
                                <span class="status-badge status-coming">À venir</span>
                            <% } else { %>
                                <span class="status-badge status-done">Terminé</span>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
<% } %> 