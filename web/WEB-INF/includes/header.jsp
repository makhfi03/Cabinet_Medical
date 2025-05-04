<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Cabinet Médical</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <!-- Page specific CSS if needed -->
    <% if (request.getParameter("specificCss") != null) { %>
        <link href="${pageContext.request.contextPath}/css/<%= request.getParameter("specificCss") %>" rel="stylesheet">
    <% } %>
</head>
<body>
    <div class="main-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h3><i class="bi bi-hospital"></i> Cabinet Médical</h3>
            </div>
            
            <ul class="sidebar-menu">
                <% 
                    String currentPage = request.getParameter("currentPage");
                    boolean isMedecin = session.getAttribute("medecin") != null;
                    boolean isPatient = session.getAttribute("patient") != null;
                    boolean isLoggedIn = isMedecin || isPatient;
                    boolean readOnlyMode = request.getAttribute("readOnlyMode") != null && (Boolean)request.getAttribute("readOnlyMode");
                %>
                
                <% if (isMedecin) { %>
                    <li class="<%= "dashboard".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=dashboard">
                            <i class="bi bi-speedometer2"></i> Tableau de bord
                        </a>
                    </li>
                    <li class="<%= "patients".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=patients">
                            <i class="bi bi-people-fill"></i> Gestion des Patients
                        </a>
                    </li>
                    <li class="<%= "consultations".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=consultations">
                            <i class="bi bi-clipboard2-pulse"></i> Consultations
                        </a>
                    </li>
                    <li class="<%= "statistiques".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=statistiques">
                            <i class="bi bi-bar-chart-fill"></i> Statistiques
                        </a>
                    </li>
                <% } else if (isPatient) { %>
                    <li class="<%= "profil".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=profil">
                            <i class="bi bi-person-circle"></i> Mon Profil
                        </a>
                    </li>
                    <li class="<%= "consultations".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=consultations">
                            <i class="bi bi-clipboard2-pulse"></i> Mes Consultations
                        </a>
                    </li>
                <% } else { %>
                    <li class="<%= "welcome".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/welcome.jsp">
                            <i class="bi bi-house-door"></i> Accueil
                        </a>
                    </li>
                <% } %>
                
                <% if (isLoggedIn) { %>
                    <li>
                        <a href="${pageContext.request.contextPath}/DeconnexionController">
                            <i class="bi bi-box-arrow-right"></i> Déconnexion
                        </a>
                    </li>
                <% } else { %>
                    <li class="<%= "login".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=login">
                            <i class="bi bi-box-arrow-in-right"></i> Connexion
                        </a>
                    </li>
                    <li class="<%= "inscription".equals(currentPage) ? "active" : "" %>">
                        <a href="${pageContext.request.contextPath}/RouteController?page=inscription">
                            <i class="bi bi-person-plus"></i> Inscription
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
        
        <!-- Contenu principal -->
        <div class="content">
            <div class="main-header">
                <h1>${param.pageTitle}</h1>
                <div>
                    <% if (isMedecin) { %>
                        <span class="badge bg-primary">Médecin</span>
                    <% } else if (isPatient) { %>
                        <span class="badge bg-success">Patient</span>
                    <% } else { %>
                        <span class="badge bg-info">Mode Visiteur</span>
                    <% } %>
                </div>
            </div>
            
            <!-- Bannière mode lecture seule -->
            <% 
               String currentPageParam = request.getParameter("currentPage");
               boolean isAuthPage = "login".equals(currentPageParam) || "inscription".equals(currentPageParam);
               if (request.getAttribute("readOnlyMode") != null && (Boolean)request.getAttribute("readOnlyMode") && !isAuthPage) { 
            %>
                <div class="read-only-banner">
                    <div>
                        <i class="bi bi-eye"></i> Vous êtes en mode lecture seule. Certaines fonctionnalités sont limitées.
                    </div>
                    <a href="${pageContext.request.contextPath}/RouteController?page=login" class="btn">Se connecter</a>
                </div>
            <% } %>
            
            <!-- Affichage des messages d'erreur et de succès -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill"></i> <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("info") != null) { %>
                <div class="alert alert-info">
                    <i class="bi bi-info-circle-fill"></i> <%= request.getAttribute("info") %>
                </div>
            <% } %>
            
            <div class="container-fluid">
