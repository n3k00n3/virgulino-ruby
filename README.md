# virgulino

Virgulino is a *cryptography* and *steganography* program.
The idea of the program is to encrypt messages before hiding, making it a little safer to send and receive messages hidden in various types of files like txt, png, mp3 among other means.


## Authors

1. Fernando 'n3k00n3' Pinheiro
2. Victor 'UserX' Flores

## Description

Virgulino is a command line tool for hiding messages in various types of files like JPG, PNG, text files ...

Before hiding the message, we can choose which type of encryption we want and we generate the encrypted message, soon after we choose the type of steganography. The idea of encrypting the message before hiding is that if someone notices that a hidden message exists, they have more work to identify what is being sent by adding a larger layer of security to the message.

NOTE: Most of the encryption used is old encryption that is not as secure as the most modern one such as RSA, so if you are sending a message and need more security, use the most up-to-date figures that are not as succesful as frequency scanning attacks

The code numbers and steganography plugins can be used separately because the virgulino project was done with plugins architecture where adding and removing crypto or stegno plugins become very simple. Even if the user decides to create his own number.

## Do you want to contribute?

If you want to contribute, you can get an overview over the open issues. We are happy to answer your questions if you consider to help. All the issues have a link to their specification. If you want to work on an issue feel free to assign yourself.

https://github.com/lampiaosec/virgulino-ruby/issues

Find further details in: https://github.com/lampiaosec/virgulino-ruby/blob/master/CONTRIBUTING.md

## we also use a wiki

Virgulino uses wiki technology to its documentation. Please, go to [Virgulino's wiki](https://github.com/lampiaosec/virgulino/wiki).

#### Why?

If you want understand about why we decided this, look to [here](https://github.com/lampiaosec/virgulino/issues/35).
