FROM tomcat:9.0-jdk17-temurin

# Remove o app padrão do Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia seu WAR gerado pelo NetBeans
COPY dist/AgenteSaudeGPS.war /usr/local/tomcat/webapps/ROOT.war

# Porta padrão do Tomcat
EXPOSE 8080

CMD ["catalina.sh", "run"]
