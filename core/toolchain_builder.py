import os
import subprocess
import sys
import time

class ToolchainBuilder:
    def __init__(self, stage="stage1"):
        self.stage = stage
        self.scripts_dir = f"/mnt/ukemi/core/scripts/{stage}"
        self.logs_dir = "/mnt/ukemi/logs"
        self.lfs = os.environ.get("LFS", "/mnt/ukemi/target")
        self.lfs_tgt = os.environ.get("LFS_TGT", "x86_64-lfs-linux-gnu")
        
        os.makedirs(self.logs_dir, exist_ok=True)
        # Ensure LFS structure exists in tools
        os.makedirs(f"{self.lfs}/tools", exist_ok=True)
        os.makedirs(f"{self.lfs}/usr/include", exist_ok=True)
        os.makedirs(f"{self.lfs}/lib", exist_ok=True)
        os.makedirs(f"{self.lfs}/lib64", exist_ok=True)

    def run_script(self, script_path):
        script_name = os.path.basename(script_path)
        log_file = os.path.join(self.logs_dir, f"{self.stage}_{script_name}.log")
        
        print(f"🚀 Iniciando {script_name}...")
        print(f"📄 Log: {log_file}")
        
        start_time = time.time()
        
        with open(log_file, "w") as f:
            try:
                process = subprocess.Popen(
                    ["bash", script_path],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    text=True,
                    env=os.environ.copy()
                )
                
                for line in process.stdout:
                    f.write(line)
                    # Optionally print important info to console
                    if "Building" in line or "error" in line.lower():
                         print(f"  > {line.strip()}")
                
                process.wait()
                
                if process.returncode == 0:
                    duration = time.time() - start_time
                    print(f"✅ {script_name} finalizado con éxito en {duration:.2f}s.")
                    return True
                else:
                    print(f"❌ {script_name} FALLÓ. Revisa el log: {log_file}")
                    return False
                    
            except Exception as e:
                print(f"❌ Error interno ejecutando {script_name}: {e}")
                return False

    def build(self):
        scripts = sorted([
            os.path.join(self.scripts_dir, f) 
            for f in os.listdir(self.scripts_dir) 
            if f.endswith(".sh")
        ])
        
        if not scripts:
            print(f"⚠️ No hay scripts en {self.scripts_dir}")
            return False

        print(f"🏗️ Iniciando construcción de {self.stage}...")
        
        for script in scripts:
            if not self.run_script(script):
                print(f"🛑 Construcción detenida por fallo en {script}")
                return False
        
        print(f"✨ {self.stage} completado con éxito.")
        return True

if __name__ == "__main__":
    builder = ToolchainBuilder()
    if builder.build():
        sys.exit(0)
    else:
        sys.exit(1)
