# Game (Simulation Layer)

Pure gameplay logic with **no visual dependencies**.

## Structure

- `/systems` - Reusable game systems (health, movement, combat, etc.)
- `/state` - Game state managers and data models using Reactive classes

## Rules

- NO visual code (sprites, animations, particles, etc.)
- NO direct references to view layer
- Systems should be independent and reusable
- Use Reactive classes for all mutable state
- Systems communicate via signals or through state
