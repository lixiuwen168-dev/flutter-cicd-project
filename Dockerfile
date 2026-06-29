FROM ubuntu:22.04
RUN apt update && apt install -y curl
WORKDIR /app
COPY . .
CMD bash -c "echo ================================ && \
             echo '🚀 App Running from GitHub!' && \
             echo '📦 Built by Jenkins' && \
             echo '🐳 Running in Docker' && \
             echo ================================"
