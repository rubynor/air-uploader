////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.events.controller
{
    import flash.events.Event;

    public class LoginEvent extends Event
    {
        //----------------------------------------------------------------------
        //
        //  Event types
        //
        //----------------------------------------------------------------------

        public static const LOGIN:String = "LoginEvent.login";
        public static const LOGIN_SUCCESSFUL:String = "LoginEvent.loginSuccessful";
        public static const LOGIN_FAILED:String = "LoginEvent.loginFailed";

        //----------------------------------------------------------------------
        //
        //  Public properties
        //
        //----------------------------------------------------------------------

        //----------------------------------
        //  username
        //----------------------------------
        private var _username:String;

        /**
         *
         */
        public function get username():String
        {
            return _username;
        }

        //----------------------------------
        //  password
        //----------------------------------
        private var _password:String;

        /**
         *
         */
        public function get password():String
        {
            return _password;
        }

        //----------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------

        public function LoginEvent(type:String,
                                   username:String = "",
                                   password:String = "",
                                   bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);

            _username = username;
            _password = password;
        }

        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function clone():Event
        {
            return new LoginEvent(type, username, password, bubbles, cancelable);
        }

        override public function toString():String
        {
            return formatToString("LoginEvent", "type", "bubbles", "cancelable",
                "eventPhase");
        }
    }
}