// =================================================================
// Local Image Generation Service - Stable Diffusion WebUI, ComfyUI対応
// =================================================================

import { UnifiedAIService, TextGenerationOptions, ImageGenerationOptions, SlideImageOptions, EnhancedGenerationOptions, AIServiceError } from './unifiedAIService';
import { getUserSettings, StableDiffusionConfig, ComfyUIConfig } from '../storageService';

// デフォルト設定
const DEFAULT_SD_ENDPOINT = 'http://localhost:7860';
const DEFAULT_COMFYUI_ENDPOINT = 'http://localhost:8188';
const DEFAULT_TIMEOUT = 300000; // 5分（画像生成は時間がかかる）

// Stable Diffusion WebUI APIレスポンス型
interface SDWebUIResponse {
    images: string[];      // Base64エンコードされた画像
    parameters: any;
    info: string;
}

// サイズ変換ヘルパー
function getSizeForSD(size?: 'square' | 'landscape' | 'portrait', config?: StableDiffusionConfig): { width: number; height: number } {
    const defaultWidth = config?.width || 1024;
    const defaultHeight = config?.height || 576;

    switch (size) {
        case 'square':
            return { width: 1024, height: 1024 };
        case 'portrait':
            return { width: 576, height: 1024 };
        case 'landscape':
        default:
            return { width: defaultWidth, height: defaultHeight };
    }
}

// Stable Diffusion WebUI実装クラス
export class StableDiffusionService implements UnifiedAIService {
    private config: StableDiffusionConfig;

    constructor() {
        const settings = getUserSettings();
        const sdConfig = settings.providerAuth?.stable_diffusion;

        this.config = {
            endpoint: sdConfig?.endpoint || DEFAULT_SD_ENDPOINT,
            modelName: sdConfig?.modelName,
            samplerName: sdConfig?.samplerName || 'Euler a',
            steps: sdConfig?.steps || 20,
            cfgScale: sdConfig?.cfgScale || 7,
            width: sdConfig?.width || 1024,
            height: sdConfig?.height || 576,
        };
    }

    async generateText(prompt: string, options?: TextGenerationOptions): Promise<string> {
        throw new AIServiceError(
            'Stable Diffusionはテキスト生成をサポートしていません',
            'stable_diffusion',
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateImage(prompt: string, options?: ImageGenerationOptions): Promise<string> {
        try {
            const { width, height } = getSizeForSD(options?.size, this.config);

            const response = await fetch(`${this.config.endpoint}/sdapi/v1/txt2img`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    prompt: prompt,
                    negative_prompt: 'blurry, low quality, distorted, watermark, text, logo',
                    width: width,
                    height: height,
                    steps: this.config.steps,
                    cfg_scale: this.config.cfgScale,
                    sampler_name: this.config.samplerName,
                    batch_size: 1,
                    n_iter: 1,
                }),
            });

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Stable Diffusion API Error (${response.status}): ${errorText}`);
            }

            const data: SDWebUIResponse = await response.json();

            if (data.images && data.images.length > 0) {
                // Base64画像をData URL形式で返す
                return `data:image/png;base64,${data.images[0]}`;
            }

            throw new Error('No image generated');
        } catch (error) {
            throw new AIServiceError(
                error instanceof Error ? error.message : '画像生成に失敗しました',
                'stable_diffusion',
                'IMAGE_GENERATION_ERROR'
            );
        }
    }

    async generateSlideContent(topic: string, slideCount?: number, enhancedOptions?: EnhancedGenerationOptions): Promise<string> {
        throw new AIServiceError(
            'Stable Diffusionはスライドコンテンツ生成をサポートしていません',
            'stable_diffusion',
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateSlideImage(prompt: string, options?: SlideImageOptions): Promise<string> {
        // スライド用の画像生成は通常の画像生成と同じ
        return this.generateImage(prompt, {
            size: options?.size || 'landscape',
            quality: options?.quality,
            style: options?.style,
        });
    }

    async analyzeVideo(videoData: string, prompt?: string): Promise<string> {
        throw new AIServiceError(
            'Stable Diffusionは動画分析をサポートしていません',
            'stable_diffusion',
            'UNSUPPORTED_OPERATION'
        );
    }

    getMaxTokens(safetyMargin?: number): number {
        return 0; // 画像生成サービスなのでトークンは関係ない
    }

    getModelInfo(): { service: string; model: string; limits: any } | null {
        return {
            service: 'stable_diffusion',
            model: this.config.modelName || 'default',
            limits: {
                maxWidth: 2048,
                maxHeight: 2048,
            },
        };
    }

    async testConnection(): Promise<boolean> {
        try {
            const response = await fetch(`${this.config.endpoint}/sdapi/v1/sd-models`, {
                method: 'GET',
            });
            return response.ok;
        } catch (error) {
            console.error('Stable Diffusion connection test failed:', error);
            return false;
        }
    }

    // EnhancedAIServiceのメソッド実装
    async generateVideoSlides(request: any): Promise<any> {
        throw new AIServiceError(
            'Stable Diffusionは動画からのスライド生成をサポートしていません',
            'stable_diffusion',
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateSlideImages(slides: any[], theme: string, imageSettings: any): Promise<{ [slideId: string]: string }> {
        // 複数スライドの画像を生成
        const results: { [slideId: string]: string } = {};
        for (const slide of slides) {
            if (slide.imagePrompt) {
                try {
                    const image = await this.generateImage(slide.imagePrompt, { size: 'landscape' });
                    results[slide.id] = image;
                } catch (error) {
                    console.error(`Failed to generate image for slide ${slide.id}:`, error);
                }
            }
        }
        return results;
    }

    getProviderInfo(): { name: string; version: string; capabilities: string[] } {
        return {
            name: 'stable_diffusion',
            version: '1.0.0',
            capabilities: ['image-generation', 'slide-image-generation'],
        };
    }
}

// ComfyUI実装クラス
export class ComfyUIService implements UnifiedAIService {
    private config: ComfyUIConfig;
    private clientId: string;

    constructor() {
        const settings = getUserSettings();
        const comfyConfig = settings.providerAuth?.comfyui;

        this.config = {
            endpoint: comfyConfig?.endpoint || DEFAULT_COMFYUI_ENDPOINT,
            workflowId: comfyConfig?.workflowId,
            timeout: comfyConfig?.timeout || DEFAULT_TIMEOUT,
        };

        this.clientId = `slidemaster_${Date.now()}`;
    }

    async generateText(prompt: string, options?: TextGenerationOptions): Promise<string> {
        throw new AIServiceError(
            'ComfyUIはテキスト生成をサポートしていません',
            'comfyui',
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateImage(prompt: string, options?: ImageGenerationOptions): Promise<string> {
        try {
            // 基本的なtext-to-image ワークフローを構築
            const workflow = this.buildBasicWorkflow(prompt, options);

            // プロンプトをキューに追加
            const queueResponse = await fetch(`${this.config.endpoint}/prompt`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    prompt: workflow,
                    client_id: this.clientId,
                }),
            });

            if (!queueResponse.ok) {
                const errorText = await queueResponse.text();
                throw new Error(`ComfyUI Queue Error (${queueResponse.status}): ${errorText}`);
            }

            const queueData = await queueResponse.json();
            const promptId = queueData.prompt_id;

            // 生成完了を待機
            const imageData = await this.waitForImage(promptId);
            return imageData;
        } catch (error) {
            throw new AIServiceError(
                error instanceof Error ? error.message : '画像生成に失敗しました',
                'comfyui',
                'IMAGE_GENERATION_ERROR'
            );
        }
    }

    private buildBasicWorkflow(prompt: string, options?: ImageGenerationOptions): any {
        // シンプルなSD1.5/SDXL用ワークフロー
        const { width, height } = this.getSizeForComfyUI(options?.size);

        return {
            "3": {
                "class_type": "KSampler",
                "inputs": {
                    "cfg": 7,
                    "denoise": 1,
                    "latent_image": ["5", 0],
                    "model": ["4", 0],
                    "negative": ["7", 0],
                    "positive": ["6", 0],
                    "sampler_name": "euler_ancestral",
                    "scheduler": "normal",
                    "seed": Math.floor(Math.random() * 1000000000),
                    "steps": 20
                }
            },
            "4": {
                "class_type": "CheckpointLoaderSimple",
                "inputs": {
                    "ckpt_name": "sd_xl_base_1.0.safetensors"
                }
            },
            "5": {
                "class_type": "EmptyLatentImage",
                "inputs": {
                    "batch_size": 1,
                    "height": height,
                    "width": width
                }
            },
            "6": {
                "class_type": "CLIPTextEncode",
                "inputs": {
                    "clip": ["4", 1],
                    "text": prompt
                }
            },
            "7": {
                "class_type": "CLIPTextEncode",
                "inputs": {
                    "clip": ["4", 1],
                    "text": "blurry, low quality, distorted, watermark, text"
                }
            },
            "8": {
                "class_type": "VAEDecode",
                "inputs": {
                    "samples": ["3", 0],
                    "vae": ["4", 2]
                }
            },
            "9": {
                "class_type": "SaveImage",
                "inputs": {
                    "filename_prefix": "slidemaster",
                    "images": ["8", 0]
                }
            }
        };
    }

    private getSizeForComfyUI(size?: 'square' | 'landscape' | 'portrait'): { width: number; height: number } {
        switch (size) {
            case 'square':
                return { width: 1024, height: 1024 };
            case 'portrait':
                return { width: 768, height: 1024 };
            case 'landscape':
            default:
                return { width: 1024, height: 768 };
        }
    }

    private async waitForImage(promptId: string): Promise<string> {
        const startTime = Date.now();
        const timeout = this.config.timeout || DEFAULT_TIMEOUT;

        while (Date.now() - startTime < timeout) {
            try {
                // 履歴をチェック
                const historyResponse = await fetch(`${this.config.endpoint}/history/${promptId}`);

                if (historyResponse.ok) {
                    const history = await historyResponse.json();

                    if (history[promptId] && history[promptId].outputs) {
                        // 出力画像を探す
                        for (const nodeId in history[promptId].outputs) {
                            const output = history[promptId].outputs[nodeId];
                            if (output.images && output.images.length > 0) {
                                const image = output.images[0];
                                // 画像を取得
                                const imageResponse = await fetch(
                                    `${this.config.endpoint}/view?filename=${image.filename}&subfolder=${image.subfolder || ''}&type=${image.type || 'output'}`
                                );

                                if (imageResponse.ok) {
                                    const blob = await imageResponse.blob();
                                    return await this.blobToBase64(blob);
                                }
                            }
                        }
                    }
                }
            } catch (error) {
                console.warn('Error checking ComfyUI history:', error);
            }

            // 1秒待機
            await new Promise(resolve => setTimeout(resolve, 1000));
        }

        throw new Error('Image generation timed out');
    }

    private async blobToBase64(blob: Blob): Promise<string> {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onloadend = () => {
                const result = reader.result as string;
                resolve(result);
            };
            reader.onerror = reject;
            reader.readAsDataURL(blob);
        });
    }

    async generateSlideContent(topic: string, slideCount?: number, enhancedOptions?: EnhancedGenerationOptions): Promise<string> {
        throw new AIServiceError(
            'ComfyUIはスライドコンテンツ生成をサポートしていません',
            'comfyui',
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateSlideImage(prompt: string, options?: SlideImageOptions): Promise<string> {
        return this.generateImage(prompt, {
            size: options?.size || 'landscape',
            quality: options?.quality,
            style: options?.style,
        });
    }

    async analyzeVideo(videoData: string, prompt?: string): Promise<string> {
        throw new AIServiceError(
            'ComfyUIは動画分析をサポートしていません',
            'comfyui',
            'UNSUPPORTED_OPERATION'
        );
    }

    getMaxTokens(safetyMargin?: number): number {
        return 0;
    }

    getModelInfo(): { service: string; model: string; limits: any } | null {
        return {
            service: 'comfyui',
            model: 'workflow-based',
            limits: {
                maxWidth: 2048,
                maxHeight: 2048,
            },
        };
    }

    async testConnection(): Promise<boolean> {
        try {
            const response = await fetch(`${this.config.endpoint}/system_stats`);
            return response.ok;
        } catch (error) {
            console.error('ComfyUI connection test failed:', error);
            return false;
        }
    }

    // EnhancedAIServiceのメソッド実装
    async generateVideoSlides(request: any): Promise<any> {
        throw new AIServiceError(
            'ComfyUIは動画からのスライド生成をサポートしていません',
            'comfyui',
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateSlideImages(slides: any[], theme: string, imageSettings: any): Promise<{ [slideId: string]: string }> {
        // 複数スライドの画像を生成
        const results: { [slideId: string]: string } = {};
        for (const slide of slides) {
            if (slide.imagePrompt) {
                try {
                    const image = await this.generateImage(slide.imagePrompt, { size: 'landscape' });
                    results[slide.id] = image;
                } catch (error) {
                    console.error(`Failed to generate image for slide ${slide.id}:`, error);
                }
            }
        }
        return results;
    }

    getProviderInfo(): { name: string; version: string; capabilities: string[] } {
        return {
            name: 'comfyui',
            version: '1.0.0',
            capabilities: ['image-generation', 'slide-image-generation'],
        };
    }
}

// ファクトリ関数
export function createLocalImageService(providerType: 'stable_diffusion' | 'comfyui'): UnifiedAIService {
    switch (providerType) {
        case 'stable_diffusion':
            return new StableDiffusionService();
        case 'comfyui':
            return new ComfyUIService();
        default:
            throw new AIServiceError(
                `未知のローカル画像生成プロバイダー: ${providerType}`,
                'localImage',
                'UNKNOWN_PROVIDER'
            );
    }
}
