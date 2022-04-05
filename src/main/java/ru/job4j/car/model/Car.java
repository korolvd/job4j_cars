package ru.job4j.car.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "car")
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "engine_id", foreignKey = @ForeignKey(name = "ENGINE_ID_FK"))
    private Engine engine;

    @ManyToMany
    @JoinTable(name = "history_owner",
            joinColumns = {@JoinColumn(name = "driver_id", nullable = false, updatable = false)},
            inverseJoinColumns = {@JoinColumn(name = "car_id", nullable = false, updatable = false)})
    private Set<Driver> drivers;
}
