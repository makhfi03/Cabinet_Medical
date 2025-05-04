</div> <!-- Fin du container-fluid -->
        </div> <!-- Fin du content -->
    </div> <!-- Fin du main-container -->
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery (nécessaire pour certaines fonctionnalités) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Script personnalisé -->
    <script>
        // Toggle sidebar on mobile
        document.addEventListener('DOMContentLoaded', function() {
            const toggleBtn = document.querySelector('.toggle-sidebar');
            if (toggleBtn) {
                toggleBtn.addEventListener('click', function() {
                    document.querySelector('.sidebar').classList.toggle('active');
                    document.querySelector('.content').classList.toggle('active');
                });
            }
        });
    </script>
    
    <!-- Page specific scripts if needed -->
    <% if (request.getParameter("specificScript") != null) { %>
        <script src="${pageContext.request.contextPath}/js/<%= request.getParameter("specificScript") %>"></script>
    <% } %>
</body>
</html>
