<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Patient"%>
<%@page import="services.PatientService"%>
<%@page import="java.util.List"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Gestion des Patients" />
    <jsp:param name="currentPage" value="patients" />
    <jsp:param name="pageTitle" value="Gestion des Patients" />
</jsp:include>

<%
    PatientService ps = new PatientService();
    List<Patient> patients = ps.findAll();
    
    // Vérifier si un médecin est connecté
    boolean isMedecin = (session.getAttribute("medecin") != null);
    
    // Récupérer le patient à modifier si disponible
    Patient patientToUpdate = (Patient) request.getAttribute("patient");
%>

<% if (!isMedecin) { %>
    <div class="alert alert-danger">
        <i class="bi bi-exclamation-triangle-fill"></i> Accès réservé aux médecins. Veuillez vous connecter.
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/RouteController?page=login" class="btn btn-primary">
            <i class="bi bi-box-arrow-in-right"></i> Se connecter
        </a>
    </div>
<% } else { %>
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-person-plus"></i> <%= patientToUpdate != null ? "Modifier le patient" : "Ajouter un patient" %></h3>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/PatientController" method="post">
                        <% if (patientToUpdate != null) { %>
                            <input type="hidden" name="id" value="<%= patientToUpdate.getId() %>">
                        <% } %>
                        
                        <div class="form-group mb-3">
                            <label for="nom">Nom complet</label>
                            <input type="text" class="form-control" id="nom" name="nom" required
                                   value="<%= patientToUpdate != null ? patientToUpdate.getNom() : "" %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required
                                   value="<%= patientToUpdate != null ? patientToUpdate.getEmail() : "" %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="password">Mot de passe</label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   <%= patientToUpdate != null ? "" : "required" %> 
                                   placeholder="<%= patientToUpdate != null ? "Laisser vide pour conserver l'actuel" : "Mot de passe" %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="age">Âge</label>
                            <input type="number" class="form-control" id="age" name="age" required min="1" max="120"
                                   value="<%= patientToUpdate != null ? patientToUpdate.getAge() : "" %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label>Sexe</label>
                            <div class="d-flex gap-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="sexe" id="sexeM" value="M"
                                           <%= patientToUpdate != null && "M".equals(patientToUpdate.getSexe()) ? "checked" : "" %>>
                                    <label class="form-check-label" for="sexeM">Masculin</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="sexe" id="sexeF" value="F"
                                           <%= patientToUpdate != null && "F".equals(patientToUpdate.getSexe()) ? "checked" : "" %>>
                                    <label class="form-check-label" for="sexeF">Féminin</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> <%= patientToUpdate != null ? "Mettre à jour" : "Enregistrer" %>
                            </button>
                            
                            <% if (patientToUpdate != null) { %>
                                <a href="${pageContext.request.contextPath}/RouteController?page=patients" class="btn btn-secondary">
                                    <i class="bi bi-x-circle"></i> Annuler
                                </a>
                            <% } %>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-people"></i> Liste des patients</h3>
                </div>
                <div class="card-body">
                    <% if (patients != null && !patients.isEmpty()) { %>
                        <div class="table-container">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom</th>
                                        <th>Email</th>
                                        <th>Âge</th>
                                        <th>Sexe</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Patient p : patients) { %>
                                        <tr>
                                            <td><%= p.getId() %></td>
                                            <td><%= p.getNom() %></td>
                                            <td><%= p.getEmail() %></td>
                                            <td><%= p.getAge() %></td>
                                            <td><%= "M".equals(p.getSexe()) ? "Masculin" : "Féminin" %></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/PatientController?op=update&id=<%= p.getId() %>" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/PatientController?op=delete&id=<%= p.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce patient?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle-fill"></i> Aucun patient enregistré pour le moment.
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
<% } %>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
