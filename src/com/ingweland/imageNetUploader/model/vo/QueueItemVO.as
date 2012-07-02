////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.model.vo
{
    import flash.filesystem.File;

    public class QueueItemVO
    {
        /*public static const QUEUED:int = 0;
        public static const UPLOADED:int = 1;
        public static const FAILED:int = 3;*/

        public var id:String;
        public var file:File;

        [Bindable]
        public var uploadFailed:Boolean = false;

        [Bindable]
        public var uploadCompleted:Boolean = false;
    }
}