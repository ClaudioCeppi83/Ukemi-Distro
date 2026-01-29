import os
import subprocess
import sys
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler("./logs/execution.log"),
        logging.StreamHandler(sys.stdout)
    ]
)

class AntigravityOrchestrator:
    def __init__(self):
        self.context_path = "./.context/"
        self.log_path = "./logs/execution.log"
        self.error_log_path = "./logs/error.log"

    def run_safe_command(self, command):
        """Ejecuta comandos capturando errores para evitar panics del agente."""
        try:
            logging.info(f"🚀 Ejecutando: {command}")
            # Ensure the command is not empty
            if not command.strip():
                logging.warning("⚠️ Comando vacío recibido.")
                return False

            result = subprocess.run(
                command, shell=True, check=True, 
                capture_output=True, text=True
            )
            
            # Log output to file
            with open(self.log_path, "a") as f:
                f.write(f"\n--- Output de: {command} ---\n")
                f.write(result.stdout)
                f.write("\n------------------------------\n")
            
            return True

        except subprocess.CalledProcessError as e:
            error_msg = f"❌ FALLO en: {command}\nError Code: {e.returncode}\nStderr: {e.stderr}\nStdout: {e.stdout}\n"
            logging.error(error_msg)
            
            with open(self.error_log_path, "a") as f:
                f.write(error_msg)
            
            return False

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description='Ukemi Distro Safe Orchestrator')
    parser.add_argument('command', help='Command to execute safely')
    args = parser.parse_args()

    orchestrator = AntigravityOrchestrator()
    sys.exit(0 if orchestrator.run_safe_command(args.command) else 1)
