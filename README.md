ECE382_Lab2 - Subroutines - "Cryptography"
==========================================

# Purpose

  The purpose of this lab was to write a program that decrypts an encrypted message using a simple encryption technique. We were told to use subroutines in order to further our programming skills. The technique used for this program was the XOR function. The message is decrypted  by xoring the encrypted data with the key. This lab had us practice our programming skills by writing two subroutines. One subroutine was used to decrypt an individual piece of information, while the second was used to leverage the first subroutine to decrypt the entire message. In order to achieve the required functionality, we had to write a code that would decrypt a message of arbitrary length given a key that was one byte long and store the message into RAM at the address 0x0200. For B functionality, our code had to decrypt a message that utilized an arbitrarily long key. In order to achieve A Functionality, the code had to decrypt a message without the key being known. 
  
  
# Prelab

Below is a picture of my prelab pseudocode. It was discussed and signed off by Capt Trimble on 16 SEP 2014.

![alt text] (https://raw.github.com/CassieMcPeek/ECE382_Lab2/master/Prelab.jpg "Prelab Pseudocode")


# Debugging

  The start of this code was very similar to the first lab, with the .byte inputs. For the required functionality, there were two inputs, the encrypted message and the key. The first part of the main loop code was simple in that I loaded the different inputs into various registers and then called the subroutine decrypt_message. I didn't fact too many issues with this part of the code. Moving on with the code, I wrote two subroutines, the first being very simple in that it only performed the XOR function between the encrypted message. The second subroutine is where the entire message was actually decrypted by utilizing the first subroutine. 

  
