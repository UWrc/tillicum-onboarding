import os
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"

import tensorflow as tf
import time

print("▶️ Starting Tillicum demo job...")
print(f"Using TensorFlow {tf.__version__}")

gpus = tf.config.list_physical_devices('GPU')
if gpus:
    print(f"CUDA available; {len(gpus)} GPU(s) detected:")
    for i, gpu in enumerate(gpus):
        details = tf.config.experimental.get_device_details(gpu)
        name = details.get('device_name', 'Unknown GPU')
        print(f"  GPU {i}: {name}")
else:
    print("No GPU detected.")

time.sleep(2)
print("✅ Completed successfully.")