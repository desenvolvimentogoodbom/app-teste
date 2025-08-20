# Etapa 1: Build
FROM node:20-alpine AS builder
WORKDIR /app

# Copia apenas os arquivos essenciais para instalar dependências
COPY package*.json ./
COPY astro.config.* ./
COPY tsconfig.* ./

# Instala dependências de produção + dev
RUN npm install

# Copia o restante do projeto
COPY . .

# Build da aplicação
RUN npm run build

# Etapa 2: Imagem final para produção
FROM node:20-alpine
WORKDIR /app

# Copia arquivos gerados no build
COPY --from=builder /app/dist ./dist
COPY package*.json ./
COPY astro.config.* ./

# Instala dependências apenas de produção
RUN npm install --omit=dev

# Expõe a porta padrão
ENV PORT=4321
EXPOSE 4321

# Comando para iniciar o app
#CMD ["npx", "astro", "preview"]
CMD ["npx", "astro", "preview", "--host", "0.0.0.0", "--port", "4321"]
