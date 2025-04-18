from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from PIL import Image
import torch
import torchvision.models as models
import torchvision.transforms as transforms
import io
import os

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load model
model = models.resnet50(weights=None)
model.fc = torch.nn.Linear(2048, 102)

model_path = "fine_tuned_resnet50.pth"

if not os.path.exists(model_path) or os.path.getsize(model_path) < 1000:
    raise FileNotFoundError(f"❌ Model file missing or invalid: {model_path}")

try:
    model.load_state_dict(torch.load(model_path, map_location=torch.device("cpu")))
    model.eval()
    print("✅ Model loaded successfully.")
except Exception as e:
    print(f"❌ Error loading model: {e}")
    raise e

transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize([0.485, 0.456, 0.406],
                         [0.229, 0.224, 0.225])
])

class_labels = {i: f"Class {i}" for i in range(102)}

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        contents = await file.read()
        image = Image.open(io.BytesIO(contents)).convert("RGB")
        image = transform(image).unsqueeze(0)

        with torch.no_grad():
            outputs = model(image)
            predicted_class = torch.argmax(outputs, dim=1).item()
            probs = torch.nn.functional.softmax(outputs, dim=1)
            confidence = probs[0][predicted_class].item()

        name = class_labels.get(predicted_class, f"Class {predicted_class}")
        print(f"✅ Prediction: {name} ({confidence * 100:.2f}%)")

        return {
            "name": name,
            "confidence": round(confidence * 100, 2)
        }

    except Exception as e:
        print(f"❌ Prediction error: {e}")
        return {
            "name": "Unknown",
            "confidence": 0
        }