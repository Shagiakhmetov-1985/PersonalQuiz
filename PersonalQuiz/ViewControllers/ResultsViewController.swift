//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 05.04.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    // 1. Передать сюда массив с ответами
    var answersValue: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        result()
        // 4. Избавиться от кнопки возврата назад на экране результатов
        navigationItem.hidesBackButton = true
    }
}

extension ResultsViewController {
    
    private func result() {
        //создание пустого словаря
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        //перечисление массива и присвоение экземпляров из enum [AnimalType]
        let animals = answersValue.map { $0.type }
        //итерация этого же массива
        for animal in animals {
            //если в словаре уже имеется экземпляр, например, кролик, то выполняет
            //условие и прибавляет ключ индекса к кролику +1
            //в противном случае, если, например, кролика нет, то условие никогда
            //не будет выполнено и всегда перейдет к условию else и присвоит
            //значение ключа кролика 1, а дальше после этого будет прибавлять +1 к
            //ключу индекса кролика
            // 2. Определить наиболее часто встречающийся тип животного
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        //сортировка наиболее часто встречающихся животных по ключу, это массив кортежей,
        //который отсортирован в порядке убывания
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        //выбор первого элемента кортежа, который и является результатом нашего окончательного ответа
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        //запуск функции и отсылка константы окончательного ответа в функцию и на экран
        updateUI(with: mostFrequencyAnimal)
    }
    
    // Решение в одну строку:
//    let mostFrequencyAnimal = Dictionary(grouping: answers) { $0.type }
//        .sorted { $0.value.count > $1.value.count }
//        .first?.key
    
    // 3. Отобразить результат в соответсвии с этим животным
    private func updateUI(with animal: AnimalType?) {
        animalLabel.text = "Вы - \(animal?.rawValue ?? "🐶")!"
        resultLabel.text = animal?.definition ?? ""
    }
}
//это мой уродливый код :)
//    private func checkAnimal(answers: [Answer]) {
//        var animal: [AnimalType] = []
//        for valueOne in answers {
//            for valueTwo in questions[questionIndex].answers {
//                if valueOne.type == valueTwo.type {
//                    animal.append(valueOne.type)
//                }
//            }
//        }
//        typeAnimal(animalsInAnswers: animal)
//    }
    /*private func typeAnimal(animalsInAnswers: [AnimalType]) {
        var dogs = 0
        var cats = 0
        var rabbits = 0
        var turtles = 0

        for value in animalsInAnswers {
            switch value {
            case AnimalType.dog:
                dogs += 1
            case AnimalType.cat:
                cats += 1
            case AnimalType.rabbit:
                rabbits += 1
            default:
                turtles += 1
            }
        }
        
        var resultNumbersAnimals = [
            AnimalType.dog: dogs,
            AnimalType.cat: cats,
            AnimalType.rabbit: rabbits,
            AnimalType.turtle: turtles
        ]
        
        let maxAnimals = resultNumbersAnimals.reduce(0) { max($0, $1.1) }
        
        let getFrequentNumberAnimals = [resultNumbersAnimals[AnimalType.dog],
                                       resultNumbersAnimals[AnimalType.cat],
                                       resultNumbersAnimals[AnimalType.rabbit],
                                       resultNumbersAnimals[AnimalType.turtle]
        ]

        var setFrequent: [AnimalType] = []
        for value in getFrequentNumberAnimals {
            if value == maxAnimals {
                switch value {
                case resultNumbersAnimals[AnimalType.dog]:
                    setFrequent.append(AnimalType.dog)
                    resultNumbersAnimals[AnimalType.dog] = 0
                case resultNumbersAnimals[AnimalType.cat]:
                    setFrequent.append(AnimalType.cat)
                    resultNumbersAnimals[AnimalType.cat] = 0
                case resultNumbersAnimals[AnimalType.rabbit]:
                    setFrequent.append(AnimalType.rabbit)
                    resultNumbersAnimals[AnimalType.rabbit] = 0
                default:
                    setFrequent.append(AnimalType.turtle)
                    resultNumbersAnimals[AnimalType.turtle] = 0
                }
            }
        }
        
        var sortedAnimals = [String]()
        for value in setFrequent {
            switch value {
            case AnimalType.dog:
                sortedAnimals.append("dog")
            case AnimalType.cat:
                sortedAnimals.append("cat")
            case AnimalType.rabbit:
                sortedAnimals.append("rabbit")
            default:
                sortedAnimals.append("turtle")
            }
        }
        sortedAnimals.sort()
        
        var elements = [String]()
        if sortedAnimals.count > 1 {
            for value in sortedAnimals {
                elements.append(value)
            }
        }
        let animal = sortedAnimals.removeFirst()
        switch animal {
        case "dog":
            setResult(result: [AnimalType.dog])
        case "cat":
            setResult(result: [AnimalType.cat])
        case "rabbit":
            setResult(result: [AnimalType.rabbit])
        default:
            setResult(result: [AnimalType.turtle])
        }
    }
 
    private func setResult(result: [AnimalType]) {
        switch result {
        case [AnimalType.dog]:
            animalLabel.text = "Вы - 🐶"
            resultLabel.text = AnimalType.dog.definition
        case [AnimalType.cat]:
            animalLabel.text = "Вы - 🐱"
            resultLabel.text = AnimalType.cat.definition
        case [AnimalType.rabbit]:
            animalLabel.text = "Вы - 🐰"
            resultLabel.text = AnimalType.rabbit.definition
        default:
            animalLabel.text = "Вы - 🐢"
            resultLabel.text = AnimalType.turtle.definition
        }
    }*/
