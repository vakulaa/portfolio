**ВЫПОЛНЕНИЯ ЗАДАНИЯ**

**Задание 1.**

Реализовать предложенный вариант задания.

Перечисленные объекты по возможности реализовать отдельными классами.

Вывод указанных сообщений обязателен.

Индивидуальные задания по вариантам:

Вариант 3. Аэропорт

Самолеты прибывают в аэропорт каждые 1-7 сек. У аэропорта 3 взлетные полосы.

Между посадкой и взлетом проходит 3 – 5 сек.

С вероятностью 10% самолет нуждается в техническом обслуживании и остается в аэропорту. Взлетную полосу он не занимает. Когда в аэропорту более 5 самолетов на ТО, аэропорт закрывается.

Сообщения:

"{Plane} запрашивает посадку"

"=> {Plane} сел на полосу {number}"

"{Plane} отправлен на ТО"

" х------ {Plane} взлетел. В порту {count} самолетов. На ТО {service} самолетов"

"Порт закрыт"

```csharp
using System;
using System.Collections.Generic;
using System.Threading;

class Airport
{
    private static readonly object lockObject = new object();
    private readonly List<Runway> runways;
    private readonly Queue<Plane> landingQueue;
    private readonly Queue<Plane> takeoffQueue;
    private int planesInService;

    public Airport(int runwayCount)
    {
        runways = new List<Runway>();
        landingQueue = new Queue<Plane>();
        takeoffQueue = new Queue<Plane>();
        planesInService = 0;

        for (int i = 1; i <= runwayCount; i++)
        {
            runways.Add(new Runway(i));
        }
    }

    public void RequestLanding(Plane plane)
    {
        lock (lockObject)
        {
            Console.WriteLine($"{plane} запрашивает посадку");

            if (runways.Count > 0)
            {
                Runway runway = runways[0];
                runways.RemoveAt(0);
                landingQueue.Enqueue(plane);

                Thread landingThread = new Thread(() => HandleLanding(plane, runway));
                landingThread.Start();
            }
            else
            {
                Console.WriteLine("Аэропорт закрыт. Ожидайте.");
            }
        }
    }

    private void HandleLanding(Plane plane, Runway runway)
    {
        Thread.Sleep(3000); // Время посадки
        Console.WriteLine($"=> {plane} сел на полосу {runway.Number}");
        runways.Add(runway);

        lock (lockObject)
        {
            if (landingQueue.Count > 0)
            {
                Plane nextPlane = landingQueue.Dequeue();
                Thread landingThread = new Thread(() => HandleLanding(nextPlane, runway));
                landingThread.Start();
            }
            else
            {
                planesInService++;
                Console.WriteLine($"{plane} отправлен на ТО");
            }
        }
    }

    public void RequestTakeoff(Plane plane)
    {
        lock (lockObject)
        {
            takeoffQueue.Enqueue(plane);

            if (planesInService <= 5 && runways.Count > 0)
            {
                Runway runway = runways[0];
                runways.RemoveAt(0);

                Thread takeoffThread = new Thread(() => HandleTakeoff(plane, runway));
                takeoffThread.Start();
            }
            else if (planesInService > 5)
            {
                Console.WriteLine("Порт закрыт");
            }
        }
    }

    private void HandleTakeoff(Plane plane, Runway runway)
    {
        Thread.Sleep(3000); // Время взлета
        Console.WriteLine($"ß------ {plane} взлетел. В порту {planesInService} самолетов. На ТО {landingQueue.Count} самолетов");
        runways.Add(runway);

        lock (lockObject)
        {
            planesInService--;

            if (takeoffQueue.Count > 0)
            {
                Plane nextPlane = takeoffQueue.Dequeue();
                Thread takeoffThread = new Thread(() => HandleTakeoff(nextPlane, runway));
                takeoffThread.Start();
            }
        }
    }
}

class Runway
{
    public int Number { get; }

    public Runway(int number)
    {
        Number = number;
    }
}

class Plane
{
    public string Name { get; }

    public Plane(string name)
    {
        Name = name;
    }

    public override string ToString()
    {
        return $"{Name}";
    }
}

class Program
{
    static void Main()
    {
        Airport airport = new Airport(3);

        // Создание и запуск самолетов
        for (int i = 1; i <= 10; i++)
        {
            Plane plane = new Plane($"Plane-{i}");
            Thread landingThread = new Thread(() => airport.RequestLanding(plane));
            landingThread.Start();
            Thread.Sleep(new Random().Next(1000, 7000)); // Время до следующего самолета
        }

        Console.ReadLine();
    }
}
```

Результат выполнения:

![](Aspose.Words.86fc57c3-2edb-4ffb-92b1-a984c6794539.001.png)
