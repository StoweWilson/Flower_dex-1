# 🌺 FlowerDex - AI-Powered Flower Identifier App

FlowerDex is a Flutter application powered by Google Gemini AI that allows users to identify flowers in real-time by simply snapping a picture. The app sends the image to a Python FastAPI backend, which uses Gemini to analyze the image and return the species name, confidence percentage, and an interesting flower fact.

## 🚀 Features
	•	Identify flowers from a photo
	•	AI-generated flower names and fun facts
	•	Confidence score from the AI model
	•	Clean and responsive Flutter UI

#🤖 Tech Stack

Frontend	Backend	AI Model	
Flutter	FastAPI	Gemini (Google Generative AI)	Python

##🔧 Installation & Setup

##Prerequisites
	•	Flutter SDK installed: https://flutter.dev/docs/get-started/install
	•	Python 3.10+
	•	pip install fastapi uvicorn pillow google-generativeai

###1. Clone the Repository

git clone https://github.com/your-username/flowerdex.git
cd flowerdex

###2. Setup Environment Variable

Set your Gemini API Key:

export GOOGLE_API_KEY="your_gemini_api_key_here"

###3. Run the Backend

cd flower_app/flower_ai_backend
uvicorn flower_server:app --reload

###4. Run the Flutter App

cd flower_app
flutter run -d chrome

##📷 Usage
	1.	Click the image upload button.
	2.	Choose or take a picture of a flower.
	3.	Wait for the AI to return the flower name, confidence level, and a cool fact!

##📚 Example Output

{
  "name": "Camellia japonica",
  "confidence": "98%",
  "facts": "Camellia japonica flowers don't produce a scent. They rely on their vibrant color to attract pollinators like hummingbirds."
}

##🚫 Limitations
	•	Requires internet connection for AI model
	•	Prediction depends on image quality
	•	Gemini API usage may have quota limits

##🌟 Future Improvements
	•	Offline flower detection model
	•	User flower collection tracking
	•	Flower location logging with maps

##🙏 Acknowledgements
	•	Flutter
	•	FastAPI
	•	Gemini API
	•	Oxford Flowers 102 Dataset

##📁 License

This project is licensed under the MIT License.
