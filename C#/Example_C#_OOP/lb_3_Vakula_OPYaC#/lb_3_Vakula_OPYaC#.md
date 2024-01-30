**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1.**

Спроектировать класс согласно варианту индивидуального задания. Для класса
использовать отдельный модуль.

В вашем классе

• Предусмотреть у класса наличие полей, методов и свойств. Названия членов класса
должны быть осмысленны.

• Для всех нетекстовых полей разработать свойства, контролирующие корректность
значения (например, оценка – от 0 до 10). Одно из свойств (имя объекта) должно
быть только для чтения с инициализацией в конструкторе. Поля, связанные со
свойствами, должны быть инкапсулированы.

• Разработать несколько конструкторов класса (не менее 3). Один – без аргументов, с
заполнением полей значением по умолчанию, второй – с полным набором
аргументов и третий с частичным набором аргументов. Связать конструкторы в
цепочку, дабы избежать дублирования кода. Для проверки корректности аргументов
в конструкторах использовать свойство.

• Переопределить метод ToString()для отображения всех полей класса.

• Разработать указанные для вашего варианты методы.

• Создать автоматическую диаграмму спроектированного класса.

В методе main()

• Создать несколько объектов класса. Продемонстрировать использование всех
конструкторов.

• Продемонстрировать работу всех методов.

• Продемонстрировать использование всех свойств – для получения и присваивания
значения.

• Создать еще одну переменную, присвоив ей один из предыдущих объектов.

Продемонстрировать, что две переменные ссылаются на один объект (поменять поле
в одном объекте и вывести его в другом).

Индивидуальные задания по вариантам:

3\. Класс «Самолет».

Поля:

a. номер борта,
b. номер рейса,
c. мощность двигателей (массив, в процентах),
d. потребление горючего при 100% мощности 1 двигателем за 1 час,
e. общий объем горючего,
f. скорость,
g. высота.

Методы:

a. ToString(),

b. метод, определяющий потребление горючего в данном режиме полета
всеми двигателями,

c. метод, определяющий сбой двигателя (если мощность ниже 50%,
скорость и высота падают пропорционально мощности)

d. метод, определяющий более быстрый самолет из двух (возвращает true,
если скорость текущего выше)

e. статический метод, определяющий более быстрый самолет из трех
(возвращает объект, чья скорость выше)

```csharp
using System;

class Airplane
{
    // Поля класса
    private string registrationNumber;
    private string flightNumber;
    private int[] enginePower; // в процентах
    private double fuelConsumptionAtFullPower; // за 1 час одним двигателем
    private double totalFuelVolume;
    private double speed;
    private double altitude;

    // Свойства класса
    public string RegistrationNumber => registrationNumber; // Только для чтения
    public string FlightNumber
    {
        get { return flightNumber; }
        set
        {
            // Проверка корректности значения
            if (!string.IsNullOrEmpty(value))
                flightNumber = value;
        }
    }
    public int[] EnginePower
    {
        get { return enginePower; }
        set
        {
            // Проверка корректности значений
            if (value != null && value.Length > 0)
                enginePower = value;
        }
    }
    public double FuelConsumptionAtFullPower
    {
        get { return fuelConsumptionAtFullPower; }
        set
        {
            // Проверка корректности значения
            if (value >= 0)
                fuelConsumptionAtFullPower = value;
        }
    }
    public double TotalFuelVolume
    {
        get { return totalFuelVolume; }
        set
        {
            // Проверка корректности значения
            if (value >= 0)
                totalFuelVolume = value;
        }
    }
    public double Speed
    {
        get { return speed; }
        set
        {
            // Проверка корректности значения
            if (value >= 0)
                speed = value;
        }
    }
    public double Altitude
    {
        get { return altitude; }
        set
        {
            // Проверка корректности значения
            if (value >= 0)
                altitude = value;
        }
    }

    // Конструкторы класса
    public Airplane()
    {
        // Конструктор без аргументов
        registrationNumber = "DefaultRegistrationNumber";
        flightNumber = "DefaultFlightNumber";
        enginePower = new int[] { 100, 100, 100 }; // Три двигателя
        fuelConsumptionAtFullPower = 10.0; // Пример значения
        totalFuelVolume = 10000.0; // Пример значения
        speed = 800.0; // Пример значения
        altitude = 10000.0; // Пример значения
    }

    public Airplane(string registrationNumber, string flightNumber, int[] enginePower,
                    double fuelConsumptionAtFullPower, double totalFuelVolume,
                    double speed, double altitude)
    {
        // Конструктор с полным набором аргументов
        this.registrationNumber = registrationNumber;
        FlightNumber = flightNumber; // Используем свойство для проверки корректности
        EnginePower = enginePower; // Используем свойство для проверки корректности
        FuelConsumptionAtFullPower = fuelConsumptionAtFullPower; // Используем свойство для проверки корректности
        TotalFuelVolume = totalFuelVolume; // Используем свойство для проверки корректности
        Speed = speed; // Используем свойство для проверки корректности
        Altitude = altitude; // Используем свойство для проверки корректности
    }

    public Airplane(string registrationNumber, string flightNumber, double totalFuelVolume,
                    double speed, double altitude)
        : this(registrationNumber, flightNumber, new int[] { 100, 100, 100 },
               10.0, totalFuelVolume, speed, altitude)
    {
        // Конструктор с частичным набором аргументов
    }

    // Методы класса
    public override string ToString()
    {
        // Переопределение метода ToString()
        return $"Airplane ({registrationNumber}): {flightNumber}, Speed: {speed} km/h, Altitude: {altitude} m";
    }

    public double CalculateFuelConsumption()
    {
        // Метод определяющий потребление горючего в данном режиме полета всеми двигателями
        double totalConsumption = 0;
        foreach (int power in enginePower)
        {
            totalConsumption += (power / 100.0) * fuelConsumptionAtFullPower;
        }
        return totalConsumption;
    }

    public bool EngineFailure()
    {
        // Метод определяющий сбой двигателя
        if (enginePower[0] < 50)
        {
            // Если мощность ниже 50%, скорость и высота падают пропорционально мощности
            double reductionFactor = enginePower[0] / 50.0;
            speed *= reductionFactor;
            altitude *= reductionFactor;
            return true; // Сбой двигателя
        }
        return false; // Двигатель работает нормально
    }

    public bool IsFasterThan(Airplane other)
    {
        // Метод определяющий более быстрый самолет из двух
        return speed > other.speed;
    }

    public static Airplane FasterAirplane(Airplane first, Airplane second)
    {
        // Статический метод определяющий более быстрый самолет из двух
        return first.speed > second.speed ? first : second;
    }
}

class Program
{
    static void Main()
    {
        // Создаем объекты класса Airplane, демонстрируем использование конструкторов
        Airplane plane1 = new Airplane();
        Airplane plane2 = new Airplane("AB123", "FL123", new int[] { 90, 95, 80 }, 8.0, 8000.0, 750.0, 9000.0);
        Airplane plane3 = new Airplane("CD456", "FL456", 12000.0, 900.0, 12000.0);

        // Продемонстрируем работу методов
        Console.WriteLine("Plane 1: " + plane1);
        Console.WriteLine("Fuel Consumption of Plane 2: " + plane2.CalculateFuelConsumption() + " liters/hour");
        Console.WriteLine("Engine Failure on Plane 3: " + plane3.EngineFailure());
        Console.WriteLine("Is Plane 2 Faster Than Plane 1? " + plane2.IsFasterThan(plane1));
        Console.WriteLine("Faster Airplane: " + Airplane.FasterAirplane(plane1, plane2));

        // Продемонстрируем использование свойств
        Console.WriteLine("Flight Number of Plane 1: " + plane1.FlightNumber);
        plane1.FlightNumber = "FL999"; // Изменение значения через свойство
        Console.WriteLine("New Flight Number of Plane 1: " + plane1.FlightNumber);

        // Создаем еще одну переменную, присваиваем ей один из предыдущих объектов
        Airplane plane4 = plane2;

        // Продемонстрируем, что две переменные ссылаются на один объект
        plane2.Speed = 800.0; // Изменение значения через одну переменную
        Console.WriteLine("Speed of Plane 4: " + plane4.Speed); // Вывод значения через другую переменную
    }
}
```

![](Aspose.Words.e2844d7a-2a85-4456-a4b6-ec940f231dc5.001.png)
