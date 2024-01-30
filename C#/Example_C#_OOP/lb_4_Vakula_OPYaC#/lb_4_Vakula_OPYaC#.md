**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1. Ассоциация.**

В задании требуется спроектировать 2 различных вида ассоциации: композицию и агрегацию.

Композиция. Предполагает создание вложенных объектов в конструкторе класса-контейнера. (Не стоит создавать продавцов вместе с магазином.) Если логически должна быть связь 1-∞, для композиции использовать массив.

Для главного класса-контейнера разработать несколько перегруженных конструкторов:

\1) без параметров,

\2) с параметрами для полей этого класса

\3) с параметрами для полей этого класса и подчиненного класса-композиции

Агрегация. Предполагает связь по ссылке. Ссылка может быть null.

Здесь возможны варианты:

a) Создать массив объектов в классе-контейнере (массив машин в гараже).

Изначально все ссылки null.

b) Вместо того, чтобы делать массив ссылок в главном классе, можно в каждом подчиненном объекте сделать ссылку на главный класс (например, каждая машина

имеет ссылку на свой гараж – эта ссылка может быть null).

c) То и другое – при добавлении машины к гаражу, в гараже меняется соответствующее место в массиве, у машины меняется ссылка на гараж.

Соответствующие методы должны быть в том и другом классе и каждый метод должен изменять объекты обоих классов.

Предусмотреть методы для регистрации подчиненного объекта (клиент прописывается в гостиницу, самолет запрашивает посадку и т.д.)

Спроектировать UML-диаграммы классов согласно варианту индивидуального задания. В каждом классе предусмотреть поля (2-4), конструкторы, свойства (2-4) и методы (1-2). Между парами классов спроектировать отношения – композицию и агрегацию. Причем для агрегации спроектируйте оба варианта связи: подчиненный класс имеет ссылку на главный, либо массив ссылок в главном классе (либо a и b, либо только

c). Продемонстрировать работу классов.

Из предложенной предметной области вы можете использовать все перечисленные объекты, либо часть (минимум – 3). Вы можете добавить свои объекты.

Индивидуальные задания по вариантам:

3\. Аэропорт – Взлетная полоса – Самолет – Диспетчер.

```csharp
uusing System;

// Класс Взлетная полоса
public class Runway
{
    public string Number { get; set; }

    public Runway(string number)
    {
        Number = number;
    }
}

// Класс Самолет
public class Airplane
{
    public string RegistrationNumber { get; set; }

    public Airplane(string registrationNumber)
    {
        RegistrationNumber = registrationNumber;
    }
}

// Класс Диспетчер
public class Dispatcher
{
    public string Name { get; set; }

    public Dispatcher(string name)
    {
        Name = name;
    }
}

// Класс Аэропорт
public class Airport
{
    private Runway runway; // Композиция
    private Airplane[] airplanes; // Агрегация
    private Dispatcher dispatcher; // Агрегация

    public string Name { get; set; }

    // Конструкторы
    public Airport()
    {
        Name = "DefaultAirport";
        runway = new Runway("01");
        airplanes = new Airplane[10]; // Пример массива ссылок
    }

    public Airport(string name)
    {
        Name = name;
        runway = new Runway("01");
        airplanes = new Airplane[10]; // Пример массива ссылок
    }

    public Airport(string name, Runway runway)
    {
        Name = name;
        this.runway = runway;
        airplanes = new Airplane[10]; // Пример массива ссылок
    }

    // Метод для добавления самолета
    public void AddAirplane(Airplane airplane)
    {
        for (int i = 0; i < airplanes.Length; i++)
        {
            if (airplanes[i] == null)
            {
                airplanes[i] = airplane;
                break;
            }
        }
    }

    // Метод для добавления диспетчера
    public void AddDispatcher(Dispatcher dispatcher)
    {
        this.dispatcher = dispatcher;
    }

    // Метод для вывода информации о состоянии аэропорта
    public void DisplayAirportStatus()
    {
        Console.WriteLine($"Airport: {Name}");
        Console.WriteLine($"Runway Number: {runway.Number}");
        Console.WriteLine("Airplanes:");
        foreach (var airplane in airplanes)
        {
            if (airplane != null)
                Console.WriteLine($"- {airplane.RegistrationNumber}");
        }
        Console.WriteLine($"Dispatcher: {dispatcher?.Name ?? "No Dispatcher"}");
    }
}

class Program
{
    static void Main()
    {
        // Создаем объекты
        Runway runway = new Runway("02");
        Airplane airplane1 = new Airplane("ABC123");
        Airplane airplane2 = new Airplane("XYZ789");
        Dispatcher dispatcher = new Dispatcher("John Doe");

        // Создаем объект аэропорт с использованием различных конструкторов
        Airport airport1 = new Airport();
        Airport airport2 = new Airport("International Airport");
        Airport airport3 = new Airport("Domestic Airport", runway);

        // Добавляем самолеты и диспетчера
        airport1.AddAirplane(airplane1);
        airport1.AddDispatcher(dispatcher);
        airport2.AddAirplane(airplane2);

        // Выводим информацию о состоянии аэропортов
        airport1.DisplayAirportStatus();
        Console.WriteLine();
        airport2.DisplayAirportStatus();
        Console.WriteLine();
        airport3.DisplayAirportStatus();
    }
}
```

![](Aspose.Words.5064f880-7b92-46ef-9a44-290736e2fd2b.001.png)

**Задание 2. Наследование.**

Выделить в предметной области 2-3 варианта сущности (например, "Геометрическая фигура", "Точка", "Треугольник"), отличающиеся несколькими полями и методами. Каждый класс имеет поля, свойства и методы.

Спроектировать UML-диаграммы классов.

Базовый класс для вашей иерархии объявите абстрактным. Он должен содержать абстрактные методы и методы с реализацией.

Один из наследников должен перегружать (скрывать) метод родителя.

Один из классов должен содержать виртуальный метод, который переопределяется в одном наследнике и не переопределяется в другом.

Продемонстрировать работу всех объявленных методов.

Продемонстрировать вызов конструктора родительского класса при наследовании.

Продемонстрировать вызов метода родительского класса при его скрытии.

Создать класс, закрытый для наследования.

Примеры методов: вывод полей класса, изменение числовых полей класса

(скорости, дохода, численности штата и т.д.), изменение текстовых полей класса (переименование), какая-либо динамика (полет, ремонт, переезд, открытие/закрытие и.д.)

Индивидуальные задания по вариантам (номер варианта выбирается по желанию)

3\. Транспорт

```csharp
using System;

// Абстрактный базовый класс Транспорт
public abstract class Transport
{
    // Поля базового класса
    protected string brand;
    protected double speed;

    // Свойства базового класса
    public string Brand
    {
        get { return brand; }
        set { brand = value; }
    }

    public double Speed
    {
        get { return speed; }
        set { speed = value; }
    }

    // Абстрактные методы базового класса
    public abstract void Move();
    public abstract void Stop();

    // Метод с реализацией
    public void DisplayInfo()
    {
        Console.WriteLine($"Brand: {brand}, Speed: {speed} km/h");
    }
}

// Наследник 1: Автомобиль
public class Car : Transport
{
    private int numberOfDoors;

    public int NumberOfDoors
    {
        get { return numberOfDoors; }
        set { numberOfDoors = value; }
    }

    // Конструктор наследника
    public Car(string brand, double speed, int doors)
    {
        this.brand = brand;
        this.speed = speed;
        numberOfDoors = doors;
    }

    // Переопределение метода базового класса
    public override void Move()
    {
        Console.WriteLine("The car is moving on the road.");
    }

    // Переопределение метода базового класса
    public override void Stop()
    {
        Console.WriteLine("The car has stopped.");
    }
}


public class Bicycle : Transport
{
    private bool hasBell;

    public bool HasBell
    {
        get { return hasBell; }
        set { hasBell = value; }
    }

    // Конструктор наследника
    public Bicycle(string brand, double speed, bool bell)
    {
        this.brand = brand;
        this.speed = speed;
        hasBell = bell;
    }

    // Переопределение метода базового класса
    public override void Move()
    {
        Console.WriteLine("The bicycle is pedaling on the road.");
    }

    // Переопределение метода базового класса
    public override void Stop()
    {
        Console.WriteLine("The bicycle has come to a stop.");
    }

    // Виртуальный метод
    public virtual void RingBell()
    {
        Console.WriteLine("Ding ding! The bell rings.");
    }
}

class Program
{
    static void Main()
    {
        // Пример использования классов
        Car car = new Car("Toyota", 60.0, 4);
        Bicycle bicycle = new Bicycle("Giant", 20.0, true);

        // Демонстрация работы методов
        car.DisplayInfo();
        car.Move();
        car.Stop();
        Console.WriteLine();

        bicycle.DisplayInfo();
        bicycle.Move();
        bicycle.Stop();
        bicycle.RingBell();
    }
}
```

![](Aspose.Words.5064f880-7b92-46ef-9a44-290736e2fd2b.002.png)
