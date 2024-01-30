
**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1. Одномерный массив целых чисел.**

a) Ввести с клавиатуры размерность массива, минимальное и максимальное значение.

Создать одномерный массив и заполнить его случайными числами в диапазоне от минимального до максимального значения. Вывести полученный массив.

b) Выполнить индивидуальное задание (по вариантам). При необходимости запросить у пользователя дополнительные данные. Вывести преобразованный массив.

Индивидуальные задания по вариантам:

3\. Заменить все отрицательные элементы на противоположные.

```csharp
using System;

class Program
{
    static void Main()
    {
        // a) Ввод размерности массива, минимального и максимального значения
        Console.WriteLine("Введите размерность массива:");
        int size = int.Parse(Console.ReadLine());

        Console.WriteLine("Введите минимальное значение:");
        int min = int.Parse(Console.ReadLine());

        Console.WriteLine("Введите максимальное значение:");
        int max = int.Parse(Console.ReadLine());

        // b) Создание и заполнение массива случайными числами в заданном диапазоне
        int[] array = GenerateRandomArray(size, min, max);

        // Вывод исходного массива
        Console.WriteLine("Исходный массив:");
        PrintArray(array);

        // Выполнение индивидуального задания: Замена отрицательных элементов на противоположные
        ReplaceNegativeElements(array);

        // Вывод преобразованного массива
        Console.WriteLine("Преобразованный массив:");
        PrintArray(array);
    }

    // Метод для генерации массива случайных чисел
    static int[] GenerateRandomArray(int size, int min, int max)
    {
        Random random = new Random();
        int[] array = new int[size];

        for (int i = 0; i < size; i++)
        {
            array[i] = random.Next(min, max + 1);
        }

        return array;
    }

    // Метод для вывода массива на экран
    static void PrintArray(int[] array)
    {
        foreach (int element in array)
        {
            Console.Write(element + " ");
        }

        Console.WriteLine();
    }

    // Метод для замены отрицательных элементов на противоположные
    static void ReplaceNegativeElements(int[] array)
    {
        for (int i = 0; i < array.Length; i++)
        {
            if (array[i] < 0)
            {
                array[i] = -array[i];
            }
        }
    }
}
```

![](Aspose.Words.ff61c7d2-ee48-442b-91f7-902b03118e52.001.png)

Задание 2. Квадратный массив.

a) Ввести с клавиатуры размерность массива, минимальное и максимальное значение.

Создать квадратный массив и заполнить его случайными числами в диапазоне от минимального до максимального значения. Вывести полученный массив.

b) Выполнить индивидуальное задание. При необходимости запросить у пользователя необходимые данные. Вывести полученный результат.

Индивидуальные задания по вариантам:

3\. Подсчитать среднее арифметическое ненулевых элементов, расположенных над побочной диагональю.

```csharp
using System;

class Program
{
    static void Main()
    {
        // a) Ввод размерности квадратного массива, минимального и максимального значения
        Console.WriteLine("Введите размерность квадратного массива:");
        int size = int.Parse(Console.ReadLine());

        Console.WriteLine("Введите минимальное значение:");
        int min = int.Parse(Console.ReadLine());

        Console.WriteLine("Введите максимальное значение:");
        int max = int.Parse(Console.ReadLine());

        // b) Создание и заполнение квадратного массива случайными числами в заданном диапазоне
        int[,] array = GenerateRandomSquareArray(size, min, max);

        // Вывод исходного квадратного массива
        Console.WriteLine("Исходный квадратный массив:");
        PrintSquareArray(array);

        // Выполнение индивидуального задания: Подсчет среднего арифметического ненулевых элементов над побочной диагональю
        double average = CalculateAverageAboveSecondaryDiagonal(array);

        // Вывод результата индивидуального задания
        Console.WriteLine($"Среднее арифметическое ненулевых элементов над побочной диагональю: {average}");
    }

    // Метод для генерации квадратного массива случайных чисел
    static int[,] GenerateRandomSquareArray(int size, int min, int max)
    {
        Random random = new Random();
        int[,] array = new int[size, size];

        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                array[i, j] = random.Next(min, max + 1);
            }
        }

        return array;
    }

    // Метод для вывода квадратного массива на экран
    static void PrintSquareArray(int[,] array)
    {
        int size = array.GetLength(0);

        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                Console.Write(array[i, j] + " ");
            }
            Console.WriteLine();
        }
    }

    // Метод для подсчета среднего арифметического ненулевых элементов над побочной диагональю
    static double CalculateAverageAboveSecondaryDiagonal(int[,] array)
    {
        int size = array.GetLength(0);
        int count = 0;
        double sum = 0;

        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                if (i + j < size - 1 && array[i, j] != 0)
                {
                    sum += array[i, j];
                    count++;
                }
            }
        }

        return count > 0 ? sum / count : 0;
    }
}
```

![](Aspose.Words.ff61c7d2-ee48-442b-91f7-902b03118e52.002.png)

**Задание 3. Зубчатый массив**

a) Ввести с клавиатуры размерность массива n, минимальное и максимальное значение.

Создать зубчатый массив. Длина каждой строки выбирается случайным образом от 1 до n.

Заполнить массив случайными числами в диапазоне от минимального до максимального значения. Вывести полученный массив.

b) Выполнить индивидуальное задание. При необходимости запросить у пользователя необходимые данные. Вывести полученный результат.

Индивидуальные задания по вариантам:

3\. Нечетные строки таблицы заменить на вектор [1, 0, 1, 0...].

```csharp
using System;

class Program
{
    static void Main()
    {
        // a) Ввод размерности массива, минимального и максимального значения
        Console.WriteLine("Введите размерность массива n:");
        int n = int.Parse(Console.ReadLine());

        Console.WriteLine("Введите минимальное значение:");
        int min = int.Parse(Console.ReadLine());

        Console.WriteLine("Введите максимальное значение:");
        int max = int.Parse(Console.ReadLine());

        // b) Создание и заполнение зубчатого массива
        int[][] jaggedArray = GenerateJaggedArray(n, min, max);

        // Вывод исходного зубчатого массива
        Console.WriteLine("Исходный зубчатый массив:");
        PrintJaggedArray(jaggedArray);

        // Выполнение индивидуального задания: Замена нечетных строк на вектор [1, 0, 1, 0...]
        ReplaceOddRowsWithVector(jaggedArray);

        // Вывод результата индивидуального задания
        Console.WriteLine("Результат после замены нечетных строк:");
        PrintJaggedArray(jaggedArray);
    }

    // Метод для генерации зубчатого массива
    static int[][] GenerateJaggedArray(int n, int min, int max)
    {
        Random random = new Random();
        int[][] jaggedArray = new int[n][];

        for (int i = 0; i < n; i++)
        {
            int rowLength = random.Next(1, n + 1); // Длина строки от 1 до n
            jaggedArray[i] = new int[rowLength];

            for (int j = 0; j < rowLength; j++)
            {
                jaggedArray[i][j] = random.Next(min, max + 1);
            }
        }

        return jaggedArray;
    }

    // Метод для вывода зубчатого массива на экран
    static void PrintJaggedArray(int[][] jaggedArray)
    {
        foreach (var row in jaggedArray)
        {
            foreach (var element in row)
            {
                Console.Write(element + " ");
            }
            Console.WriteLine();
        }
    }

    // Метод для замены нечетных строк на вектор [1, 0, 1, 0...]
    static void ReplaceOddRowsWithVector(int[][] jaggedArray)
    {
        for (int i = 0; i < jaggedArray.Length; i += 2)
        {
            int rowLength = jaggedArray[i].Length;
            int[] vector = new int[rowLength];

            for (int j = 0; j < rowLength; j++)
            {
                vector[j] = j % 2 == 0 ? 1 : 0;
            }

            jaggedArray[i] = vector;
        }
    }
}
```

![](Aspose.Words.ff61c7d2-ee48-442b-91f7-902b03118e52.003.png)

**Задание 4. Методы**

Разработать указанный метод. Метод не должен выводить значения на консоль! Если в задании указано, что метод ВОЗВРАЩАЕТ определенный результат – имеется в виду return.

Продемонстрировать работу метода для всех возможных вариантов.

Индивидуальные задания по вариантам:

3\. Метод принимает вещественное число и массив. Заполняет массив указанным числом.

```csharp
using System;

class Program
{
    static void Main()
    {
        // Ввод вещественного числа
        Console.WriteLine("Введите вещественное число:");
        double number = double.Parse(Console.ReadLine());

        // Ввод массива
        Console.WriteLine("Введите элементы массива через пробел:");
        string[] inputArray = Console.ReadLine().Split();
        double[] array = new double[inputArray.Length];

        for (int i = 0; i < inputArray.Length; i++)
        {
            array[i] = double.Parse(inputArray[i]);
        }

        // Вызов метода и демонстрация результатов
        FillArrayWithNumber(array, number);

        // Вывод преобразованного массива
        Console.WriteLine("Преобразованный массив:");
        PrintArray(array);
    }

    // Метод для заполнения массива указанным числом
    static void FillArrayWithNumber(double[] array, double number)
    {
        for (int i = 0; i < array.Length; i++)
        {
            array[i] = number;
        }
    }

    // Метод для вывода массива на экран
    static void PrintArray(double[] array)
    {
        foreach (var element in array)
        {
            Console.Write(element + " ");
        }
        Console.WriteLine();
    }
}
```

![](Aspose.Words.ff61c7d2-ee48-442b-91f7-902b03118e52.004.png)

