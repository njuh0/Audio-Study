# Audio Study - Speech Recognition & AI Chat

Приложение для захвата аудио через BlackHole и преобразования его в текст с использованием двух движков распознавания речи, а также интерактивный чат с ИИ для изучения языков.

## Возможности

### 🎯 AI Chat (NEW!)
- **GLM-4-Flash Integration**: Умный ИИ-помощник для изучения языков
- ✅ Интерактивный чат-интерфейс в стиле современных мессенджеров
- ✅ Специализированные ответы для изучения языков
- ✅ Сохранение истории разговоров
- ✅ Обработка ошибок и подсказки
- ✅ Безопасное хранение API ключей

### 🎤 Движки распознавания речи

1. **Apple Speech Recognition**
   - ✅ Распознавание в реальном времени
   - ✅ Встроенный в macOS
   - ⚠️ Требует интернет-соединение
   - ⚠️ Ограничения по времени сессии

2. **WhisperKit**
   - ✅ Высокое качество распознавания
   - ✅ Полностью локальный (после загрузки модели)
   - ✅ Нативная Swift реализация
   - ✅ Оптимизирован для Apple Silicon
   - ✅ Автоматическая загрузка моделей
   - ⚠️ Обработка с задержкой (каждые 3 секунды)

## Установка и настройка

### 1. Настройка AI Chat

Для использования функции AI Chat вам понадобится API ключ от Zhipu AI:

1. Зарегистрируйтесь на [https://open.bigmodel.cn/](https://open.bigmodel.cn/)
2. Получите API ключ в разделе API Keys
3. В приложении нажмите на иконку ключа (🔑) в AI Chat
4. Введите ваш API ключ
5. Начните общаться с ИИ!

Подробная инструкция: [GLM_API_SETUP.md](GLM_API_SETUP.md)

### 2. Настройка BlackHole

1. Скачайте и установите [BlackHole](https://github.com/ExistentialAudio/BlackHole)
2. Откройте **System Settings** → **Sound**
3. Создайте **Multi-Output Device** в Audio MIDI Setup:
   - Откройте **Audio MIDI Setup** (Applications → Utilities)
   - Нажмите "+" → "Create Multi-Output Device"
   - Выберите ваши обычные динамики + BlackHole 2ch
4. Установите **Multi-Output Device** как **Output** в System Settings → Sound
5. Установите **BlackHole 2ch** как **Input** в System Settings → Sound

### 3. Настройка WhisperKit

WhisperKit - это нативная Swift реализация Whisper, которая не требует Python.

#### Добавление WhisperKit в Xcode

1. Откройте `Audio Study.xcodeproj` в Xcode
2. Выберите проект в навигаторе
3. Перейдите на вкладку "Package Dependencies"
4. Нажмите "+" для добавления пакета
5. Введите URL: `https://github.com/argmaxinc/WhisperKit.git`
6. Выберите версию 0.7.0 или новее
7. Нажмите "Add Package"

#### Активация WhisperKit

После добавления пакета:
1. Откройте `WhisperKitService.swift`
2. Раскомментируйте строку: `import WhisperKit`
3. Раскомментируйте свойство: `private var whisperKit: WhisperKit?`
4. Замените симуляцию на реальную реализацию (см. WHISPERKIT_SETUP.md)

#### Автоматическая загрузка моделей

- Модели загружаются автоматически при первом использовании
- По умолчанию используется `openai/whisper-tiny` (39MB)
- Модели кэшируются локально для последующего использования

### 4. Разрешения

Убедитесь, что приложению предоставлены следующие разрешения:
- **Microphone access** (для захвата аудио)
- **Speech Recognition** (для Apple Speech Recognition)

## Использование

### AI Chat
1. Откройте вкладку "AI Chat"
2. Нажмите на иконку ключа для настройки API (если не настроено)
3. Введите ваш GLM API ключ
4. Начните печатать сообщения и общайтесь с ИИ
5. ИИ поможет вам изучать язык, исправляя ошибки и давая советы

### Speech Recognition

1. Запустите приложение
2. Выберите движок распознавания:
   - **Apple Speech Recognition** - для реального времени
   - **WhisperKit** - для лучшего качества
3. Убедитесь, что статус показывает "Available"
4. Нажмите **Start Capture**
5. Воспроизведите аудио на вашем компьютере
6. Текст будет появляться в окне приложения

## Структура проекта

```
Audio Study/
├── Service/
│   ├── SpeechEngineType.swift      # Типы движков
│   ├── SpeechRecognizerService.swift # Apple Speech Recognition
│   ├── WhisperKitService.swift     # WhisperKit интеграция
│   ├── AudioCaptureService.swift   # Основной сервис
│   └── GLMChatService.swift        # GLM-4-Flash API сервис
├── View/
│   ├── AIChatView.swift            # AI Chat интерфейс
│   └── [другие представления]
├── ContentView.swift               # Главный UI
└── Audio_StudyApp.swift           # Entry point
```

## Технические детали

### Apple Speech Recognition
- Использует `SFSpeechRecognizer` и `SFSpeechAudioBufferRecognitionRequest`
- Обрабатывает аудио буферы в реальном времени
- Автоматически обновляет текст по мере распознавания

### WhisperKit
- Нативная Swift реализация Whisper
- Накапливает аудио буферы в течение 3 секунд
- Обрабатывает аудио напрямую в памяти
- Использует Metal Performance Shaders для ускорения
- Оптимизирован для Apple Silicon

### Управление аудио
- Использует `AVAudioEngine` для захвата аудио
- Устанавливает tap на input node для получения буферов
- Поддерживает различные аудио форматы
- Автоматически обрабатывает ошибки конфигурации

## Устранение неполадок

### Apple Speech Recognition
- **"Speech recognition not available"**: Проверьте интернет-соединение
- **Нет результатов**: Убедитесь, что микрофон работает
- **Прерывается через минуту**: Ограничение Apple, перезапустите захват

### MLX-Whisper
- **"MLX-Whisper not available"**: Установите Python и mlx-whisper
- **"Model not found"**: Проверьте путь к модели
- **Медленная обработка**: Используйте меньшую модель (tiny/base)
- **Ошибки Python**: Проверьте версию Python (требуется 3.8+)

### BlackHole
- **"No audio input device"**: Проверьте настройки BlackHole
- **Нет звука**: Убедитесь, что Multi-Output Device настроен правильно
- **Эхо**: Отключите мониторинг входа в Audio MIDI Setup

## Производительность

### Модели WhisperKit
- **tiny** (39MB): ~100ms, базовое качество
- **base** (74MB): ~200ms, хорошее качество
- **small** (244MB): ~500ms, отличное качество
- **medium** (769MB): ~1-2s, очень хорошее качество
- **large** (1.5GB): ~2-3s, лучшее качество

### Рекомендации
- Для реального времени: используйте Apple Speech Recognition
- Для лучшего качества: используйте WhisperKit с моделью tiny/base
- Для максимального качества: используйте WhisperKit с моделью small/medium

## Лицензия

MIT License