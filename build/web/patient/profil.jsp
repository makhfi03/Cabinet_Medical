<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Patient"%>
<%@page import="entities.Consultation"%>
<%@page import="java.util.List"%>
<%@page import="services.ConsultationService"%>
<%@page import="java.text.SimpleDateFormat"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Profil Patient" />
    <jsp:param name="currentPage" value="profil" />
    <jsp:param name="pageTitle" value="Mon Profil" />
</jsp:include>

<%
    Patient patient = (Patient) session.getAttribute("patient");
    boolean isConnected = (patient != null);
    
    // Si l'utilisateur est connecté, récupérer ses consultations
    List<Consultation> consultations = null;
    if (isConnected) {
        ConsultationService cs = new ConsultationService();
        consultations = cs.findConsultationsByPatient(patient.getId());
    }
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>

<div class="row">
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h3><i class="bi bi-person-circle"></i> Informations personnelles</h3>
            </div>
            <div class="card-body">
                <% if (isConnected) { %>
                    <div class="text-center mb-4">
                        <div style="width: 100px; height: 100px; background-color: #e74c3c; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; font-size: 40px;">
                            <%= patient.getNom().substring(0, 1).toUpperCase() %>
                        </div>
                        <h4 class="mt-3"><%= patient.getNom() %></h4>
                    </div>
                    
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-envelope"></i> Email</span>
                            <span><%= patient.getEmail() %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-calendar"></i> Âge</span>
                            <span><%= patient.getAge() %> ans</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-gender-ambiguous"></i> Sexe</span>
                            <span><%= "M".equals(patient.getSexe()) ? "Masculin" : "Féminin" %></span>
                        </li>
                    </ul>
                    
                    <div class="mt-4">
                        <a href="#" class="btn btn-primary w-100">
                            <i class="bi bi-pencil-square"></i> Modifier mon profil
                        </a>
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle-fill"></i> Connectez-vous pour voir votre profil.
                    </div>
                    <a href="${pageContext.request.contextPath}/RouteController?page=login" class="btn btn-primary w-100">
                        <i class="bi bi-box-arrow-in-right"></i> Se connecter
                    </a>
                <% } %>
            </div>
        </div>
    </div>
    
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h3><i class="bi bi-clipboard2-pulse"></i> Mes consultations</h3>
            </div>
            <div class="card-body">
                <% if (isConnected) { %>
                    <% if (consultations != null && !consultations.isEmpty()) { %>
                        <div class="table-container">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Médecin</th>
                                        <th>Diagnostic</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Consultation c : consultations) { %>
                                        <tr>
                                            <td><%= sdf.format(c.getDate()) %></td>
                                            <td>Dr. <%= c.getMedecin().getNom() %></td>
                                            <td><%= c.getDiagnostic() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle-fill"></i> Vous n'avez pas encore de consultations enregistrées.
                        </div>
                    <% } %>
                    
                    <div class="mt-4">
                        <a href="#" class="btn btn-primary">
                            <i class="bi bi-calendar-plus"></i> Prendre rendez-vous
                        </a>
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle-fill"></i> Connectez-vous pour voir vos consultations.
                    </div>
                <% } %>
            </div>
        </div>
        
        <div class="card mt-4">
            <div class="card-header">
                <h3><i class="bi bi-bell"></i> Rappels et notifications</h3>
            </div>
            <div class="card-body">
                <% if (isConnected) { %>
                    <div class="alert alert-warning">
                        <i class="bi bi-exclamation-triangle-fill"></i> Vous n'avez pas de rappels pour le moment.
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle-fill"></i> Connectez-vous pour voir vos rappels.
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
