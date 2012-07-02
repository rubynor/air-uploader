////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.model
{
    import org.robotlegs.mvcs.Actor;

    public class UserModel extends Actor
    {
        //----------------------------------
        //  authToken
        //----------------------------------
        private var _authToken:String;

        /**
         *
         */
        public function get authToken():String
        {
            return _authToken;
        }

        /**
         * @private
         */
        public function set authToken(value:String):void
        {
            if (_authToken != value)
            {
                _authToken = value;
            }
        }
    }
}