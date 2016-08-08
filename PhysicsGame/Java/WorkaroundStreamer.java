package PhysicsGame.Java;

import java.io.IOException;
import java.net.Socket;
import java.io.OutputStream;

class WorkaroundStreamer {
	
	public static void main(String[] args) throws IOException, InterruptedException {
		//System.out.println("start workaround");
		
		
		
		//try {
			
			//System.out.println(args[0]);
			Thread.sleep(1000);
			
			Socket socket = new Socket("localhost", 1234);
			
			OutputStream outputStream = socket.getOutputStream();
			outputStream.write(args[0].getBytes("ISO-8859-1"));
			
		/*} catch (IOException e) {
			
		} catch (InterruptedException e) {
			
		}*/
	}

}
