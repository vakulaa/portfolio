**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1. Перегрузка операций.**

Спроектировать класс согласно варианту индивидуального задания. Для класса использовать отдельный модуль.

Спроектировать конструкторы и свойства с контролем корректности вводимых значений.

Перегрузить метод ToString().

Добавить индексирование для получения полей класса.

Перегрузить операции:

a) математические (имеющие смысл для объектов класса)

b) инкремент и декремент (изменить поля на 1)

c) отношения (==, !=, <, >)

d) true и false

e) преобразования типа

В методе main()

• Создать несколько объектов класса. Продемонстрировать использование

конструкторов и свойств.

• Продемонстрировать работу всех методов и операций.

Индивидуальные задания по вариантам:

3\. Класс interval (интервал). Поля – double (2 границы). Добавить метод вычисления длины. Перегрузить +, -, \* (пересечение) – проверить возможность выполнения операции. ++ и -- - расширение и сужение интервала. Сравнивать по длине. (d) если длина интервала = 0, интервал = false. Преобразовать интервал в double явно (длина), назад – также явно.

```csharp
public class Interval
{
    private double lowerBound;
    private double upperBound;

    // Конструкторы с контролем корректности вводимых значений
    public Interval(double lower, double upper)
    {
        if (lower > upper)
            throw new ArgumentException("Lower bound cannot be greater than upper bound.");

        lowerBound = lower;
        upperBound = upper;
    }

    // Свойства с контролем корректности вводимых значений
    public double LowerBound
    {
        get { return lowerBound; }
        set
        {
            if (value > upperBound)
                throw new ArgumentException("Lower bound cannot be greater than upper bound.");

            lowerBound = value;
        }
    }

    public double UpperBound
    {
        get { return upperBound; }
        set
        {
            if (value < lowerBound)
                throw new ArgumentException("Upper bound cannot be less than lower bound.");

            upperBound = value;
        }
    }

    // Метод для вычисления длины интервала
    public double CalculateLength()
    {
        return upperBound - lowerBound;
    }

    // Перегрузка метода ToString()
    public override string ToString()
    {
        return $"Interval: [{lowerBound}, {upperBound}]";
    }

    // Индексирование для получения полей класса
    public double this[int index]
    {
        get
        {
            if (index == 0)
                return lowerBound;
            else if (index == 1)
                return upperBound;
            else
                throw new IndexOutOfRangeException("Index should be 0 or 1.");
        }
        set
        {
            if (index == 0)
                LowerBound = value;
            else if (index == 1)
                UpperBound = value;
            else
                throw new IndexOutOfRangeException("Index should be 0 or 1.");
        }
    }

    // Перегрузка математических операций
    public static Interval operator +(Interval interval1, Interval interval2)
    {
        return new Interval(interval1.LowerBound + interval2.LowerBound, interval1.UpperBound + interval2.UpperBound);
    }

    public static Interval operator -(Interval interval1, Interval interval2)
    {
        return new Interval(interval1.LowerBound - interval2.UpperBound, interval1.UpperBound - interval2.LowerBound);
    }

    public static Interval operator *(Interval interval1, Interval interval2)
    {
        // Пересечение интервалов
        double newLower = Math.Max(interval1.LowerBound, interval2.LowerBound);
        double newUpper = Math.Min(interval1.UpperBound, interval2.UpperBound);

        // Проверка возможности выполнения операции
        if (newLower > newUpper)
            throw new InvalidOperationException("The intervals do not intersect.");

        return new Interval(newLower, newUpper);
    }

    // Перегрузка инкремента и декремента
    public static Interval operator ++(Interval interval)
    {
        return new Interval(interval.LowerBound + 1, interval.UpperBound + 1);
    }

    public static Interval operator --(Interval interval)
    {
        return new Interval(interval.LowerBound - 1, interval.UpperBound - 1);
    }

    // Перегрузка отношений
    public static bool operator ==(Interval interval1, Interval interval2)
    {
        return interval1.Equals(interval2);
    }

    public static bool operator !=(Interval interval1, Interval interval2)
    {
        return !interval1.Equals(interval2);
    }

    public static bool operator <(Interval interval1, Interval interval2)
    {
        return interval1.CalculateLength() < interval2.CalculateLength();
    }

    public static bool operator >(Interval interval1, Interval interval2)
    {
        return interval1.CalculateLength() > interval2.CalculateLength();
    }

    // Перегрузка true и false
    public static bool operator true(Interval interval)
    {
        return interval.CalculateLength() > 0;
    }

    public static bool operator false(Interval interval)
    {
        return interval.CalculateLength() == 0;
    }

    // Преобразование типа в double
    public static explicit operator double(Interval interval)
    {
        return interval.CalculateLength();
    }

    // Преобразование double в Interval
    public static explicit operator Interval(double length)
    {
        return new Interval(0, length);
    }

    // Перегрузка GetHashCode() и Equals() для корректной работы операций сравнения
    public override int GetHashCode()
    {
        return HashCode.Combine(lowerBound, upperBound);
    }

    public override bool Equals(object obj)
    {
        if (obj == null || GetType() != obj.GetType())
            return false;

        Interval other = (Interval)obj;
        return lowerBound == other.lowerBound && upperBound == other.upperBound;
    }
}

class Program
{
    static void Main()
    {
        // Пример

 использования класса Interval
        Interval interval1 = new Interval(2, 5);
        Interval interval2 = new Interval(4, 7);

        // Продемонстрируем использование конструкторов и свойств
        Console.WriteLine("Initial Intervals:");
        Console.WriteLine(interval1);
        Console.WriteLine(interval2);
        Console.WriteLine();

        // Продемонстрируем математические операции
        Console.WriteLine("Mathematical Operations:");
        Console.WriteLine("Sum: " + (interval1 + interval2));
        Console.WriteLine("Difference: " + (interval1 - interval2));
        Console.WriteLine("Intersection: " + (interval1 * interval2));
        Console.WriteLine();

        // Продемонстрируем инкремент и декремент
        Console.WriteLine("Increment and Decrement:");
        Console.WriteLine("After Increment: " + ++interval1);
        Console.WriteLine("After Decrement: " + --interval2);
        Console.WriteLine();

        // Продемонстрируем отношения
        Console.WriteLine("Relational Operations:");
        Console.WriteLine("Are Intervals Equal? " + (interval1 == interval2));
        Console.WriteLine("Are Intervals Not Equal? " + (interval1 != interval2));
        Console.WriteLine("Is Interval1 Longer Than Interval2? " + (interval1 > interval2));
        Console.WriteLine("Is Interval1 Shorter Than Interval2? " + (interval1 < interval2));
        Console.WriteLine();

        // Продемонстрируем true и false
        Console.WriteLine("True and False Operations:");
        Console.WriteLine("Is Interval1 Non-Zero? " + (interval1 ? "Yes" : "No"));
        Console.WriteLine("Is Interval2 Zero? " + (interval2 ? "No" : "Yes"));
        Console.WriteLine();

        // Продемонстрируем преобразования типа
        Console.WriteLine("Type Conversions:");
        double length = (double)interval1;
        Console.WriteLine($"Length of Interval1: {length}");
        Interval newInterval = (Interval)5.0;
        Console.WriteLine("New Interval: " + newInterval);
    }
}
```


![](Aspose.Words.455c44af-f93d-4db1-a036-3f967d07f1d9.001.png)

**Задание 2. Каталоги и файлы**

Реализуйте консольное меню, которое выполняет следующие действия:

1 – устанавливает текущий диск/каталог

2 – выводит список всех каталогов в текущем (пронумерованный)

3 – выводит список всех файлов в текущем каталоге (пронумерованнный)

4 – выводит на экран содержимое указанного файла (по номеру)

5 – создает каталог в текущем

6 – удаляет каталог по номеру, если он пустой

7 – удаляет файлы с указанными номерами

8 – выводит список всех файлов с указанной датой создания (ищет в текущем
каталоге и подкаталогах)

9 – выводит список всех текстовых файлов, в которых содержится указанный текст
(ищет в текущем каталоге и подкаталогах)

0 – выход

Приложение должно быть универсальным – т.е. имена файлов и каталогов, текст, дата вводятся с клавиатуры.

Для демонстрации проекта подготовьте папку с вложенными папками и файлами, по пунктам 8 и 9 поиск должен возвращать несколько файлов.

```csharp
using System;
using System.IO;
using System.Linq;

class Program
{
    static string currentDirectory = Directory.GetCurrentDirectory();

    static void Main()
    {
        int choice;

        do
        {
            DisplayMenu();
            choice = GetUserChoice();

            switch (choice)
            {
                case 1:
                    SetCurrentDirectory();
                    break;
                case 2:
                    ListDirectories();
                    break;
                case 3:
                    ListFiles();
                    break;
                case 4:
                    DisplayFileContent();
                    break;
                case 5:
                    CreateDirectory();
                    break;
                case 6:
                    DeleteDirectory();
                    break;
                case 7:
                    DeleteFiles();
                    break;
                case 8:
                    ListFilesByCreationDate();
                    break;
                case 9:
                    SearchTextInFiles();
                    break;
            }

        } while (choice != 0);
    }

    static void DisplayMenu()
    {
        Console.WriteLine("Меню:");
        Console.WriteLine("1 - Установить текущий каталог");
        Console.WriteLine("2 - Список всех каталогов");
        Console.WriteLine("3 - Список всех файлов");
        Console.WriteLine("4 - Отобразить содержимое файла");
        Console.WriteLine("5 - Создать каталог");
        Console.WriteLine("6 - Удалить каталог");
        Console.WriteLine("7 - Удалить файлы");
        Console.WriteLine("8 - Список файлов по дате создания");
        Console.WriteLine("9 - Поиск текста в файлах");
        Console.WriteLine("0 - Выход");
    }

    static int GetUserChoice()
    {
        int choice;

        do
        {
            Console.Write("Введите свой выбор (0-9): ");
        } while (!int.TryParse(Console.ReadLine(), out choice) || choice < 0 || choice > 9);

        return choice;
    }

    static void SetCurrentDirectory()
    {
        Console.Write("Введите путь к текущему каталогу: ");
        string newPath = Console.ReadLine();

        if (Directory.Exists(newPath))
        {
            currentDirectory = newPath;
            Console.WriteLine($"Текущий каталог установлен на: {currentDirectory}");
        }
        else
        {
            Console.WriteLine("Неверный путь. Текущий каталог остается неизменным.");
        }
    }

    static void ListDirectories()
    {
        var directories = Directory.GetDirectories(currentDirectory);

        Console.WriteLine("Список каталогов:");

        for (int i = 0; i < directories.Length; i++)
        {
            Console.WriteLine($"{i + 1}. {Path.GetFileName(directories[i])}");
        }
    }

    static void ListFiles()
    {
        var files = Directory.GetFiles(currentDirectory);

        Console.WriteLine("Список файлов:");

        for (int i = 0; i < files.Length; i++)
        {
            Console.WriteLine($"{i + 1}. {Path.GetFileName(files[i])}");
        }
    }

    static void DisplayFileContent()
    {
        Console.Write("Введите номер файла для отображения его содержимого: ");

        if (int.TryParse(Console.ReadLine(), out int fileNumber))
        {
            var files = Directory.GetFiles(currentDirectory);

            if (fileNumber > 0 && fileNumber <= files.Length)
            {
                string selectedFile = files[fileNumber - 1];

                Console.WriteLine($"Содержание {Path.GetFileName(selectedFile)}:");
                Console.WriteLine(File.ReadAllText(selectedFile));
            }
            else
            {
                Console.WriteLine("Неверный номер файла.");
            }
        }
        else
        {
            Console.WriteLine("Неверный ввод.");
        }
    }

    static void CreateDirectory()
    {
        Console.Write("Введите имя нового каталога: ");
        string newDirectoryName = Console.ReadLine();
        string newDirectoryPath = Path.Combine(currentDirectory, newDirectoryName);

        if (!Directory.Exists(newDirectoryPath))
        {
            Directory.CreateDirectory(newDirectoryPath);
            Console.WriteLine($"Каталог '{newDirectoryName}' создан успешно.");
        }
        else
        {
            Console.WriteLine($"Каталог '{newDirectoryName}' уже существует.");
        }
    }

    static void DeleteDirectory()
    {
        ListDirectories();
        Console.Write("Введите номер каталога, который нужно удалить: ");

        if (int.TryParse(Console.ReadLine(), out int dirNumber))
        {
            var directories = Directory.GetDirectories(currentDirectory);

            if (dirNumber > 0 && dirNumber <= directories.Length)
            {
                string selectedDirectory = directories[dirNumber - 1];

                if (Directory.GetFiles(selectedDirectory).Length == 0)
                {
                    Directory.Delete(selectedDirectory);
                    Console.WriteLine($"Каталог '{Path.GetFileName(selectedDirectory)}' успешно удалено.");
                }
                else
                {
                    Console.WriteLine($"Каталог '{Path.GetFileName(selectedDirectory)}' не пуст. Невозможно удалить.");
                }
            }
            else
            {
                Console.WriteLine("Неверный номер каталога.");
            }
        }
        else
        {
            Console.WriteLine("Неверный Ввод.");
        }
    }

    static void DeleteFiles()
    {
        ListFiles();
        Console.Write("Введите номера файлов для удаления (через запятую): ");
        string[] fileNumbers = Console.ReadLine().Split(',');

        foreach (var fileNumber in fileNumbers)
        {
            if (int.TryParse(fileNumber, out int number))
            {
                var files = Directory.GetFiles(currentDirectory);

                if (number > 0 && number <= files.Length)
                {
                    string selectedFile = files[number - 1];
                    File.Delete(selectedFile);
                    Console.WriteLine($"Файл '{Path.GetFileName(selectedFile)}' успешно удалено.");
                }
                else
                {
                    Console.WriteLine($"Неверный номер файла: {number}");
                }
            }
            else
            {
                Console.WriteLine("Неверный ввод.");
                return;
            }
        }
    }

    static void ListFilesByCreationDate()
    {
        Console.Write("Введите дату создания для поиска (yyyy-mm-dd): ");

        if (DateTime.TryParse(Console.ReadLine(), out DateTime searchDate))
        {
            var files = Directory.GetFiles(currentDirectory, "*", SearchOption.AllDirectories)
                .Where(file => File.GetCreationTime(file).Date == searchDate.Date);

            Console.WriteLine($"Файлы, созданные на {searchDate.ToShortDateString()}:");

            foreach (var file in files)
            {
                Console.WriteLine(file);
            }
        }
        else
        {
            Console.WriteLine("Неверный формат даты.");
        }
    }

    static void SearchTextInFiles()
    {
        Console.Write("Введите текст для поиска в файлах: ");
        string searchText = Console.ReadLine();

        var textFiles = Directory.GetFiles(currentDirectory, "*.txt", SearchOption.AllDirectories)
            .Where(file => File.ReadAllText(file).Contains(searchText));

        Console.WriteLine($"Файлы, содержащие '{searchText}':");

        foreach (var file in textFiles)
        {
            Console.WriteLine(file);
        }
    }
}
```

![](Aspose.Words.455c44af-f93d-4db1-a036-3f967d07f1d9.002.png)

![](Aspose.Words.455c44af-f93d-4db1-a036-3f967d07f1d9.003.png)

Поиск введенной фразы в файле:

![](Aspose.Words.455c44af-f93d-4db1-a036-3f967d07f1d9.004.png)

![](Aspose.Words.455c44af-f93d-4db1-a036-3f967d07f1d9.005.png)

**Задание 3. Рефлексия. Сериализация.**

Используйте любой класс с наследованием от другого класса или интерфейса.

Добавьте статический метод, который запишет в текстовый файл всю информацию о типе вашего класса (рефлексия). Имя файла – параметр метода.

Добавьте экземплярный метод, который будет сохранять в бинарный файл всю информацию о текущем объекте. Имя файла – параметр метода.

Метод, который будет читать информацию из бинарного файла и возвращать готовый объект. Имя файла – параметр метода.

Добавьте методы, которые сериализуют и десериализуют объекты вашего класса.

Имя файла – параметр метода.

```csharp
using System;
using System.IO;
using System.Reflection;
using System.Runtime.Serialization.Formatters.Binary;
using System.Xml.Serialization;

public interface IPrintable
{
    void PrintInfo();
}

[Serializable]
public class Entity
{
    public int Id { get; set; }
}

[Serializable]
public class Person : Entity, IPrintable
{
    public string Name { get; set; }
    public int Age { get; set; }

    public Person()
    {
        // Default constructor
    }

    public Person(string name, int age)
    {
        Name = name;
        Age = age;
    }

    public void PrintInfo()
    {
        Console.WriteLine($"Name: {Name}, Age: {Age}, Id: {Id}");
    }

    public static void WriteTypeInfoToFile(string fileName)
    {
        Type type = typeof(Person);
        using (StreamWriter writer = new StreamWriter(fileName))
        {
            writer.WriteLine($"Type: {type.FullName}");
            writer.WriteLine($"Assembly: {type.Assembly.FullName}");
            writer.WriteLine($"Properties:");
            foreach (PropertyInfo prop in type.GetProperties())
            {
                writer.WriteLine($" - {prop.Name}: {prop.PropertyType.FullName}");
            }
        }
    }

    public void SaveToBinaryFile(string fileName)
    {
        using (FileStream stream = new FileStream(fileName, FileMode.Create))
        {
            BinaryFormatter formatter = new BinaryFormatter();
            formatter.Serialize(stream, this);
        }
    }

    public static Person LoadFromBinaryFile(string fileName)
    {
        using (FileStream stream = new FileStream(fileName, FileMode.Open))
        {
            BinaryFormatter formatter = new BinaryFormatter();
            return (Person)formatter.Deserialize(stream);
        }
    }

    public void SerializeXml(string fileName)
    {
        using (FileStream stream = new FileStream(fileName, FileMode.Create))
        {
            XmlSerializer serializer = new XmlSerializer(typeof(Person));
            serializer.Serialize(stream, this);
        }
    }

    public static Person DeserializeXml(string fileName)
    {
        using (FileStream stream = new FileStream(fileName, FileMode.Open))
        {
            XmlSerializer serializer = new XmlSerializer(typeof(Person));
            return (Person)serializer.Deserialize(stream);
        }
    }
}

class Program
{
    static void Main()
    {
        // Create an instance of Person
        Person person = new Person("John Doe", 30);
        person.Id = 1;

        // Call the methods for each task
        Person.WriteTypeInfoToFile("TypeInfo.txt");
        person.SaveToBinaryFile("PersonBinary.bin");
        Person loadedPerson = Person.LoadFromBinaryFile("PersonBinary.bin");

        // Display loaded person information
        Console.WriteLine("Loaded Person Information:");
        loadedPerson.PrintInfo();

        // Serialize and deserialize using XML
        person.SerializeXml("PersonXml.xml");
        Person deserializedPerson = Person.DeserializeXml("PersonXml.xml");

        // Display deserialized person information
        Console.WriteLine("Deserialized Person Information:");
        deserializedPerson.PrintInfo();
    }
}
```

![](Aspose.Words.455c44af-f93d-4db1-a036-3f967d07f1d9.006.png)
