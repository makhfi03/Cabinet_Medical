<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Connexion" />
    <jsp:param name="currentPage" value="login" />
    <jsp:param name="pageTitle" value="Connexion" />
    <jsp:param name="specificCss" value="auth.css" />
</jsp:include>

<div class="auth-container">
    <div class="auth-header">
        <h2>Connexion au Cabinet Médical</h2>
    </div>
    <div class="auth-body">
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form class="auth-form" action="${pageContext.request.contextPath}/AuthentificationController" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <div class="input-group">
                    <div class="input-group-text"><i class="bi bi-envelope"></i></div>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Entrez votre email" required 
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                </div>
            </div>
            
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <div class="input-group">
                    <div class="input-group-text"><i class="bi bi-lock"></i></div>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Entrez votre mot de passe" required>
                </div>
            </div>
            
            <div class="form-group">
                <label>Type d'utilisateur</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="userType" id="patientType" value="patient" checked>
                        <label class="form-check-label" for="patientType">Patient</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="userType" id="medecinType" value="medecin">
                        <label class="form-check-label" for="medecinType">Médecin</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn">Se connecter</button>
            </div>
        </form>
        
        <div class="divider">ou</div>
        
        <div class="text-center mt-3">
            <p class="small-text">Vous n'avez pas de compte?</p>
            <a href="${pageContext.request.contextPath}/RouteController?page=inscription" class="btn btn-outline-secondary">
                <i class="bi bi-person-plus"></i> Créer un compte
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
