# russia-direct

Кастомный `geosite.dat` со списком российских доменов для прямого доступа (bypass proxy).

## Файлы

- `domains.lst` — список доменов (редактировать здесь)
- `build.sh` — скрипт сборки `geosite.dat` из `domains.lst`
- `geosite.dat` — собранный файл для v2ray/xray

## Сборка

Требуется [Go](https://go.dev/dl/).

```bash
./build.sh
```

Скрипт клонирует [domain-list-community](https://github.com/v2fly/domain-list-community), удаляет все встроенные списки, генерирует единственный список `russia-direct` из `domains.lst` и собирает `geosite.dat`.

## Использование

В конфиге xray/v2ray:

```json
{
  "type": "field",
  "domain": ["ext:geosite.dat:russia-direct"],
  "outboundTag": "direct"
}
```
