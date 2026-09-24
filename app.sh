#!/bin/bash

DATA_FILE="data/notes.txt"

show_menu() {
    clear
   
    echo "       МЕНЕДЖЕР ЗАМЕТОК"
    echo "1. Добавить заметку"
    echo "2. Показать заметки"
    echo "3. Найти заметку"
    echo "4. Посчитать заметки"
    echo "5. Удалить заметку"
    echo "0. Выход"
    
}

add_note() {
    read -p "Введите текст заметки: " note

    if [ -z "$note" ]; then
        echo "Ошибка: заметка не может быть пустой."
    else
        echo "$note" >> "$DATA_FILE"
        echo "Заметка добавлена."
    fi

    read -p "Нажмите Enter для продолжения..."
}

show_notes() {
    echo
    echo "СПИСОК ЗАМЕТОК"

    if [ ! -s "$DATA_FILE" ]; then
        echo "Заметок пока нет."
    else
        nl -w2 -s". " "$DATA_FILE"
    fi

    echo
    read -p "Нажмите Enter для продолжения..."
}

search_note() {
    read -p "Введите слово для поиска: " keyword

    echo
    echo "РЕЗУЛЬТАТ ПОИСКА"

    if [ -z "$keyword" ]; then
        echo "Ошибка: поисковый запрос пуст."
    elif grep -in "$keyword" "$DATA_FILE"; then
        :
    else
        echo "Совпадений не найдено."
    fi

    echo
    read -p "Нажмите Enter для продолжения..."
}

count_notes() {
    count=$(wc -l < "$DATA_FILE")

    echo
    echo "КОЛИЧЕСТВО"
    echo "Всего заметок: $count"
    echo

    read -p "Нажмите Enter для продолжения..."
}

delete_note() {
    echo
    echo "УДАЛЕНИЕ"

    if [ ! -s "$DATA_FILE" ]; then
        echo "Заметок для удаления нет."
        read -p "Нажмите Enter для продолжения..."
        return
    fi

    nl -w2 -s". " "$DATA_FILE"

    read -p "Введите номер заметки для удаления: " number

    if [[ "$number" =~ ^[0-9]+$ ]] && [ "$number" -ge 1 ] && [ "$number" -le "$(wc -l < "$DATA_FILE")" ]; then
        sed -i "${number}d" "$DATA_FILE"
        echo "Заметка удалена."
    else
        echo "Ошибка: неверный номер."
    fi

    echo
    read -p "Нажмите Enter для продолжения..."
}

while true; do
    show_menu

    read -p "Выберите действие: " choice

    case "$choice" in
        1)
            add_note
            ;;
        2)
            show_notes
            ;;
        3)
            search_note
            ;;
        4)
            count_notes
            ;;
        5)
            delete_note
            ;;
        0)
            echo "Выход из программы."
            break
            ;;
        *)
            echo "Ошибка: выберите пункт от 0 до 5."
            read -p "Нажмите Enter для продолжения..."
            ;;
    esac
done
