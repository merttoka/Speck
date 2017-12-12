# Speck
MAT240C Audio Programming Final Project

![ss](docs\ss.png)



### Install and Run

- Install [Processing](https://processing.org/download/)

- Add **Minim** and **ControlP5** libraries to Processing

  - *Sketch* -> *Import Library* -> *Add Libraries*
  - Search the name of the library and click *Install*

- Download / clone the files at:  

  ```git clone https://github.com/merttoka/Speck.git```

- Run `speck.pde` in Processing IDE




### Usage 

<img src="docs\GIF2.gif" alt="Drawing" style="width: 380px;"/> <img src="docs\GIF.gif" alt="Drawing" style="width: 150px;"/>




| Key                                      | Interaction                              |
| ---------------------------------------- | ---------------------------------------- |
| `LEFT CLICK` on *wave shape*             | Sets lower bound of grain selection      |
| `RIGHT CLICK` on *wave shape*            | Sets higher bound of grain selection (reverses sample if *min > max*) |
| `LEFT CLICK` on *envelope*               | Draws bins on envelope                   |
| `0` ... `9`                              | Trigger corresponding grain on the dropdown |
| `LEFT CLICK` on *canvas*                 | Places selected grain on the cell of canvas |
| `RIGHT CLICK` on *canvas*                | Removes item from the cell of canvas     |
| ` SPACE`                                 | Start / stop timer on canvas             |
| `i`                                      | Load an image into canvas (image path is in `void setup` function) |
| `s`                                      | Save canvas as an image file             |
| `c`                                      | Clear canvas                             |
| [`SHIFT`] + `LEFT ARROW` or `RIGHT ARROW` | Move timer left or right on canvas (`SHIFT` doubles the speed) |

- You can copy sample files to `speck/samples/` directory to populate the samples list.

- The *resolution* of canvas and *total time* of canvas can be modified with `resolution` (*canvas matrix dimension*) and `maxTime` (*milliseconds*) variables at the top of `speck.pde` 
- ​

### TODO:
- [x] Assign keyboard numbers to play grains
- [x] Draw normalized grain wave 
- [x] Reverse sample playback on selection
- [ ] Image selector
- [ ] Save grains and canvas on quit
- [ ] Editing Grains (delete, manipulate)
- [ ] Grain selector list colors
- [ ] Labels under the canvas
- [ ] Interaction improvements