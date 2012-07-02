////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.events.model
{
    import flash.events.Event;

    public class StartupEvent extends Event
    {
        //----------------------------------------------------------------------
        //
        //  Event types
        //
        //----------------------------------------------------------------------

        public static const CONFIG_LOADED:String = "StartupEvent.configLoaded";

        //----------------------------------------------------------------------
        //
        //  Public properties
        //
        //----------------------------------------------------------------------



        //----------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------

        public function StartupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }

        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function clone():Event
        {
            return new StartupEvent(type, bubbles, cancelable);
        }

        override public function toString():String
        {
            return formatToString("StartupEvent", "type", "bubbles", "cancelable",
                "eventPhase");
        }
    }
}