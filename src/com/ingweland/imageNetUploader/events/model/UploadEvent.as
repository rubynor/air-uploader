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
    import com.ingweland.imageNetUploader.model.vo.QueueItemVO;

    import flash.events.Event;
    import flash.filesystem.File;

    public class UploadEvent extends Event
    {
        //----------------------------------------------------------------------
        //
        //  Event types
        //
        //----------------------------------------------------------------------

        public static const FILES_SELECTED:String = "UploadEvent.filesSelected";
        public static const QUEUE_UPDATED:String = "UploadEvent.queueUpdated";
        public static const PROGRESS:String = "UploadEvent.progress";
        public static const COMPLETED:String = "UploadEvent.completed";
        public static const UPLOAD:String = "UploadEvent.upload";
        public static const FAILED:String = "UploadEvent.failed";
        public static const RETRY:String = "UploadEvent.retry";

        //----------------------------------------------------------------------
        //
        //  Public properties
        //
        //----------------------------------------------------------------------

        //----------------------------------
        //  selectedFiles
        //----------------------------------
        private var _selectedFiles:Array;

        /**
         *
         */
        public function get selectedFiles():Array
        {
            return _selectedFiles;
        }

        //----------------------------------
        //  filesUploaded
        //----------------------------------
        private var _filesLeft:uint;

        /**
         *
         */
        public function get filesLeft():uint
        {
            return _filesLeft;
        }

        //----------------------------------
        //  uploadedPercentage
        //----------------------------------
        private var _uploadedPercentage:Number;

        /**
         *
         */
        public function get uploadedPercentage():Number
        {
            return _uploadedPercentage;
        }

        //----------------------------------
        //  queueItems
        //----------------------------------
        private var _queueItems:Vector.<QueueItemVO>;

        /**
         *
         */
        public function get queueItems():Vector.<QueueItemVO>
        {
            return _queueItems;
        }

        //----------------------------------
        //  queueItemId
        //----------------------------------
        private var _queueItemId:String;

        /**
         *
         */
        public function get queueItemId():String
        {
            return _queueItemId;
        }

        //----------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------

        public function UploadEvent(type:String,
                                    selectedFiles:Array = null,
                                    queueItems:Vector.<QueueItemVO> = null,
                                    filesLeft:uint = 0,
                                    uploadedPercentage:Number = 0,
                                    queueItemId:String = "",
                                    bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);

            _selectedFiles = selectedFiles;
            _queueItems = queueItems;
            _filesLeft = filesLeft;
            _uploadedPercentage = uploadedPercentage;
            _queueItemId = queueItemId;
        }

        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function clone():Event
        {
            return new UploadEvent(type,
                selectedFiles,
                queueItems,
                filesLeft,
                uploadedPercentage,
                queueItemId,
                bubbles, cancelable);
        }

        override public function toString():String
        {
            return formatToString("UploadEvent", "type", "bubbles", "cancelable",
                "eventPhase");
        }
    }
}