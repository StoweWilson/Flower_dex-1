from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from PIL import Image
import torch
import torchvision.models as models
import torchvision.transforms as transforms
import io
import os
import google.generativeai as genai
import base64

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configure Gemini API
genai.configure(api_key=os.getenv("you dont get my api key"))
gemini_model = genai.GenerativeModel('gemini-1.5-pro-latest')

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        contents = await file.read()
        image = Image.open(io.BytesIO(contents)).convert("RGB")

        # Gemini needs the image as a PIL Image directly
        response = gemini_model.generate_content([
            "Identify the flower in this image. Return the species name, a confidence percentage (as a number only), and one interesting fact about this flower.",
            image
        ])

        print("🌸 Gemini Response:", response.text)

        # Basic parsing – refine if needed
        lines = response.text.strip().split("\n")
        name = lines[0] if len(lines) > 0 else "Unknown"
        confidence = lines[1] if len(lines) > 1 else "Not provided"
        fact = lines[2] if len(lines) > 2 else "No fact available."

        return {
            "name": name,
            "confidence": confidence,
            "facts": fact
        }

    except Exception as e:
        print("❌ Gemini error:", e)
        return {
            "name": "Unknown",
            "confidence": 0,
            "facts": "No fact available."
        }