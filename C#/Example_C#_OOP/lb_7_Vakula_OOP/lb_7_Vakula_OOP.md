**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1. Наследование интерфейсов. Разрешение коллизии имен.**

На основании предметной области одной из предыдущих лабораторных работ (по выбору) спроектировать указанное наследование классов и интерфейсов.

Каждый интерфейс должны содержать несколько методов или свойств.

Примеры методов:

• метод, который выводит на экран информацию об объекте класса (Print),

• метод, который каким-либо образом изменяет числовые поля класса
(например, умножает на 2.7) и выводит поле (Mult),

• метод, который каким-либо образом изменяет текстовые поля класса
(например, поднимает регистр) и выводит поле (Up).

Коллизия имен

Должна присутствовать коллизия имен.

Продемонстрировать все способы решения коллизии имен в классе, наследующем оба интерфейса

• склеивание (комментируйте)

• явное указание интерфейса (кастинг) (комментируйте)

• переименование (кастинг + обертывание) (комментируйте)

Примечание. Комментируйте все выполненные задания для демонстрации преподавателю.

```csharp
using System;

// Интерфейс 1
public interface Interface1
{
    void Print();
    void Mult();
}

// Интерфейс 2
public interface Interface2
{
    void Print();
    void Up();
}

// Класс 1, реализующий Interface1
public class Class1 : Interface1
{
    public int NumberField { get; set; }
    public string TextField { get; set; }

    public void Print()
    {
        Console.WriteLine($"Class1: NumberField = {NumberField}, TextField = {TextField}");
    }

    public void Mult()
    {
        NumberField *= 2;
        Console.WriteLine($"Class1: NumberField after Mult = {NumberField}");
    }
}

// Класс 2, реализующий Interface2
public class Class2 : Interface2
{
    public int NumberField { get; set; }
    public string TextField { get; set; }

    public void Print()
    {
        Console.WriteLine($"Class2: NumberField = {NumberField}, TextField = {TextField}");
    }

    public void Up()
    {
        TextField = TextField.ToUpper();
        Console.WriteLine($"Class2: TextField after Up = {TextField}");
    }
}

// Класс, наследующий оба интерфейса
public class DerivedClass : Class1, Interface2
{
    // Решение коллизии имен
    // Склеивание
    void Interface2.Print()
    {
        Console.WriteLine($"DerivedClass: NumberField = {NumberField}, TextField = {TextField} (Printing from Interface2)");
    }

    // Явное указание интерфейса (кастинг)
    void Interface1.Mult()
    {
        Console.WriteLine($"DerivedClass: NumberField = {NumberField} (Multiplying from Interface1)");
    }

    // Переименование (кастинг + обертывание)
    void Interface2.Up()
    {
        Console.WriteLine($"DerivedClass: TextField = {TextField} (Uppercasing from Interface2)");
    }
}

class Program
{
    static void Main()
    {
        // Пример использования классов и интерфейсов
        DerivedClass derivedObj = new DerivedClass();
        derivedObj.NumberField = 5;
        derivedObj.TextField = "abc";

        // Вызов методов
        ((Interface1)derivedObj).Print(); // Явное указание интерфейса (Interface1)
        ((Interface2)derivedObj).Print(); // Явное указание интерфейса (Interface2)
        ((Interface1)derivedObj).Mult();  // Склеивание (Interface1)
        ((Interface2)derivedObj).Up();    // Переименование (Interface2)

        Console.ReadLine();
    }
}
```

**Задание 2. Работа с массивом**

Создать массив типа Interface2. Заполнить массив объектами различных классов.

Организовать цикл по всем элементам массива. Для всех элементов, поддерживающих Interface1, вызвать метод из этого интерфейса.

```csharp
class Program
{
    static void Main()
    {
        // Создаем массив типа Interface2
        Interface2[] array = new Interface2[]
        {
            new Class1 { NumberField = 1, TextField = "abc" },
            new Class2 { NumberField = 2, TextField = "def" },
            new DerivedClass { NumberField = 3, TextField = "ghi" }
        };

        // Организуем цикл по всем элементам массива
        foreach (var element in array)
        {
            // Проверяем, поддерживает ли элемент Interface1
            if (element is Interface1)
            {
                // Вызываем метод из Interface1
                ((Interface1)element).Print();
            }
        }

        Console.ReadLine();
    }
}
```

**Задание 3. Использование стандартных интерфейсов.**

Создать массив типа Class1. Организовать сортировку массива, используя
стандартный метод Sort.Array и интерфейс IComparable. Ключ сортировки – поле name из родительского класса (Class1).

Организовать сортировку, используя интерфейс IComparer. Создать 2 различных компаратора (по другим полям Class1), продемонстрировать работу.

Примечание. У вас должно быть реализовано 3 различных способа сортировки для одного и того же массива

```csharp
using System;

class Class1 : Interface1, IComparable<Class1>
{
    public int NumberField { get; set; }
    public string TextField { get; set; }

    public void Print()
    {
        Console.WriteLine($"NumberField: {NumberField}, TextField: {TextField}");
    }

    public int CompareTo(Class1 other)
    {
        // Сортировка по полю name
        return string.Compare(TextField, other.TextField, StringComparison.Ordinal);
    }
}

class CustomComparator1 : IComparer<Class1>
{
    public int Compare(Class1 x, Class1 y)
    {
        // Сортировка по полю NumberField
        return x.NumberField.CompareTo(y.NumberField);
    }
}

class CustomComparator2 : IComparer<Class1>
{
    public int Compare(Class1 x, Class1 y)
    {
        // Сортировка по полю TextField
        return string.Compare(x.TextField, y.TextField, StringComparison.Ordinal);
    }
}

class Program
{
    static void Main()
    {
        Class1[] array = new Class1[]
        {
            new Class1 { NumberField = 3, TextField = "C" },
            new Class1 { NumberField = 1, TextField = "A" },
            new Class1 { NumberField = 2, TextField = "B" }
        };

        // Сортировка с использованием IComparable
        Array.Sort(array);
        Console.WriteLine("Sorted by IComparable:");
        foreach (var element in array)
        {
            element.Print();
        }

        // Сортировка с использованием CustomComparator1
        Array.Sort(array, new CustomComparator1());
        Console.WriteLine("\nSorted by CustomComparator1:");
        foreach (var element in array)
        {
            element.Print();
        }

        // Сортировка с использованием CustomComparator2
        Array.Sort(array, new CustomComparator2());
        Console.WriteLine("\nSorted by CustomComparator2:");
        foreach (var element in array)
        {
            element.Print();
        }

        Console.ReadLine();
    }
}
```
