<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Inscription" />
    <jsp:param name="currentPage" value="inscription" />
    <jsp:param name="pageTitle" value="Inscription" />
    <jsp:param name="specificCss" value="auth.css" />
</jsp:include>

<div class="auth-container">
    <div class="auth-header">
        <h2>Créer un compte patient</h2>
    </div>
    <div class="auth-body">
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form class="auth-form" action="${pageContext.request.contextPath}/PatientController" method="post">
            <div class="form-group">
                <label for="nom">Nom complet</label>
                <div class="input-group">
                    <div class="input-group-text"><i class="bi bi-person"></i></div>
                    <input type="text" class="form-control" id="nom" name="nom" placeholder="Entrez votre nom complet" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <div class="input-group">
                    <div class="input-group-text"><i class="bi bi-envelope"></i></div>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Entrez votre email" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <div class="input-group">
                    <div class="input-group-text"><i class="bi bi-lock"></i></div>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Créez un mot de passe" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="age">Âge</label>
                <div class="input-group">
                    <div class="input-group-text"><i class="bi bi-calendar"></i></div>
                    <input type="number" class="form-control" id="age" name="age" placeholder="Votre âge" required min="1" max="120">
                </div>
            </div>
            
            <div class="form-group">
                <label>Sexe</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="sexe" id="sexeM" value="M" checked>
                        <label class="form-check-label" for="sexeM">Masculin</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="sexe" id="sexeF" value="F">
                        <label class="form-check-label" for="sexeF">Féminin</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn">S'inscrire</button>
            </div>
        </form>
        
        <div class="divider">ou</div>
        
        <div class="text-center mt-3">
            <p class="small-text">Vous avez déjà un compte?</p>
            <a href="${pageContext.request.contextPath}/RouteController?page=login" class="btn btn-outline-secondary">
                <i class="bi bi-box-arrow-in-right"></i> Se connecter
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
