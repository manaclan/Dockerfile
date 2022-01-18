import os
import sys
sys.path.insert(0,'Swin-Transformer-Semantic-Segmentation')
from mmseg.apis import inference_segmentor, init_segmentor
from mmseg.core.evaluation import get_palette
import matplotlib.pyplot as plt
import mmcv
import torch
import cv2
import numpy as np
import requests
from fastapi import FastAPI, File, UploadFile,Form
from fastapi.responses import StreamingResponse, Response


app = FastAPI()
model = init_segmentor('Swin-Transformer-Semantic-Segmentation/configs/swin/upernet_swin_base_20k_signature.py', 
                      'Swin-Transformer-Semantic-Segmentation/current_model/iter_12000.pth', 'cuda:0')


@app.post('/')
async def home(image: UploadFile = File(None)):
  contents = await image.read()
  img = cv2.imdecode(np.frombuffer(contents, np.uint8), cv2.IMREAD_UNCHANGED)
  result = inference_segmentor(model, img)

  coords = cv2.findNonZero(np.array(result[0])) # Find all non-zero points
  x, y, w, h = cv2.boundingRect(coords) # Find minimum spanning bounding box
  return Response(content=cv2.imencode(".jpg", img[y:y+h, x:x+w,:])[1].tobytes(), media_type="image/jpeg")