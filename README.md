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

  For this lab, the testing and debugging went hand in hand. The first test I ran was to test the required functionality by inputting the given encrypted message 0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f into the .byte input and the given key 0xac into the second .byte input. Unfortunately, the output was not a message. when I ran this test, the output in the address 0x0200 was the letter C and a few characters like ~ and *. This did not seem to be the correct message as it was not a message. After that, I went back and did the debugging described above and made a few changes 
  
