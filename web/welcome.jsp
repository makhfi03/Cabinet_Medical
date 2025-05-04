<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bienvenue - Gestion de Cabinet Médical</title>
        
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        
        <style>
    .hero-section {
        background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://images.pexels.com/photos/3985178/pexels-photo-3985178.jpeg');
        background-size: cover;
        background-position: center;
        color: white;
        padding: 100px 0;
        text-align: center;
    }
    
    .feature-card {
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 30px;
        margin-bottom: 30px;
        transition: transform 0.3s;
        height: 100%;
        background-color: white;
        border-top: 4px solid #40e0d0;
    }
    
    .feature-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 8px 16px rgba(64, 224, 208, 0.2);
    }
    
    .feature-icon {
        font-size: 3rem;
        margin-bottom: 20px;
        color: #40e0d0; /* Turquoise clair */
    }
    
    .cta-section {
        background: linear-gradient(135deg, #40e0d0, #36c9b7); /* Turquoise clair à foncé */
        color: white;
        padding: 60px 0;
        text-align: center;
    }
    
    .footer {
        background-color: #343a40;
        color: white;
        padding: 40px 0;
    }
    
    .footer a {
        color: white;
        text-decoration: none;
    }
    
    .footer a:hover {
        color: #40e0d0; /* Turquoise clair */
        text-decoration: none;
    }
    
    /* Navbar */
    .navbar {
        background-color: #40e0d0 !important; /* Turquoise clair */
        box-shadow: 0 2px 10px rgba(64, 224, 208, 0.3);
    }
    
    .navbar-brand {
        font-weight: 600;
    }
    
    .nav-link {
        color: white !important;
        font-weight: 500;
    }
    
    .nav-link:hover {
        color: #f0f9f8 !important; /* Turquoise très clair */
    }
    
    .btn-primary {
        background-color: #40e0d0; /* Turquoise clair */
        border-color: #40e0d0;
    }
    
    .btn-primary:hover {
        background-color: #36c9b7; /* Turquoise légèrement plus foncé */
        border-color: #36c9b7;
    }
    
    .btn-outline-light:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }
</style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="bi bi-hospital"></i> Cabinet Médical
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Accueil</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about">À propos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#features">Services</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-primary ms-2 text-white" href="${pageContext.request.contextPath}/RouteController?page=login">
                                <i class="bi bi-box-arrow-in-right"></i> Connexion
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <h1 class="display-4 mb-4">Votre santé, notre priorité</h1>
                <p class="lead mb-5">Notre cabinet médical vous offre des soins de qualité avec une équipe de professionnels dévoués.</p>
                <div class="d-flex justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/RouteController?page=login" class="btn btn-primary btn-lg">
                        <i class="bi bi-box-arrow-in-right"></i> Se connecter
                    </a>
                    <a href="${pageContext.request.contextPath}/RouteController?page=inscription" class="btn btn-outline-light btn-lg">
                        <i class="bi bi-person-plus"></i> S'inscrire
                    </a>
                </div>
            </div>
        </section>
        
        <!-- About Section -->
        <section class="py-5" id="about">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h2 class="mb-4">À propos de notre cabinet</h2>
                        <p class="lead">Notre cabinet médical est dédié à fournir des soins de santé de qualité à tous nos patients.</p>
                        <p>Fondé par une équipe de médecins expérimentés, notre cabinet offre une gamme complète de services médicaux, des consultations générales aux soins spécialisés. Nous nous engageons à fournir des soins personnalisés et attentifs à chaque patient.</p>
                        <p>Notre mission est de promouvoir la santé et le bien-être dans notre communauté en offrant des soins médicaux accessibles et de haute qualité.</p>
                    </div>
                    <div class="col-md-6">
                        <img src="https://www.creativefabrica.com/wp-content/uploads/2019/05/Medical-healthy-clinic-logo-concept-by-DEEMKA-STUDIO-1.jpg" 
                             alt="Cabinet médical" class="img-fluid rounded shadow">
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Features Section -->
        <section class="py-5 bg-light" id="features">
            <div class="container">
                <h2 class="text-center mb-5">Nos services</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="feature-card bg-white text-center">
                            <div class="feature-icon">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                            <h3>Consultations médicales</h3>
                            <p>Consultations générales et spécialisées avec nos médecins expérimentés.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card bg-white text-center">
                            <div class="feature-icon">
                                <i class="bi bi-heart-pulse"></i>
                            </div>
                            <h3>Suivi médical</h3>
                            <p>Suivi personnalisé pour les maladies chroniques et les traitements à long terme.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card bg-white text-center">
                            <div class="feature-icon">
                                <i class="bi bi-clipboard2-pulse"></i>
                            </div>
                            <h3>Examens médicaux</h3>
                            <p>Examens complets et bilans de santé pour tous les âges.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- CTA Section -->
        <section class="cta-section">
            <div class="container">
                <h2 class="mb-4">Besoin d'une consultation?</h2>
                <p class="lead mb-4">Prenez rendez-vous dès aujourd'hui et bénéficiez de soins médicaux de qualité.</p>
                <a href="${pageContext.request.contextPath}/RouteController?page=inscription" class="btn btn-light btn-lg">
                    <i class="bi bi-calendar-plus"></i> Prendre rendez-vous
                </a>
            </div>
        </section>
        
        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h5><i class="bi bi-hospital"></i> Cabinet Médical</h5>
                        <p>Des soins de qualité pour toute la famille.</p>
                    </div>
                    <div class="col-md-4">
                        <h5>Liens rapides</h5>
                        <ul class="list-unstyled">
                            <li><a href="#">Accueil</a></li>
                            <li><a href="#about">À propos</a></li>
                            <li><a href="#features">Services</a></li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h5>Contact</h5>
                        <ul class="list-unstyled">
                            <li><i class="bi bi-geo-alt"></i> 123 Rue de la Santé, 75000 Paris</li>
                            <li><i class="bi bi-telephone"></i> +33 1 23 45 67 89</li>
                            <li><i class="bi bi-envelope"></i> contact@cabinet-medical.fr</li>
                        </ul>
                    </div>
                </div>
                <hr class="mt-4 mb-4">
                <div class="text-center">
                    <p>&copy; 2025 Cabinet Médical. Tous droits réservés.</p>
                </div>
            </div>
        </footer>
        
        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
