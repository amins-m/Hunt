const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();

// Allow requests from your frontend (Live Server runs on 127.0.0.1:5500)
app.use(cors({ origin: "http://127.0.0.1:5500" }));

// Increase payload limit to handle large PDFs
app.use(bodyParser.json({ limit: "100mb" }));

// Handle PDF upload
app.post("/upload", (req, res) => {
    if (!req.body.pdf) {
        return res.status(400).json({ message: "No PDF data received" });
    }

    console.log("PDF received successfully!");
    res.json({ message: "PDF uploaded successfully" });
});

// Start server on port 3000
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
