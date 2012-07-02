////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka FlexIncubator)
//  http://flexincubator.com
//  flexincubator@gmail.com
//  2011
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.model
{
    import flash.utils.Dictionary;

    public class APIRequestsModel
    {
        //--------------------------------------------------------------------------
        //
        //  Public properties
        //
        //--------------------------------------------------------------------------

        public static const ROOT_URL:String = "rootUrl";
        public static const LOGIN:String = "login";
        public static const UPLOAD:String = "upload";

        //----------------------------------
        //  requests
        //----------------------------------
        private var _requests:Array = new Array();

        /**
         /* @return
         */
        public function get requests():Array
        {
            return _requests;
        }

        /**
         /* @private
         */
        public function set requests(value:Array):void
        {
                _requests = value;
        }
    }
}