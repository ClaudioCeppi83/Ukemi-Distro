import os
import yaml
import hashlib
import requests
import sys

class Downloader:
    def __init__(self, manifest_path, output_dir):
        self.manifest_path = manifest_path
        self.output_dir = output_dir
        os.makedirs(output_dir, exist_ok=True)

    def get_sha256(self, file_path):
        sha256_hash = hashlib.sha256()
        with open(file_path, "rb") as f:
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()

    def download_package(self, pkg):
        name = pkg['name']
        url = pkg['url']
        expected_hash = pkg.get('sha256')
        filename = url.split('/')[-1]
        dest_path = os.path.join(self.output_dir, filename)

        if os.path.exists(dest_path):
            if expected_hash == "SKIP":
                print(f"✅ {name} ya existe (salteando validación hash)")
                return True
            
            actual_hash = self.get_sha256(dest_path)
            if actual_hash == expected_hash:
                print(f"✅ {name} ya existe y el hash coincide.")
                return True
            else:
                print(f"⚠️ {name} existe pero el hash NO coincide. Re-descargando...")

        print(f"📥 Descargando {name} desde {url}...")
        try:
            response = requests.get(url, stream=True, timeout=30)
            response.raise_for_status()
            
            with open(dest_path, "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
            
            if expected_hash != "SKIP":
                actual_hash = self.get_sha256(dest_path)
                if actual_hash == expected_hash:
                    print(f"✅ {name} descargado y verificado correctamente.")
                    return True
                else:
                    print(f"❌ ERROR: El hash de {name} no coincide después de la descarga.")
                    return False
            else:
                print(f"✅ {name} descargado (validación omitida).")
                return True

        except Exception as e:
            print(f"❌ Fallo al descargar {name}: {e}")
            return False

    def run(self):
        with open(self.manifest_path, 'r') as f:
            data = yaml.safe_load(f)
        
        success = True
        for pkg in data['packages']:
            if not self.download_package(pkg):
                success = False
        
        return success

if __name__ == "__main__":
    manifest = "core/manifest.yaml"
    sources_dir = "build/sources"
    
    dl = Downloader(manifest, sources_dir)
    if dl.run():
        print("\n🚀 Todas las fuentes han sido procesadas correctamente.")
        sys.exit(0)
    else:
        print("\n❌ Hubo errores procesando algunas fuentes.")
        sys.exit(1)
