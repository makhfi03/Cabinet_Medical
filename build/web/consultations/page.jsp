<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Consultation"%>
<%@page import="entities.Patient"%>
<%@page import="entities.Medecin"%>
<%@page import="services.ConsultationService"%>
<%@page import="services.PatientService"%>
<%@page import="services.MedecinService"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Gestion des Consultations" />
    <jsp:param name="currentPage" value="consultations" />
    <jsp:param name="pageTitle" value="Gestion des Consultations" />
</jsp:include>

<%
    ConsultationService cs = new ConsultationService();
    PatientService ps = new PatientService();
    MedecinService ms = new MedecinService();
    
    List<Consultation> consultations = cs.findAll();
    List<Patient> patients = ps.findAll();
    List<Medecin> medecins = ms.findAll();
    
    // Vérifier si un médecin est connecté
    boolean isMedecin = (session.getAttribute("medecin") != null);
    
    // Récupérer la consultation à modifier si disponible
    Consultation consultationToUpdate = (Consultation) request.getAttribute("consultation");
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
%>

<div class="row">
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h3><i class="bi bi-clipboard-plus"></i> <%= consultationToUpdate != null ? "Modifier la consultation" : "Nouvelle consultation" %></h3>
            </div>
            <div class="card-body">
                <% if (!isMedecin) { %>
                    <div class="alert alert-warning">
                        <i class="bi bi-exclamation-triangle-fill"></i> Vous devez être connecté en tant que médecin pour ajouter ou modifier des consultations.
                    </div>
                <% } else { %>
                    <form action="${pageContext.request.contextPath}/ConsultationController" method="post">
                        <% if (consultationToUpdate != null) { %>
                            <input type="hidden" name="id" value="<%= consultationToUpdate.getId() %>">
                            <input type="hidden" name="op" value="update">
                        <% } %>
                        
                        <div class="form-group mb-3">
                            <label for="patientId">Patient</label>
                            <select class="form-control" id="patientId" name="patientId" required>
                                <option value="">Sélectionner un patient</option>
                                <% for (Patient p : patients) { %>
                                    <option value="<%= p.getId() %>" 
                                            <%= consultationToUpdate != null && consultationToUpdate.getPatient().getId().equals(p.getId()) ? "selected" : "" %>>
                                        <%= p.getNom() %> (<%= p.getEmail() %>)
                                    </option>
                                <% } %>
                            </select>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="medecinId">Médecin</label>
                            <select class="form-control" id="medecinId" name="medecinId" required>
                                <option value="">Sélectionner un médecin</option>
                                <% for (Medecin m : medecins) { %>
                                    <option value="<%= m.getId() %>"
                                            <%= consultationToUpdate != null && consultationToUpdate.getMedecin().getId().equals(m.getId()) ? "selected" : "" %>>
                                        Dr. <%= m.getNom() %> (<%= m.getSpecialite() %>)
                                    </option>
                                <% } %>
                            </select>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="dateConsultation">Date de consultation</label>
                            <input type="date" class="form-control" id="dateConsultation" name="dateConsultation" required
                                   value="<%= consultationToUpdate != null ? sdf.format(consultationToUpdate.getDate()) : today %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="diagnostic">Diagnostic</label>
                            <textarea class="form-control" id="diagnostic" name="diagnostic" rows="4" required><%= consultationToUpdate != null ? consultationToUpdate.getDiagnostic() : "" %></textarea>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> <%= consultationToUpdate != null ? "Mettre à jour" : "Enregistrer" %>
                            </button>
                            
                            <% if (consultationToUpdate != null) { %>
                                <a href="${pageContext.request.contextPath}/RouteController?page=consultations" class="btn btn-secondary">
                                    <i class="bi bi-x-circle"></i> Annuler
                                </a>
                            <% } %>
                        </div>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
    
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h3><i class="bi bi-clipboard-data"></i> Liste des consultations</h3>
            </div>
            <div class="card-body">
                <% if (consultations != null && !consultations.isEmpty()) { %>
                    <div class="table-container">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Date</th>
                                    <th>Patient</th>
                                    <th>Médecin</th>
                                    <th>Diagnostic</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Consultation c : consultations) { %>
                                    <tr>
                                        <td><%= c.getId() %></td>
                                        <td><%= sdf.format(c.getDate()) %></td>
                                        <td><%= c.getPatient().getNom() %></td>
                                        <td>Dr. <%= c.getMedecin().getNom() %></td>
                                        <td><%= c.getDiagnostic().length() > 30 ? c.getDiagnostic().substring(0, 30) + "..." : c.getDiagnostic() %></td>
                                        <td>
                                            <% if (isMedecin) { %>
                                                <a href="${pageContext.request.contextPath}/ConsultationController?op=update&id=<%= c.getId() %>" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/ConsultationController?op=delete&id=<%= c.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette consultation?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            <% } else { %>
                                                <span class="text-muted">Non disponible</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle-fill"></i> Aucune consultation enregistrée pour le moment.
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
