#!/bin/bash

echo "=========================================="
echo "Тестирование X-Forwarded-For через цепочку nginx"
echo "=========================================="

echo ""
echo "1. Прямой запрос через nginx1 > приложение"
echo "----------------------------------------"
curl -s http://localhost:8091/direct | python3 -m json.tool

echo ""
echo "2. Короткая цепочка: nginx1 > nginx2 > приложение"
echo "----------------------------------------"
curl -s http://localhost:8091/chain2 | python3 -m json.tool

echo ""
echo "3. Длинная цепочка: nginx1 > nginx2 > nginx3 > приложение"
echo "----------------------------------------"
curl -s http://localhost:8091/chain1 | python3 -m json.tool

echo ""
echo "4. Запрос с поддельным X-Forwarded-For от клиента"
echo "----------------------------------------"
curl -s -H "X-Forwarded-For: 1.2.3.4" http://localhost:8091/direct | python3 -m json.tool

echo ""
echo "5. Запрос через nginx2 > nginx3 > приложение"
echo "----------------------------------------"
curl -s http://localhost:8092/ | python3 -m json.tool

echo ""
echo "6. Запрос через nginx3 напрямую к приложению"
echo "----------------------------------------"
# Напрямую к nginx3 не можем (нет порта), но можем через nginx2
curl -s http://localhost:8092/ | python3 -m json.tool

echo ""
echo "=========================================="
echo "Тестирование завершено"
echo "=========================================="
