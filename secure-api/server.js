const express = require('express');
const https = require('https');
const fs = require('fs');
const jwt = require('jsonwebtoken');
const morgan = require('morgan');
const path = require('path');

const app = express();
app.use(express.json());

// --- 1. CONFIGURATION DES LOGS ---
const accessLogStream = fs.createWriteStream(path.join(__dirname, 'access.log'), { flags: 'a' });
app.use(morgan(':remote-addr - :date[iso] - :method :url :status - :response-time ms', { stream: accessLogStream }));
app.use(morgan('dev'));

// --- 2. BASE DE DONNÉES SIMULÉE ---
const SECRET_KEY = "SuperSecretKeyForTask4";
let devices = [
    { id: 1, name: "Router-01", status: "active" },
    { id: 2, name: "Switch-01", status: "offline" }
];

// --- 3. AUTHENTIFICATION ---
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    if (username === 'admin' && password === 'admin123') {
        const token = jwt.sign({ username, role: 'admin' }, SECRET_KEY, { expiresIn: '1h' });
        return res.json({ token });
    } else if (username === 'tech' && password === 'tech123') {
        const token = jwt.sign({ username, role: 'user' }, SECRET_KEY, { expiresIn: '1h' });
        return res.json({ token });
    }
    return res.status(401).json({ error: "Identifiants invalides" });
});

// --- 4. MIDDLEWARE ---
const authenticateJWT = (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (authHeader) {
        const token = authHeader.split(' ')[1];
        jwt.verify(token, SECRET_KEY, (err, user) => {
            if (err) return res.sendStatus(403);
            req.user = user;
            next();
        });
    } else {
        res.sendStatus(401);
    }
};

const requireAdmin = (req, res, next) => {
    if (req.user.role !== 'admin') {
        return res.status(403).json({ error: "Accès refusé." });
    }
    next();
};

// --- 5. ROUTES CRUD ---
app.get('/api/devices', authenticateJWT, (req, res) => {
    res.json(devices);
});

app.post('/api/devices', authenticateJWT, requireAdmin, (req, res) => {
    const newDevice = { id: devices.length + 1, ...req.body };
    devices.push(newDevice);
    res.status(201).json(newDevice);
});

app.delete('/api/devices/:id', authenticateJWT, requireAdmin, (req, res) => {
    devices = devices.filter(d => d.id !== parseInt(req.params.id));
    res.json({ message: "Équipement supprimé" });
});

// --- 6. LOGS ---
app.get('/api/logs', authenticateJWT, requireAdmin, (req, res) => {
    const logPath = path.join(__dirname, 'access.log');
    if (fs.existsSync(logPath)) {
        const logs = fs.readFileSync(logPath, 'utf8').split('\n').filter(line => line);
        res.json(logs.slice(-10));
    } else {
        res.json([]);
    }
});

// --- 7. HTTPS SERVER ---
const httpsOptions = {
    key: fs.readFileSync('server.key'),
    cert: fs.readFileSync('server.cert')
};

https.createServer(httpsOptions, app).listen(3443, () => {
    console.log('Secure API running on https://localhost:3443');
});
