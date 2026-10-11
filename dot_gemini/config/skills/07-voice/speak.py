import sys
import asyncio
import argparse
import edge_tts

async def generate_speech(text: str, voice: str, output: str):
    communicate = edge_tts.Communicate(text, voice)
    await communicate.save(output)

def main():
    parser = argparse.ArgumentParser(description="Edge-TTS Speech Generator")
    parser.add_argument("--text", required=True, help="Text to speak")
    parser.add_argument("--voice", default="zh-TW-YunJheNeural", help="Voice model code")
    parser.add_argument("--output", default="temp_speech.mp3", help="Output mp3 path")
    args = parser.parse_args()

    asyncio.run(generate_speech(args.text, args.voice, args.output))
    print(f"OK: Generated {args.output}")

if __name__ == "__main__":
    main()
