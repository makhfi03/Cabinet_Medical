<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@page import="entities.Consultation"%>
<%@page import="services.ConsultationService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Collections"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Statistiques" />
    <jsp:param name="currentPage" value="statistiques" />
    <jsp:param name="pageTitle" value="Statistiques" />
</jsp:include>

<%
    // Vérifier si un médecin est connecté
    boolean isMedecin = (session.getAttribute("medecin") != null);
    
    ConsultationService cs = new ConsultationService();
    List<Consultation> consultations = cs.findAll();
    
    // Statistiques par médecin
    List<Object[]> statsByMedecin = cs.countConsultationsByMedecin();
    
    // Statistiques par mois
    List<Object[]> statsByMonth = cs.countConsultationsByMonth();
    
    // Préparer les données pour les graphiques
    String[] months = {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};
    int[] consultationsByMonth = new int[12];
    
    if (statsByMonth != null) {
        for (Object[] stat : statsByMonth) {
            int month = ((Number) stat[0]).intValue() - 1; // Les mois commencent à 1 dans la base de données
            int count = ((Number) stat[1]).intValue();
            if (month >= 0 && month < 12) {
                consultationsByMonth[month] = count;
            }
        }
    }
    
    // Calculer le nombre total de consultations
    int totalConsultations = consultations != null ? consultations.size() : 0;
    
    // Calculer le nombre de consultations du mois en cours
    Calendar cal = Calendar.getInstance();
    int currentMonth = cal.get(Calendar.MONTH);
    int currentYear = cal.get(Calendar.YEAR);
    
    int consultationsThisMonth = 0;
    if (consultations != null) {
        for (Consultation c : consultations) {
            cal.setTime(c.getDate());
            if (cal.get(Calendar.MONTH) == currentMonth && cal.get(Calendar.YEAR) == currentYear) {
                consultationsThisMonth++;
            }
        }
    }
    
    // Calculer le nombre de patients uniques
    java.util.Set<Integer> uniquePatients = new java.util.HashSet<Integer>();
    if (consultations != null) {
        for (Consultation c : consultations) {
            uniquePatients.add(c.getPatient().getId());
        }
    }
    int totalPatients = uniquePatients.size();
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
    <!-- Statistiques générales -->
    <div class="row">
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Consultations totales</h3>
                <div class="number"><%= totalConsultations %></div>
                <div class="description">Nombre total de consultations</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Consultations ce mois</h3>
                <div class="number"><%= consultationsThisMonth %></div>
                <div class="description"><%= months[currentMonth] %> <%= currentYear %></div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Patients suivis</h3>
                <div class="number"><%= totalPatients %></div>
                <div class="description">Patients uniques</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h3>Moyenne mensuelle</h3>
                <div class="number">
                    <%= totalConsultations > 0 ? String.format("%.1f", (double) totalConsultations / 12) : "0" %>
                </div>
                <div class="description">Consultations par mois</div>
            </div>
        </div>
    </div>

    <!-- Graphiques -->
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-bar-chart"></i> Consultations par mois</h3>
                </div>
                <div class="card-body">
                    <canvas id="monthlyChart" width="400" height="300"></canvas>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-pie-chart"></i> Consultations par médecin</h3>
                </div>
                <div class="card-body">
                    <canvas id="doctorChart" width="400" height="300"></canvas>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Tableau détaillé -->
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h3><i class="bi bi-table"></i> Détails des consultations par médecin</h3>
                </div>
                <div class="card-body">
                    <% if (statsByMedecin != null && !statsByMedecin.isEmpty()) { %>
                        <div class="table-container">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Médecin</th>
                                        <th>Nombre de consultations</th>
                                        <th>Pourcentage</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        for (Object[] stat : statsByMedecin) {
                                            String medecinName = (String) stat[0];
                                            long count = (Long) stat[1];
                                            double percentage = totalConsultations > 0 ? (count * 100.0 / totalConsultations) : 0;
                                    %>
                                        <tr>
                                            <td>Dr. <%= medecinName %></td>
                                            <td><%= count %></td>
                                            <td><%= String.format("%.1f%%", percentage) %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle-fill"></i> Aucune donnée disponible pour le moment.
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts pour les graphiques -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Graphique des consultations par mois
            var monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
            var monthlyChart = new Chart(monthlyCtx, {
                type: 'bar',
                data: {
                    labels: [<%
                        StringBuilder monthsStr = new StringBuilder();
                        for (int i = 0; i < months.length; i++) {
                            if (i > 0) monthsStr.append(",");
                            monthsStr.append("\"").append(months[i]).append("\"");
                        }
                        out.print(monthsStr.toString());
                    %>],
                    datasets: [{
                        label: 'Nombre de consultations',
                        data: [<%
                            StringBuilder dataStr = new StringBuilder();
                            for (int i = 0; i < consultationsByMonth.length; i++) {
                                if (i > 0) dataStr.append(",");
                                dataStr.append(consultationsByMonth[i]);
                            }
                            out.print(dataStr.toString());
                        %>],
                        backgroundColor: 'rgba(231, 76, 60, 0.7)',
                        borderColor: 'rgba(231, 76, 60, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                precision: 0
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
            
            // Graphique des consultations par médecin
            var doctorCtx = document.getElementById('doctorChart').getContext('2d');
            var doctorLabels = [];
            var doctorData = [];
            var doctorColors = [
                'rgba(231, 76, 60, 0.7)',
                'rgba(52, 152, 219, 0.7)',
                'rgba(46, 204, 113, 0.7)',
                'rgba(155, 89, 182, 0.7)',
                'rgba(241, 196, 15, 0.7)',
                'rgba(26, 188, 156, 0.7)'
            ];
            
            <% 
                if (statsByMedecin != null) {
                    for (Object[] stat : statsByMedecin) {
                        String medecinName = (String) stat[0];
                        long count = (Long) stat[1];
            %>
                doctorLabels.push('Dr. <%= medecinName %>');
                doctorData.push(<%= count %>);
            <% 
                    }
                }
            %>
            
            var doctorChart = new Chart(doctorCtx, {
                type: 'pie',
                data: {
                    labels: doctorLabels,
                    datasets: [{
                        data: doctorData,
                        backgroundColor: doctorColors,
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            position: 'right'
                        }
                    }
                }
            });
        });
    </script>
<% } %>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
