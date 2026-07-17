# MechGenPro
Engineered by Nabil Khondaker.

![Lua](https://img.shields.io/badge/Lua-2C2D72.svg?logo=lua&logoColor=white)
![LÖVE](https://img.shields.io/badge/L%C3%96VE-FF4C4C.svg?logo=love2d&logoColor=white)
![GLSL](https://img.shields.io/badge/GLSL-4285F4.svg?logo=opengl&logoColor=white)

**A procedural kinematics engine that generates, simulates, and optimizes mechanical linkages.**

---

<details>
<summary><b>Contents</b></summary>

- [🚀 Engineering Overview](#-engineering-overview)
- [✨ Key Features](#-key-features)
- [📁 Project Structure](#-project-structure)
- [🛠️ Tech Stack](#️-tech-stack)
- [⚙️ Quick Start](#️-quick-start)
  - [1. Prerequisites](#1-prerequisites)
  - [2. Running the Application](#2-running-the-application)
- [📊 Core Capabilities](#-core-capabilities)
- [🎯 Use Cases](#-use-cases)
- [👤 Author](#-author)

</details>

## 🚀 Engineering Overview

**MechGenPro** is a real-time procedural kinematics engine built in Lua with LÖVE2D. It procedurally generates, simulates, and optimizes planar mechanical linkages (four-bar mechanisms and beyond), with interactive visualization, Grashof classification, trajectory tracing, and optimization tools.

Perfect for mechanical engineering education, mechanism design research, robotics prototyping, and creative procedural generation experiments.

---

## ✨ Key Features

* **Procedural Mechanism Generation:** Automatic creation of valid four-bar linkages (Crank-Rocker, Double-Crank, Double-Rocker, etc.) using Grashof criteria.
* **Real-time Kinematic Simulation:** Forward kinematics with velocity/acceleration analysis.
* **Interactive Visualizer:** Pan, zoom, real-time animation with trajectory tracing and grid overlay.
* **GUI Inspector:** Dynamic parameter tweaking and live feedback.
* **Optimization Module:** Tools for optimizing link lengths and pivot positions.
* **Modular Architecture:** Clean separation of core engine, generator, visualizer, and GUI layers.
* **Blueprint Aesthetic:** Custom shaders and professional engineering-style UI.

---

## 📁 Project Structure

```
MechGenPro/
├── main.lua                   # App entry point (LÖVE2D standard)
├── conf.lua                   # Window and engine configuration
├── src/
│   ├── core/
│   │   ├── Engine.lua         # Main loop and state manager
│   │   ├── EventBus.lua       # Decoupled event messaging
│   │   └── config.lua         # Global constants
│   ├── math/
│   │   ├── Vector2.lua        # 2D Vector mathematics
│   │   ├── Matrix3x3.lua      # Transformations
│   │   └── Solvers.lua        # Newton-Raphson & numerical solvers
│   ├── kinematics/
│   │   ├── Linkage.lua        # Base class for all mechanisms
│   │   ├── FourBar.lua        # Four-bar solver & transmission angles
│   │   ├── CamFollower.lua    # Cam profile generation
│   │   ├── GearTrain.lua      # Epicyclic/planetary gear math
│   │   └── Joint.lua          # Revolute and prismatic joint definitions
│   ├── generator/
│   │   ├── ProceduralGen.lua  # Random generation using Grashof conditions
│   │   ├── RuleBuilder.lua    # Constraint logic for mechanisms
│   │   └── Validator.lua      # Checks for lockups/singularities
│   ├── optimization/
│   │   ├── GeneticOptimizer.lua # GA for path matching
│   │   ├── CostFunctions.lua  # Evaluates transmission angle & path deviation
│   │   └── KinematicHessian.lua # Advanced gradient descent
│   ├── visualizer/
│   │   ├── Renderer.lua       # Anti-aliased drawing of links/joints
│   │   ├── Camera.lua         # Pan/Zoom workspace camera
│   │   ├── Grid.lua           # Blueprint-style background
│   │   └── TraceGraph.lua     # Plots coupler curves and performance
│   ├── gui/
│   │   ├── imgui_impl.lua     # Bindings for Dear ImGui (UI)
│   │   ├── Timeline.lua       # Animation scrubber
│   │   └── Inspector.lua      # Property editor for link lengths
│   └── utils/
│       ├── Exporter.lua       # Exports CSV curve data / GIF frames
│       └── Logger.lua         # Console debugging
├── assets/
│   ├── shaders/
│   │   └── blueprint.glsl     # Custom shader for the workspace
│   └── fonts/
│       └── RobotoMono.ttf
└── tests/
    ├── test_fourbar_math.lua  # Unit tests for kinematics
    └── test_optimizer.lua
```


---

## 🛠️ Tech Stack

* **Language:** Lua
* **Framework:** LÖVE2D (Love2D)
* **Graphics:** Custom GLSL shaders + immediate-mode rendering
* **Math:** Custom vector/geometry library
* **UI:** Built-in LÖVE GUI components + Inspector panel

---

## ⚙️ Quick Start

### 1. Prerequisites

* [LÖVE2D](https://love2d.org/) (version 11.5+ recommended)
* Git

### 2. Running the Application

```bash
git clone https://github.com/nabilkhondaker/MechGenPro.git
cd MechGenPro

# Run with LÖVE
love .
```

### Controls
- **Right-click + drag:** Pan camera
- **Mouse wheel:** Zoom in/out
- **UI Panel:** Tweak parameters in real time

--- 

## 📊 Core Capabilities

- Grashof-based synthesis of planar four-bar mechanisms
- Real-time position, velocity, and acceleration analysis
- Trajectory tracing and coupler curve visualization
- Dynamic optimization of linkage performance
- Extensible architecture for adding new mechanism types

## 🎯 Use Cases

- Mechanical engineering education and demonstrations
- Rapid prototyping of linkage-based mechanisms
- Research in kinematic synthesis and optimization
- Procedural content generation for games/tools
- Interactive design tool for robotics and automation

## 👤 Author
*Engineered by Nabil Khondaker*
