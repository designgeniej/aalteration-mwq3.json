# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-inpaint-cropandstitch@3.0.10 --mode remote

# Unknown registry nodes (no aux_id provided) - could not be resolved and therefore are skipped
# Could not resolve unknown_registry node: KSamplerAdvanced (no aux_id provided)
# Could not resolve unknown_registry node: EnhancedLoadDiffusionModel (no aux_id provided)
# Could not resolve unknown_registry node: FluxGuidance (no aux_id provided)
# Could not resolve unknown_registry node: CLIPTextEncode (no aux_id provided)
# Could not resolve unknown_registry node: ImageColorToMask (no aux_id provided)
# Could not resolve unknown_registry node: LoadImage (no aux_id provided)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/blob/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/stable-diffusion-3.5-fp8/resolve/main/text_encoders/clip_l.safetensors --relative-path models/clip --filename clip_l.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/stable-diffusion-3.5-fp8/blob/main/text_encoders/t5xxl_fp16.safetensors --relative-path models/clip --filename t5xxl_fp16.safetensors
RUN comfy model download --url https://huggingface.co/realung/flux1-dev.safetensors --relative-path models/diffusion_models --filename flux1-dev.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
