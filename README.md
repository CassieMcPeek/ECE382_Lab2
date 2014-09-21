ECE382_Lab2 - Subroutines - "Cryptography"
==========================================

# Purpose

  The purpose of this lab was to write a program that decrypts an encrypted message using a simple encryption technique. We were told to use subroutines in order to further our programming skills. The technique used for this program was the XOR function. The message is decrypted  by xoring the encrypted data with the key. This lab had us practice our programming skills by writing two subroutines. One subroutine was used to decrypt an individual piece of information, while the second was used to leverage the first subroutine to decrypt the entire message. In order to achieve the required functionality, we had to write a code that would decrypt a message of arbitrary length given a key that was one byte long and store the message into RAM at the address 0x0200. For B functionality, our code had to decrypt a message that utilized an arbitrarily long key. In order to achieve A Functionality, the code had to decrypt a message without the key being known. 
  
  
# Prelab

Below is a picture of my prelab pseudocode. It was discussed and signed off by Capt Trimble on 16 SEP 2014.

![alt text] (https://raw.github.com/CassieMcPeek/ECE382_Lab2/master/Prelab.jpg "Prelab Pseudocode")


# Debugging

  The start of this code was very similar to the first lab, with the .byte inputs. For the required functionality, there were two inputs, the encrypted message and the key. The first part of the main loop code was simple in that I loaded the different inputs into various registers and then called the subroutine decrypt_message. I didn't face too many issues with this part of the code. Moving on with the code, I wrote two subroutines, the first being very simple in that it only performed the XOR function between the encrypted message. The second subroutine is where the entire message was actually decrypted by utilizing the first subroutine. This is where I ran into some issues with my code. I had to make sure that each individual piece was decrypted, and that it went through every piece before it output the final message. The first issue I had, was I forgot to increment the register with the encrypted message in it. This meant that only the first piece of the message was being decrypted. Once I figured that out, it worked better. The next issue I ran into happened was while working on the B functionality. For this, I also had to keep track of the length of the key, which meant that I needed to also increment the register that held the key in it. It also required another .byte input of the length of the key, which I originally forgot and that caused problems. Once I added the new input instruction, I had to make sure that while the encrypted message was being decrypted, it was utilizing the entire key and then reset. Those were the main issues I faced while debugging my code.
  
  
# Testing

For this lab, the testing and debugging went hand in hand. The first test I ran was to test the required functionality by inputting the given encrypted message: 0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f 

into the .byte input and the given key 0xac into the second .byte input. Unfortunately, the output was not a message. when I ran this test, the output in the address 0x0200 was the letter C and a few characters like ~ and *. This did not seem to be the correct message as it was not a message. After that, I went back and did the debugging described above and made a few changes. It took me running this same test with debugging 3 times before I finally recieved a message in the address 0x0200. 

Once I completed testing for the required functionality, I moved onto B functionality. For this I utilized the given encrypted message and key from the lab handout. I input the given encrypted message:

0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba,0x50,0x8f

into the .byte input and then the given key 0xacdf23 into the key input. When I first ran the test the output into the address 0x0200 was the letter "s" into every third byte. Once again, I assumed this was wrong because it was not an actual message, just a letter repeated. So I went back and did some more debugging and one of the issues I had that I forgot to mention above, was that I needed to split up the key when I input it, so it was input as: 0xac, 0xdf, 0x23 and also that I needed another input to keep track of the length of the key. This input was a .word input to cover all cases. Once I made these changes, I ran the same test again and received a message with a hint for the A functionality. Unfortunately, I was not able to get the A funtionality working. 

I demonstrated the required and B functionalities to Capt Trimble on 18 SEP 2014 at 1245. 

# Conclusion
  
  The goal of this lab was the decrypt a message with a given key. The results of the decrypted message were not given, but it was clear when the goal was reached because it produced an actual message and not just letters or symbols. This lab taught me a lot about assembly code, mainly how to utilize subroutines to help make the code easier to debug and understand. I learned how to call subroutines inside of other subroutines and also in the main loop of the code. The most challenging part of this code was determining what should take place in the main loop versus the subroutines. I understood how the XOR function was going to be utilized, but ensuring that each piece of information was xor'd with the key individually and then the entire message was output into the correct address 0x0200, was a little challenging. I was not able to achieve the A functionality of decrypting a message without knowledge of the key, but I still learned a lot from this lab. 
  
# Documentation:

  C2C Ian Goodbody assisted me with debugging my code and he also showed me how to keep track of the length of the key by utilizing another input. 
