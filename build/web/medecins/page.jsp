<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Medecin"%>
<%@page import="services.MedecinService"%>
<%@page import="java.util.List"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Gestion des Médecins" />
    <jsp:param name="currentPage" value="medecins" />
    <jsp:param name="pageTitle" value="Gestion des Médecins" />
</jsp:include>

<%
    MedecinService ms = new MedecinService();
    List<Medecin> medecins = ms.findAll();
    
    // Vérifier si un médecin est connecté
    boolean isMedecin = (session.getAttribute("medecin") != null);
    
    // Récupérer le médecin à modifier si disponible
    Medecin medecinToUpdate = (Medecin) request.getAttribute("medecin");
%>

<div class="row">
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h3><i class="bi bi-person-plus"></i> <%= medecinToUpdate != null ? "Modifier le médecin" : "Ajouter un médecin" %></h3>
            </div>
            <div class="card-body">
                <% if (!isMedecin) { %>
                    <div class="alert alert-warning">
                        <i class="bi bi-exclamation-triangle-fill"></i> Vous devez être connecté en tant que médecin pour ajouter ou modifier des médecins.
                    </div>
                <% } else { %>
                    <form action="${pageContext.request.contextPath}/MedecinController" method="post">
                        <% if (medecinToUpdate != null) { %>
                            <input type="hidden" name="id" value="<%= medecinToUpdate.getId() %>">
                        <% } %>
                        
                        <div class="form-group mb-3">
                            <label for="nom">Nom complet</label>
                            <input type="text" class="form-control" id="nom" name="nom" required
                                   value="<%= medecinToUpdate != null ? medecinToUpdate.getNom() : "" %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required
                                   value="<%= medecinToUpdate != null ? medecinToUpdate.getEmail() : "" %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="password">Mot de passe</label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   <%= medecinToUpdate != null ? "" : "required" %> 
                                   placeholder="<%= medecinToUpdate != null ? "Laisser vide pour conserver l'actuel" : "Mot de passe" %>">
                        </div>
                        
                        <div class="form-group mb-3">
                            <label for="specialite">Spécialité</label>
                            <input type="text" class="form-control" id="specialite" name="specialite" required
                                   value="<%= medecinToUpdate != null ? medecinToUpdate.getSpecialite() : "" %>">
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> <%= medecinToUpdate != null ? "Mettre à jour" : "Enregistrer" %>
                            </button>
                            
                            <% if (medecinToUpdate != null) { %>
                                <a href="${pageContext.request.contextPath}/RouteController?page=medecins" class="btn btn-secondary">
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
                <h3><i class="bi bi-people"></i> Liste des médecins</h3>
            </div>
            <div class="card-body">
                <% if (medecins != null && !medecins.isEmpty()) { %>
                    <div class="table-container">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nom</th>
                                    <th>Email</th>
                                    <th>Spécialité</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Medecin m : medecins) { %>
                                    <tr>
                                        <td><%= m.getId() %></td>
                                        <td>Dr. <%= m.getNom() %></td>
                                        <td><%= m.getEmail() %></td>
                                        <td><%= m.getSpecialite() %></td>
                                        <td>
                                            <% if (isMedecin) { %>
                                                <a href="${pageContext.request.contextPath}/MedecinController?op=update&id=<%= m.getId() %>" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/MedecinController?op=delete&id=<%= m.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce médecin?')">
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
                        <i class="bi bi-info-circle-fill"></i> Aucun médecin enregistré pour le moment.
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
