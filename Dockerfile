# ---- Build Stage ----
FROM node:20-alpine AS builder

WORKDIR /app
# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your files
COPY . .

# Build Next.js for production
RUN npm run build

# ---- Production Stage ----
FROM node:20-alpine AS runner
WORKDIR /app

# Copy only necessary files from builder stage:
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next

# If you’re using Next.js public folder or next.config.js, copy them as needed:
# COPY --from=builder /app/public ./public
# COPY --from=builder /app/next.config.js ./

# Expose your app’s port (default is 3000 for Next)
EXPOSE 3000

# Start Next.js in production mode
CMD ["npm", "run", "start"]
