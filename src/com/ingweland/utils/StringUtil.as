////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.utils
{
    public class StringUtil
    {
        public static function generateRandomString(
            length:uint = 16,
            userAlphabet:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        ):String
        {
            var alphabet:Array = userAlphabet.split("");
            var alphabetLength:int = alphabet.length;
            var randomLetters:String = "";
            for (var i:uint = 0; i < length; i++)
            {
                randomLetters += alphabet[int(Math.floor(Math.random() * alphabetLength))];
            }

            return randomLetters;
        }
    }
}