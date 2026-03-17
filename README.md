# russia-direct

Кастомный `russia-direct.dat` со списком российских доменов для прямого доступа (bypass proxy).

## Файлы

- `domains.lst` — список доменов (редактировать здесь)
- `build.sh` — скрипт сборки `russia-direct.dat` из `domains.lst`
- `russia-direct.dat` — собранный файл для v2ray/xray

## Сборка

Требуется [Go](https://go.dev/dl/).

```bash
./build.sh
```

Скрипт клонирует [domain-list-community](https://github.com/v2fly/domain-list-community), генерирует список `russia-direct` из `domains.lst` и собирает `russia-direct.dat`.

## Использование

В конфиге xray/v2ray:

```json
{
  "type": "field",
  "domain": ["ext:russia-direct.dat:russia-direct"],
  "outboundTag": "direct"
}
```
