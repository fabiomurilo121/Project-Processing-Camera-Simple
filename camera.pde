import processing.video.*;
import milchreis.imageprocessing.*;
import processing.sound.*;
/////////////////////////////////////
PImage image;
Capture cam;
SoundFile file;
boolean ligado = true;
boolean telaedit = false;

void settings()
{
  size(640,480);
}
void setup() 
{

      OutraJanela janelanova = new OutraJanela();
      runSketch(new String[]{"Janela de Interface"}, janelanova);
      
      file = new SoundFile(this, "som.mp3"); 
      
      String[] cameras = Capture.list(); // atualiza a resolusao da webcam exemplo:320x240 e mostra o tamanho da array
      if (cameras.length == 0) 
      {
       //vazio
      } 
      else 
      {
      for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
      }
      cam = new Capture(this, cameras[0]);
      cam.start();     
    }      
}

void draw()
{

   if (cam.available() == ligado)  // liga e desliga a camera
    {
      cam.read();
    }
  image(cam, 0, 0,640,480);
  image = loadImage(dataPath("example.jpg")); //carrega a imagem para a estensao
}

void keyPressed()
{
  
  if( key == 'g' )
    {
      save("data/example.jpg");
      background(70);
      file.play();
    }
    
    /*if((ligado == false) && (key == 'l' ))
    {
      ligado = true;
    }
    else if((ligado == true) && (key == 'k' ))
    {
      ligado =false;
    }*/
    if(key == '1')
    {
       OutraJanela1 janelanova = new OutraJanela1();
       runSketch(new String[]{"janela 1"}, janelanova);
    }
    else if(key == '2')
    {
       OutraJanela2 janelanova = new OutraJanela2();
       runSketch(new String[]{"janela 2"}, janelanova);
    }
    else if(key == '3')
    {
       OutraJanela3 janelanova = new OutraJanela3();
       runSketch(new String[]{"janela 3"}, janelanova);
    }
   /* else if(key == '4')
    {
      
    }
    else if(key == '5')
    {
      
    }
    else if(key == '6')
    {
      
    }*/
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////       Função janela        ///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

class OutraJanela extends PApplet
{
    public void settings()
    {
       size(640,300);
    }
    
    public void draw()
    {
      background(255);
      fill(0,200,255);
      rect(0,20,320,300);
      noFill();
      fill(0,255,0);
      rect(320,20,319,300);
      fill(0);
      textSize(21);
      text("Clique G para tirar uma foto", 10, 150);
      text("Selecione o Modo da foto:",350,50);
      text("MODO: MUDANÇA DE COR ",355,110);
      text("MODO: GLITCH",355,140);
      text("MODO: VARIADO",355,170);
      /*text("MODO: VARIADO",355,200);
      text("MODO: BLOOM ",355,230);*/
      text("SELECIONE UM NÚMERO",350,290);
      text("F",330,200);
      fill(255);
      rect(320,20,28,300);
      noFill();
      fill(0);
      text("",330,230);
      text("",330,200);
      text("3",330,170);
      text("2",330,140);
      text("1",330,110);

    }
}

class OutraJanela1 extends PApplet
{
  LUT[] lookuptables;
  int currentIndex = 0;

  void settings()
  {
    size(640,480);
  }
  
  void setup()
  {
    lookuptables = new LUT[LUT.STYLE.values().length];
    for(int i=0; i<lookuptables.length; i++) {
    lookuptables[i] = LUT.loadLut(LUT.STYLE.values()[i]);
  }
  }
  void draw()
  {
      if(mousePressed == true) {
      image(image, 0, 0);
    } else {
      image(LUT.apply(image, lookuptables[currentIndex]), 0, 0);
    
      fill(0);
      String stylename = LUT.STYLE.values()[currentIndex].name();
      text(stylename, width/2 - textWidth(stylename)/2, 30); 
    }
  }
  
  void mouseWheel(MouseEvent event) {
    currentIndex += 1;
    
    if(currentIndex >= lookuptables.length) {
      currentIndex = 0;
    }
  }
}

class OutraJanela2 extends PApplet
{
    public void settings()
    {
       size(640,480);
    }
    
    public void setup()
    {
      //vazio
    }
    
    public void draw()
    {
      if(mousePressed == true) 
      {
        image(image, 0, 0);
      } 
      else 
      {
        int intensity = (int) map(mouseX, 0, width, 0, 4);
        image(Glitch.apply(image, intensity), 0, 0);
      }
  }
}

class OutraJanela3 extends PApplet
{
  int hue = 0;
  int x = 0, y = 0;
  int shiftedColor = 0;
  int pixel = 0;

  void settings()
  {
     size(640,480);
  }
  
  void setup()
  {
  
  }
  
  void draw()
  {
      if(mousePressed == true) {
    pixel = image.get(mouseX, mouseY);

    x = mouseX;
    y = mouseY;

    hue = (int)Tools.rgbToHsb(pixel)[0];

  } else {
    // Get shift by mouse x-axis    
    int shift = (int)map(mouseX, 0, width, -30, 30);
    
    // Shift the selected color by hue value
    PImage p = ColorShift.applyHue(image, hue, 10, shift);
    
    // Get new shifted color
    shiftedColor = p.get(x, y);
    
    image(p, 0, 0);
  }
 
  noStroke();
  
  // Draw selected color
  fill(pixel);
  rect(0, height - 10, width/2, 10);
  
  // Draw shifted color
  fill(shiftedColor);
  rect(width/2, height - 10, width/2, 10);
  }
}

/*class OutraJanela4 extends PApplet
{

  void settings()
  {
  
  }
  
  void setup()
  {
  
  }
  
  void draw()
  {
  
  }
}*/
