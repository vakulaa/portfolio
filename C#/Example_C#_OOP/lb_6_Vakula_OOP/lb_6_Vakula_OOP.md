**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1. Делегаты.**

Лабораторная работа выполняется на основе класса, созданного в первой

лабораторной работе.

Обязательно проверяйте делегаты на null!

Все типы делегатов объявляйте в общем пространстве имен, вне классов.

\1) Делегат без параметров\.

a) Добавить к классу поле типа делегат (private).

b) Добавить к классу метод, который заполняет поле типа делегат.

c) Добавьте к классу метод, который запускает делегат, лежащий в поле.

d) В Program создайте объекты, вызывающие данный метод. В качестве параметра передайте подходящий статический метод из Program (сделайте различные варианты разговора). Используйте анонимные делегаты и лямбда-выражения.

e) Создайте групповой делегат.

f) Сделайте объект, использующий групповой делегат (питомца, который говорит всеми возможными способами)

g) Добавьте к классу метод, который сравнивает эти поля в разных объектах.

(Сравните 2-х питомцев – они разговаривают одинаково или нет).

\2) Делегат с параметрами

a) Добавьте к классу делегат с параметром. Например, вы можете задать различные способы набора веса питомцами – добавить аргумент, умножить на аргумент и т.д.

Используйте анонимные делегаты и лямбда-выражения.

b) Аналогично первому заданию создайте метод и вызовите его из Program.

(Групповой делегат делать не нужно)

\3) События

a) Добавьте к классу событие – например, достижение питомцем определенного веса

или возраста.

b) Добавьте классы – обработчики события. (Эти классы могут содержать по 1 методу). Например, в одном классе методы сообщают о недомогании от

переедания или старости, во втором эти события приводят к смерти.

c) Добавьте аксессоры (add/remove) для добавления и удаления обработчиков.

Добавим делегаты в общем пространстве имен:

```csharp
using System;

public delegate void TalkDelegate(string message);

public class Person
{
    private TalkDelegate talkDelegate; // Поле делегата

    public void SetTalkDelegate(TalkDelegate talkDelegate)
    {
        this.talkDelegate = talkDelegate;
    }

    public void Talk()
    {
        // Проверка на null для безопасного вызова делегата
        talkDelegate?.Invoke("Hello, I can talk!");
    }

    public void CompareTalkDelegate(Person otherPerson)
    {
        // Сравнение делегатов в разных объектах
        bool areDelegatesEqual = this.talkDelegate == otherPerson.talkDelegate;
        Console.WriteLine($"Are talk delegates equal? {areDelegatesEqual}");
    }
}

class Program
{
    static void Main()
    {
        // a) Пример делегата без параметров
        TalkDelegate simpleTalkDelegate = SimpleTalkMethod;

        // b) Добавление делегата к полю в классе Person
        Person person1 = new Person();
        person1.SetTalkDelegate(simpleTalkDelegate);

        // c) Вызов метода, который запускает делегат
        person1.Talk();

        // d) Примеры создания объектов с использованием анонимных делегатов и лямбда-выражений
        TalkDelegate anonymousDelegate = delegate (string message) { Console.WriteLine(message); };
        TalkDelegate lambdaDelegate = message => Console.WriteLine(message);

        Person person2 = new Person();
        person2.SetTalkDelegate(anonymousDelegate);

        Person person3 = new Person();
        person3.SetTalkDelegate(lambdaDelegate);

        // e) Групповой делегат
        TalkDelegate groupDelegate = simpleTalkDelegate + anonymousDelegate + lambdaDelegate;

        Person person4 = new Person();
        person4.SetTalkDelegate(groupDelegate);

        // f) Объект, использующий групповой делегат
        Person person5 = new Person();
        person5.SetTalkDelegate(groupDelegate);

        // g) Сравнение полей с делегатами в разных объектах
        person1.CompareTalkDelegate(person2);

        // 2) Делегат с параметром
        // a) Добавление делегата с параметром
        Action<int> weightDelegate = weight => Console.WriteLine($"Weight: {weight}");

        // b) Вызов метода с использованием делегата с параметром
        person1.TalkAboutWeight(weightDelegate);

        // 3) Событие
        // a) Добавление события
        person1.WeightReached += WeightReachedHandler;

        // b) Вызов события
        person1.RaiseWeightEvent(80);
    }

    // Метод для делегата без параметров
    static void SimpleTalkMethod(string message)
    {
        Console.WriteLine(message);
    }

    // Обработчик события
    static void WeightReachedHandler(object sender, int weight)
    {
        Console.WriteLine($"Weight reached: {weight}");
    }
}
```

Задание 2. События.

Добавить 2 события – с параметрами и без параметров.

Создать несколько объектов класса и назначить им различные обработчики событий:

• Статический метод любого класса

• Экземплярный метод собственного класса

• Анонимный делегат

• Лямбда-выражение

```csharp
using System;

public class Person
{
    // Событие без параметров
    public event EventHandler SimpleEvent;

    // Событие с параметрами
    public event EventHandler<string> ParameterizedEvent;

    public void TriggerSimpleEvent()
    {
        // Проверка на null для безопасного вызова события
        SimpleEvent?.Invoke(this, EventArgs.Empty);
    }

    public void TriggerParameterizedEvent(string message)
    {
        // Проверка на null для безопасного вызова события
        ParameterizedEvent?.Invoke(this, message);
    }
}

class Program
{
    static void Main()
    {
        // Создание объектов класса Person
        Person person1 = new Person();
        Person person2 = new Person();
        Person person3 = new Person();

        // Назначение обработчиков событий
        // 1. Статический метод любого класса
        person1.SimpleEvent += StaticMethodHandler;

        // 2. Экземплярный метод собственного класса
        person2.SimpleEvent += person2.InstanceMethodHandler;

        // 3. Анонимный делегат
        person3.SimpleEvent += delegate (object sender, EventArgs args)
        {
            Console.WriteLine("Anonymous delegate handler");
        };

        // 4. Лямбда-выражение
        person3.ParameterizedEvent += (sender, message) =>
        {
            Console.WriteLine($"Lambda expression handler: {message}");
        };

        // Вызов методов, вызывающих события
        person1.TriggerSimpleEvent();
        person2.TriggerSimpleEvent();
        person3.TriggerSimpleEvent();
        person3.TriggerParameterizedEvent("Hello from Lambda");

        Console.ReadLine();
    }

    // Обработчик события - статический метод любого класса
    static void StaticMethodHandler(object sender, EventArgs args)
    {
        Console.WriteLine("Static method handler");
    }
}

public static class ExtensionMethods
{
    // Метод-расширение - статический метод любого класса
    public static void StaticExtensionMethod(this object obj, EventArgs args)
    {
        Console.WriteLine("Static extension method");
    }
}

public static class AnotherClass
{
    // Еще один статический метод для демонстрации
    public static void AnotherStaticMethod(object sender, EventArgs args)
    {
        Console.WriteLine("Another static method");
    }
}
```
