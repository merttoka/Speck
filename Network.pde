
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

void initNetwork(int inPort, int outPort) {

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, inPort);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", outPort);
}

void sendMessage(String name, String msg) {
  OscMessage myMessage = new OscMessage(name);
  myMessage.add(msg);
  oscP5.send(myMessage, myRemoteLocation); 
}
void sendMessage(String name, float msg) {
  OscMessage myMessage = new OscMessage(name);
  myMessage.add(msg);
  oscP5.send(myMessage, myRemoteLocation); 
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}