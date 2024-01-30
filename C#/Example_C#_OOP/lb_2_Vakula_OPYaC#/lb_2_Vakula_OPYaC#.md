**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1. Работа с классом string.**

Написать метод, который получает строку, дополнительные данные (при необходимости) и возвращает результат. Не использовать регулярные выражения.

Индивидуальные задания по вариантам:

3\. подсчитать количество букв в строке;

```csharp
using System;

class Program
{
    static void Main()
    {
        // Ввод строки
        Console.WriteLine("Введите строку:");
        string inputString = Console.ReadLine();
        
        // Вызов метода и вывод результата
        int letterCount = CountLetters(inputString);
        Console.WriteLine($"Количество букв в строке: {letterCount}");
    }

    // Метод для подсчета количества букв в строке
    static int CountLetters(string inputString)
    {
        int letterCount = 0;
        
        foreach (char c in inputString)
        {
            // Проверка, является ли символ буквой
            if (char.IsLetter(c))
            {
                letterCount++;
            }
        }
        
        return letterCount;
    }
}
```


![](Aspose.Words.c8998d48-e115-4359-8459-7fbd48fca87d.001.png)

**Задание 2. Работа с классом StringBuilder.**

<a name="_hlk153038004"></a>Написать метод, который принимает несколько строк (использовать params). Для каждой строки выполнить индивидуальное задание (в цикле). Объединить строки в одну, используя разделитель ";" и уменьшить емкость буфера до реального размера полученной строки.

Метод возвращает размер буфера. Результирующая строка возвращается через параметр out.

Индивидуальные задания по вариантам:

3\. удалить среднюю букву, если длина строки нечетная, и две средних, если длина строки четная;

```csharp
using System;
using System.Text;

class Program
{
    static void Main()
    {
        // Ввод строк
        Console.WriteLine("Введите несколько строк через пробел:");
        string[] inputStrings = Console.ReadLine().Split();
        
        // Вызов метода и вывод результата
        StringBuilder resultStringBuilder;
        int bufferSize = ProcessStrings(inputStrings, out resultStringBuilder);
        Console.WriteLine($"Объединенная строка: {resultStringBuilder}");
        Console.WriteLine($"Размер буфера: {bufferSize}");
    }

    // Метод для обработки строк
    static int ProcessStrings(string[] inputStrings, out StringBuilder resultStringBuilder)
    {
        resultStringBuilder = new StringBuilder();
        
        foreach (string str in inputStrings)
        {
            // Удаление средних букв
            string processedString = RemoveMiddleLetters(str);
            
            // Добавление строки с разделителем ";"
            resultStringBuilder.Append(processedString).Append(";");
        }
        
        // Уменьшение емкости буфера до реального размера строки
        resultStringBuilder.Capacity = resultStringBuilder.Length;
        
        // Возвращаем размер буфера
        return resultStringBuilder.Capacity;
    }

    // Метод для удаления средних букв
    static string RemoveMiddleLetters(string str)
    {
        int length = str.Length;
        
        if (length % 2 == 0)
        {
            // Для четной длины удаляем две средних буквы
            return str.Remove(length / 2 - 1, 2);
        }
        else
        {
            // Для нечетной длины удаляем одну среднюю букву
            return str.Remove(length / 2, 1);
        }
    }
}
```

![](Aspose.Words.c8998d48-e115-4359-8459-7fbd48fca87d.002.png)

**Задание 3. Работа с регулярными выражениями.**

Написать метод, решающий поставленную задачу. Типы параметров и результата определить самостоятельно. Использовать регулярные выражения.

Индивидуальные задания по вариантам:

3\. Найти только те слова сообщения, которые содержат хотя бы одну цифру.

```csharp
using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Ввод сообщения
        Console.WriteLine("Введите сообщение:");
        string inputMessage = Console.ReadLine();
        
        // Вызов метода и вывод результата
        List<string> wordsWithDigits = FindWordsWithDigits(inputMessage);
        Console.WriteLine("Слова с хотя бы одной цифрой:");
        foreach (string word in wordsWithDigits)
        {
            Console.WriteLine(word);
        }
    }

    // Метод для поиска слов с хотя бы одной цифрой в сообщении
    static List<string> FindWordsWithDigits(string message)
    {
        List<string> result = new List<string>();
        // Регулярное выражение для поиска слов с хотя бы одной цифрой
        string pattern = @"\b\w*\d\w*\b";
        // Находим все совпадения
        MatchCollection matches = Regex.Matches(message, pattern);
        // Добавляем найденные слова в результат
        foreach (Match match in matches)
        {
            result.Add(match.Value);
        }
        return result;
    }
}
```


![](Aspose.Words.c8998d48-e115-4359-8459-7fbd48fca87d.003.png)

**Задание 4. Работа с временем и датой.**

Написать метод, решающий поставленную задачу.

Индивидуальные задания по вариантам:

3\. Входные данные – время (string). Выходные данные – количество секунд до текущего момента (int, возможно отрицательное).
```csharp
using System;

class Program
{
    static void Main()
    {
        // Ввод времени
        Console.WriteLine("Введите время в формате HH:mm:ss:");
        string inputTime = Console.ReadLine();
        
        // Вызов метода и вывод результата
        int secondsUntilNow = CalculateSecondsUntilNow(inputTime);
        Console.WriteLine($"Количество секунд до текущего момента: {secondsUntilNow} секунд");
    }

    // Метод для расчета количества секунд до текущего момента
    static int CalculateSecondsUntilNow(string inputTime)
    {
        DateTime inputDateTime;
        
        // Пытаемся преобразовать введенное время в объект DateTime
        if (DateTime.TryParse(inputTime, out inputDateTime))
        {
            // Получаем текущую дату и время
            DateTime currentDateTime = DateTime.Now;
            
            // Вычисляем разницу в секундах
            TimeSpan difference = currentDateTime - inputDateTime;
            
            // Возвращаем количество секунд (может быть отрицательным)
            return (int)difference.TotalSeconds;
        }
        else
        {
            Console.WriteLine("Ошибка в формате времени.");
            return 0;
        }
    }
}
```

![](Aspose.Words.c8998d48-e115-4359-8459-7fbd48fca87d.004.png)

