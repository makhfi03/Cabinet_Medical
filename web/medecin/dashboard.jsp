<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@page import="entities.Medecin"%>
<%@page import="entities.Consultation"%>
<%@page import="services.ConsultationService"%>
<%@page import="services.PatientService"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Tableau de bord Médecin" />
    <jsp:param name="currentPage" value="dashboard" />
    <jsp:param name="pageTitle" value="Tableau de bord" />
</jsp:include>

<%
    Medecin medecin = (Medecin) session.getAttribute("medecin");
    boolean isConnected = (medecin != null);
    
    // Si le médecin est connecté, récupérer ses consultations
    List<Consultation> consultations = null;
    ConsultationService cs = new ConsultationService();
    PatientService ps = new PatientService();
    
    if (isConnected) {
        consultations = cs.findConsultationsByMedecin(medecin.getId());
    }
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    Date today = new Date();
%>

<% if (!isConnected) { %>
    <div class="alert alert-danger">
        <i class="bi bi-exclamation-triangle-fill"></i> Accès réservé aux médecins. Veuillez vous connecter.
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/RouteController?page=login" class="btn btn-primary">
            <i class="bi bi-box-arrow-in-right"></i> Se connecter
        </a>
    </div>
<% } else { %>
    <!-- Statistiques rapides -->
    <div class="row">
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Consultations totales</h3>
                <div class="number"><%= consultations != null ? consultations.size() : 0 %></div>
                <div class="description">Nombre total de consultations</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Consultations du jour</h3>
                <div class="number">
                    <%
                        int todayConsultations = 0;
                        if (consultations != null) {
                            for (Consultation c : consultations) {
                                if (sdf.format(c.getDate()).equals(sdf.format(today))) {
                                    todayConsultations++;
                                }
                            }
                        }
                    %>
                    <%= todayConsultations %>
                </div>
                <div class="description">Consultations aujourd'hui</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Patients suivis</h3>
                <div class="number">
                    <%
                        int uniquePatients = 0;
                        if (consultations != null) {
                            java.util.Set<Integer> patientIds = new java.util.HashSet<Integer>();
                            for (Consultation c : consultations) {
                                patientIds.add(c.getPatient().getId());
                            }
                            uniquePatients = patientIds.size();
                        }
                    %>
                    <%= uniquePatients %>
                </div>
                <div class="description">Patients uniques</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Spécialité</h3>
                <div class="number"><i class="bi bi-heart-pulse"></i></div>
                <div class="description"><%= medecin.getSpecialite() %></div>
            </div>
        </div>
    </div>

    <!-- Consultations récentes -->
    <div class="row mt-4">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3><i class="bi bi-clipboard2-pulse"></i> Consultations récentes</h3>
                    <a href="${pageContext.request.contextPath}/RouteController?page=consultations" class="btn btn-sm btn-primary">
                        <i class="bi bi-eye"></i> Voir tout
                    </a>
                </div>
                <div class="card-body">
                    <% if (consultations != null && !consultations.isEmpty()) { %>
                        <div class="table-container">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Patient</th>
                                        <th>Diagnostic</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        // Afficher les 5 dernières consultations
                                        int count = 0;
                                        for (int i = consultations.size() - 1; i >= 0 && count < 5; i--, count++) {
                                            Consultation c = consultations.get(i);
                                    %>
                                        <tr>
                                            <td><%= sdf.format(c.getDate()) %></td>
                                            <td><%= c.getPatient().getNom() %></td>
                                            <td><%= c.getDiagnostic() %></td>
                                            <td>
                                                <a href="#" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="#" class="btn btn-sm btn-outline-secondary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                            </td>
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
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-person-circle"></i> Mon profil</h3>
                </div>
                <div class="card-body">
                    <div class="text-center mb-4">
                        <div style="width: 100px; height: 100px; background-color: #0d6efd; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; font-size: 40px;">
                            <%= medecin.getNom().substring(0, 1).toUpperCase() %>
                        </div>
                        <h4 class="mt-3">Dr. <%= medecin.getNom() %></h4>
                        <p class="text-muted"><%= medecin.getSpecialite() %></p>
                    </div>
                    
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-envelope"></i> Email</span>
                            <span><%= medecin.getEmail() %></span>
                        </li>
                    </ul>
                    
                    <div class="mt-4">
                        <a href="#" class="btn btn-primary w-100">
                            <i class="bi bi-pencil-square"></i> Modifier mon profil
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="card mt-4">
                <div class="card-header">
                    <h3><i class="bi bi-calendar-check"></i> Actions rapides</h3>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/RouteController?page=consultations" class="btn btn-outline-primary">
                            <i class="bi bi-plus-circle"></i> Nouvelle consultation
                        </a>
                        <a href="${pageContext.request.contextPath}/RouteController?page=patients" class="btn btn-outline-primary">
                            <i class="bi bi-people"></i> Gérer les patients
                        </a>
                        <a href="${pageContext.request.contextPath}/RouteController?page=statistiques" class="btn btn-outline-primary">
                            <i class="bi bi-bar-chart"></i> Voir les statistiques
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
<% } %>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
