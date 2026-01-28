// =================================================================
// Local LLM Service - Ollama, LM Studio, Llama.cpp対応
// OpenAI互換APIを使用した統一サービス
// =================================================================

import { UnifiedAIService, TextGenerationOptions, ImageGenerationOptions, SlideImageOptions, EnhancedGenerationOptions, AIServiceError } from './unifiedAIService';
import { getUserSettings, LocalLLMConfig } from '../storageService';

// ローカルLLMのデフォルト設定
const DEFAULT_ENDPOINTS = {
    ollama: 'http://localhost:11434',
    lmstudio: 'http://localhost:1234',
    llamacpp: 'http://localhost:8080',
};

const DEFAULT_TIMEOUT = 120000; // 2分
const DEFAULT_MAX_TOKENS = 4096;

// OpenAI互換APIレスポンス型
interface OpenAICompatibleResponse {
    id: string;
    object: string;
    created: number;
    model: string;
    choices: Array<{
        index: number;
        message?: {
            role: string;
            content: string;
        };
        text?: string;
        finish_reason: string;
    }>;
    usage?: {
        prompt_tokens: number;
        completion_tokens: number;
        total_tokens: number;
    };
}

// Ollama固有のAPIレスポンス型
interface OllamaGenerateResponse {
    model: string;
    created_at: string;
    response: string;
    done: boolean;
    context?: number[];
    total_duration?: number;
    load_duration?: number;
    prompt_eval_count?: number;
    prompt_eval_duration?: number;
    eval_count?: number;
    eval_duration?: number;
}

// OpenAI互換APIを呼び出す共通関数
async function callOpenAICompatibleAPI(
    endpoint: string,
    model: string,
    prompt: string,
    options?: TextGenerationOptions,
    timeout: number = DEFAULT_TIMEOUT
): Promise<string> {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeout);

    try {
        const response = await fetch(`${endpoint}/v1/chat/completions`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                model: model,
                messages: [
                    ...(options?.systemPrompt ? [{ role: 'system', content: options.systemPrompt }] : []),
                    { role: 'user', content: prompt }
                ],
                temperature: options?.temperature ?? 0.7,
                max_tokens: options?.maxTokens ?? DEFAULT_MAX_TOKENS,
                stream: false,
            }),
            signal: controller.signal,
        });

        clearTimeout(timeoutId);

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`API Error (${response.status}): ${errorText}`);
        }

        const data: OpenAICompatibleResponse = await response.json();

        if (data.choices && data.choices.length > 0) {
            const choice = data.choices[0];
            return choice.message?.content || choice.text || '';
        }

        throw new Error('Empty response from API');
    } catch (error) {
        clearTimeout(timeoutId);
        if (error instanceof Error && error.name === 'AbortError') {
            throw new Error(`Request timed out after ${timeout / 1000} seconds`);
        }
        throw error;
    }
}

// Ollama固有のAPIを呼び出す関数（/api/generate）
async function callOllamaGenerateAPI(
    endpoint: string,
    model: string,
    prompt: string,
    options?: TextGenerationOptions,
    timeout: number = DEFAULT_TIMEOUT
): Promise<string> {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeout);

    try {
        // まずシステムプロンプトを含む完全なプロンプトを構築
        const fullPrompt = options?.systemPrompt
            ? `${options.systemPrompt}\n\nUser: ${prompt}\n\nAssistant:`
            : prompt;

        const response = await fetch(`${endpoint}/api/generate`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                model: model,
                prompt: fullPrompt,
                stream: false,
                options: {
                    temperature: options?.temperature ?? 0.7,
                    num_predict: options?.maxTokens ?? DEFAULT_MAX_TOKENS,
                },
            }),
            signal: controller.signal,
        });

        clearTimeout(timeoutId);

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Ollama API Error (${response.status}): ${errorText}`);
        }

        const data: OllamaGenerateResponse = await response.json();
        return data.response || '';
    } catch (error) {
        clearTimeout(timeoutId);
        if (error instanceof Error && error.name === 'AbortError') {
            throw new Error(`Request timed out after ${timeout / 1000} seconds`);
        }
        throw error;
    }
}

// ベースクラス: ローカルLLM共通機能
abstract class BaseLocalLLMService implements UnifiedAIService {
    protected config: LocalLLMConfig;
    protected providerName: string;

    constructor(providerName: string, defaultEndpoint: string) {
        this.providerName = providerName;
        const settings = getUserSettings();
        const providerConfig = settings.providerAuth?.[providerName as keyof typeof settings.providerAuth] as LocalLLMConfig | undefined;

        this.config = {
            endpoint: providerConfig?.endpoint || defaultEndpoint,
            modelName: providerConfig?.modelName || '',
            timeout: providerConfig?.timeout || DEFAULT_TIMEOUT,
            maxTokens: providerConfig?.maxTokens || DEFAULT_MAX_TOKENS,
        };

        if (!this.config.endpoint) {
            throw new AIServiceError(
                `${providerName} エンドポイントが設定されていません`,
                providerName,
                'CONFIG_MISSING'
            );
        }
    }

    abstract generateText(prompt: string, options?: TextGenerationOptions): Promise<string>;

    async generateImage(prompt: string, options?: ImageGenerationOptions): Promise<string> {
        throw new AIServiceError(
            `${this.providerName}は画像生成をサポートしていません`,
            this.providerName,
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateSlideContent(
        topic: string,
        slideCount?: number,
        enhancedOptions?: EnhancedGenerationOptions
    ): Promise<string> {
        if (enhancedOptions?.enhancedPrompt) {
            console.log(`🎯 ${this.providerName}: Using enhanced prompt!`);
            return await this.generateText(enhancedOptions.enhancedPrompt, {
                systemPrompt: 'あなたは優秀なプレゼンテーションデザイナーです。指定された形式でスライドコンテンツを生成してください。',
                temperature: 0.7,
            });
        }
        throw new AIServiceError(
            '強化プロンプトが必要です',
            this.providerName,
            'MISSING_ENHANCED_PROMPT'
        );
    }

    async generateSlideImage(prompt: string, options?: SlideImageOptions): Promise<string> {
        throw new AIServiceError(
            `${this.providerName}は画像生成をサポートしていません。Stable DiffusionまたはComfyUIを画像生成プロバイダーとして設定してください。`,
            this.providerName,
            'UNSUPPORTED_OPERATION'
        );
    }

    async analyzeVideo(videoData: string, prompt?: string): Promise<string> {
        throw new AIServiceError(
            `${this.providerName}は動画分析をサポートしていません。Azure OpenAIまたはGeminiを動画分析プロバイダーとして設定してください。`,
            this.providerName,
            'UNSUPPORTED_OPERATION'
        );
    }

    getMaxTokens(safetyMargin: number = 0.9): number {
        return Math.floor((this.config.maxTokens || DEFAULT_MAX_TOKENS) * safetyMargin);
    }

    getModelInfo(): { service: string; model: string; limits: any } | null {
        return {
            service: this.providerName,
            model: this.config.modelName || 'unknown',
            limits: {
                maxTokens: this.config.maxTokens || DEFAULT_MAX_TOKENS,
                timeout: this.config.timeout || DEFAULT_TIMEOUT,
            },
        };
    }

    // EnhancedAIServiceのメソッド実装
    async generateVideoSlides(request: any): Promise<any> {
        throw new AIServiceError(
            `${this.providerName}は動画からのスライド生成をサポートしていません。Azure OpenAIまたはGeminiを使用してください。`,
            this.providerName,
            'UNSUPPORTED_OPERATION'
        );
    }

    async generateSlideImages(slides: any[], theme: string, imageSettings: any): Promise<{ [slideId: string]: string }> {
        throw new AIServiceError(
            `${this.providerName}はスライド画像生成をサポートしていません。Stable DiffusionまたはComfyUIを使用してください。`,
            this.providerName,
            'UNSUPPORTED_OPERATION'
        );
    }

    getProviderInfo(): { name: string; version: string; capabilities: string[] } {
        return {
            name: this.providerName,
            version: '1.0.0',
            capabilities: ['text-generation', 'slide-content-generation'],
        };
    }

    abstract testConnection(): Promise<boolean>;
}

// Ollama実装クラス
export class OllamaUnifiedService extends BaseLocalLLMService {
    constructor() {
        super('ollama', DEFAULT_ENDPOINTS.ollama);
    }

    async generateText(prompt: string, options?: TextGenerationOptions): Promise<string> {
        try {
            if (!this.config.modelName) {
                throw new AIServiceError(
                    'Ollamaモデル名が設定されていません。設定画面でモデル名を指定してください。',
                    'ollama',
                    'MODEL_NOT_CONFIGURED'
                );
            }

            // まずOpenAI互換APIを試す
            try {
                return await callOpenAICompatibleAPI(
                    this.config.endpoint,
                    this.config.modelName,
                    prompt,
                    options,
                    this.config.timeout
                );
            } catch (openAIError) {
                // OpenAI互換APIが失敗した場合、Ollama固有APIにフォールバック
                console.log('OpenAI互換APIが失敗、Ollama固有APIにフォールバック');
                return await callOllamaGenerateAPI(
                    this.config.endpoint,
                    this.config.modelName,
                    prompt,
                    options,
                    this.config.timeout
                );
            }
        } catch (error) {
            throw new AIServiceError(
                error instanceof Error ? error.message : 'テキスト生成に失敗しました',
                'ollama',
                'TEXT_GENERATION_ERROR'
            );
        }
    }

    async testConnection(): Promise<boolean> {
        try {
            const response = await fetch(`${this.config.endpoint}/api/tags`, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' },
            });
            return response.ok;
        } catch (error) {
            console.error('Ollama connection test failed:', error);
            return false;
        }
    }
}

// LM Studio実装クラス
export class LMStudioUnifiedService extends BaseLocalLLMService {
    constructor() {
        super('lmstudio', DEFAULT_ENDPOINTS.lmstudio);
    }

    async generateText(prompt: string, options?: TextGenerationOptions): Promise<string> {
        try {
            // LM Studioはデフォルトでモデルをロードしているため、モデル名は空でもOK
            const modelName = this.config.modelName || 'local-model';

            return await callOpenAICompatibleAPI(
                this.config.endpoint,
                modelName,
                prompt,
                options,
                this.config.timeout
            );
        } catch (error) {
            throw new AIServiceError(
                error instanceof Error ? error.message : 'テキスト生成に失敗しました',
                'lmstudio',
                'TEXT_GENERATION_ERROR'
            );
        }
    }

    async testConnection(): Promise<boolean> {
        try {
            const response = await fetch(`${this.config.endpoint}/v1/models`, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' },
            });
            return response.ok;
        } catch (error) {
            console.error('LM Studio connection test failed:', error);
            return false;
        }
    }
}

// Llama.cpp実装クラス
export class LlamaCppUnifiedService extends BaseLocalLLMService {
    constructor() {
        super('llamacpp', DEFAULT_ENDPOINTS.llamacpp);
    }

    async generateText(prompt: string, options?: TextGenerationOptions): Promise<string> {
        try {
            // Llama.cppはOpenAI互換APIをサポート
            const modelName = this.config.modelName || 'llama';

            return await callOpenAICompatibleAPI(
                this.config.endpoint,
                modelName,
                prompt,
                options,
                this.config.timeout
            );
        } catch (error) {
            throw new AIServiceError(
                error instanceof Error ? error.message : 'テキスト生成に失敗しました',
                'llamacpp',
                'TEXT_GENERATION_ERROR'
            );
        }
    }

    async testConnection(): Promise<boolean> {
        try {
            // Llama.cppのhealthエンドポイントをチェック
            const response = await fetch(`${this.config.endpoint}/health`, {
                method: 'GET',
            });
            return response.ok;
        } catch (error) {
            // healthが無い場合、modelsエンドポイントを試す
            try {
                const response = await fetch(`${this.config.endpoint}/v1/models`, {
                    method: 'GET',
                });
                return response.ok;
            } catch {
                console.error('Llama.cpp connection test failed:', error);
                return false;
            }
        }
    }
}

// ファクトリ関数
export function createLocalLLMService(providerType: 'ollama' | 'lmstudio' | 'llamacpp'): UnifiedAIService {
    switch (providerType) {
        case 'ollama':
            return new OllamaUnifiedService();
        case 'lmstudio':
            return new LMStudioUnifiedService();
        case 'llamacpp':
            return new LlamaCppUnifiedService();
        default:
            throw new AIServiceError(
                `未知のローカルLLMプロバイダー: ${providerType}`,
                'localLLM',
                'UNKNOWN_PROVIDER'
            );
    }
}
