<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Patient"%>
<%@page import="entities.Medecin"%>
<%@page import="services.MedecinService"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Prendre un rendez-vous" />
    <jsp:param name="currentPage" value="rendezvous" />
    <jsp:param name="pageTitle" value="Prendre un rendez-vous" />
</jsp:include>

<style>
    .card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease;
    }
    
    .card:hover {
        transform: translateY(-5px);
    }
    
    .card-header {
        background: linear-gradient(135deg, #4a90e2, #357abd);
        color: white;
        border-radius: 15px 15px 0 0 !important;
        padding: 20px;
    }
    
    .form-control {
        border-radius: 10px;
        border: 2px solid #e0e0e0;
        padding: 12px;
        transition: border-color 0.3s ease;
    }
    
    .form-control:focus {
        border-color: #4a90e2;
        box-shadow: 0 0 0 0.2rem rgba(74, 144, 226, 0.25);
    }
    
    .btn-primary {
        background: linear-gradient(135deg, #4a90e2, #357abd);
        border: none;
        border-radius: 10px;
        padding: 12px 25px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-primary:hover {
        background: linear-gradient(135deg, #357abd, #2a5f8f);
        transform: translateY(-2px);
    }
    
    .table {
        border-radius: 10px;
        overflow: hidden;
    }
    
    .table thead th {
        background: #4a90e2;
        color: white;
        border: none;
        padding: 15px;
    }
    
    .table tbody tr {
        transition: background-color 0.3s ease;
    }
    
    .table tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    .badge {
        padding: 8px 12px;
        border-radius: 20px;
        font-weight: 500;
    }
    
    .badge.bg-warning {
        background: linear-gradient(135deg, #ffc107, #ff9800) !important;
    }
    
    .badge.bg-success {
        background: linear-gradient(135deg, #28a745, #218838) !important;
    }
    
    .alert {
        border-radius: 10px;
        border: none;
        padding: 15px;
    }
    
    .alert-danger {
        background: linear-gradient(135deg, #dc3545, #c82333);
        color: white;
    }
    
    .alert-info {
        background: linear-gradient(135deg, #17a2b8, #138496);
        color: white;
    }
</style>

<%
    MedecinService ms = new MedecinService();
    List<Medecin> medecins = ms.findAll();
    
    // Vérifier si un patient est connecté
    Patient patient = (Patient) session.getAttribute("patient");
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
%>

<% if (patient == null) { %>
    <div class="alert alert-danger">
        <i class="bi bi-exclamation-triangle-fill"></i> Vous devez être connecté pour prendre un rendez-vous.
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/RouteController?page=login" class="btn btn-primary">
            <i class="bi bi-box-arrow-in-right"></i> Se connecter
        </a>
    </div>
<% } else { %>
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-calendar-plus"></i> Prendre un rendez-vous</h3>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/ConsultationController" method="post">
                        <input type="hidden" name="patientId" value="<%= patient.getId() %>">
                        
                        <div class="form-group mb-4">
                            <label for="medecinId" class="form-label">Médecin</label>
                            <select class="form-control" id="medecinId" name="medecinId" required>
                                <option value="">Sélectionner un médecin</option>
                                <% for (Medecin m : medecins) { %>
                                    <option value="<%= m.getId() %>">
                                        Dr. <%= m.getNom() %> (<%= m.getSpecialite() %>)
                                    </option>
                                <% } %>
                            </select>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label for="dateConsultation" class="form-label">Date du rendez-vous</label>
                            <input type="date" class="form-control" id="dateConsultation" name="dateConsultation" required
                                   min="<%= today %>">
                        </div>
                        
                        <div class="form-group mb-4">
                            <label for="diagnostic" class="form-label">Motif de la consultation</label>
                            <textarea class="form-control" id="diagnostic" name="diagnostic" rows="4" required
                                      placeholder="Décrivez brièvement le motif de votre consultation"></textarea>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-calendar-check"></i> Prendre rendez-vous
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-calendar-event"></i> Mes rendez-vous</h3>
                </div>
                <div class="card-body">
                    <jsp:include page="/WEB-INF/includes/patient-consultations.jsp" />
                </div>
            </div>
        </div>
    </div>
<% } %>

<jsp:include page="/WEB-INF/includes/footer.jsp" /> 