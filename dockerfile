# Step 1: Use the official Node.js image as a base image
FROM node:21.3-alpine

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json (if present) into the container
COPY package.json package-lock.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of your application files into the container
COPY . .

# Step 6: Expose the port that the Next.js app will run on (default is 3000)
EXPOSE 3000

# Step 7: Build the Next.js app
RUN npm run build

# Step 8: Start the Next.js app
CMD ["npm", "start"]
