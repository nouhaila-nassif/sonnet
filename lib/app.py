from flask import Flask, request, jsonify
import openai

app = Flask(__name__)

# Configurez votre clé API OpenAI

# Route pour tester si le serveur fonctionne
@app.route('/')
def home():
    return jsonify({"message": "Le serveur fonctionne"})

@app.route('/recommend', methods=['POST'])
def recommend_music():
    # Récupérer les données envoyées par Flutter
    data = request.json
    mood = data.get('mood', 'heureux')
    genres = data.get('genres', ['pop'])

    # Construire une invite (prompt) pour OpenAI
    prompt = f"Proposez 5 playlists basées sur l'humeur '{mood}' et les genres {', '.join(genres)}. Donnez une description pour chaque playlist."

    try:
        # Appeler l'API OpenAI pour générer des recommandations
        response = openai.Completion.create(
            engine="text-davinci-003",  # Vous pouvez utiliser GPT-4 si disponible
            prompt=prompt,
            max_tokens=200,
            temperature=0.7
        )
        # Retourner les recommandations
        return jsonify({"recommendations": response.choices[0].text.strip()})
    
    except Exception as e:
        # Gérer les erreurs et renvoyer une réponse d'erreur
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    # Lancer l'application Flask avec le mode debug activé
    app.run(debug=True)
