////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.controller
{
    import com.ingweland.imageNetUploader.events.model.UploadEvent;
    import com.ingweland.imageNetUploader.model.vo.QueueItemVO;

    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;

    import mx.controls.Alert;

    import org.robotlegs.mvcs.Command;
    import com.ingweland.imageNetUploader.model.UploadingQueueModel;

    public class ProcessSelectedFilesCommand extends Command
    {
        //----------------------------------------------------------------------
        //
        //  Private properties
        //
        //----------------------------------------------------------------------

        private var _dicoms:Vector.<File> = new Vector.<File>();
        private var _fileStream:FileStream = new FileStream();
        private var _byteArray:ByteArray = new ByteArray();
        private var _i:int;

        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var event:UploadEvent;

        [Inject]
        public var uploadingQueueModel:UploadingQueueModel;

        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function execute():void
        {
            var n:Number = getTimer();
            var initSelection:Array = event.selectedFiles;
            for each (var file:File in initSelection)
            {
                if(file.isDirectory)
                {
                    processDirectory(file);
                }
                else
                {
                    processFile(file);
                }
            }

            var tempVector:Vector.<QueueItemVO> = uploadingQueueModel.addItemsToQueue(_dicoms);
            dispatch(new UploadEvent(UploadEvent.QUEUE_UPDATED, null, tempVector));
            var percentageCompleted:Number = uploadingQueueModel.bytesUploaded /
                uploadingQueueModel.bytesTotal;
            dispatch(new UploadEvent(UploadEvent.PROGRESS,
                null, null, uploadingQueueModel.itemsLeft, percentageCompleted));
        }

        private function processDirectory(directory:File):void
        {
            var listing:Array = directory.getDirectoryListing();
            for each (var file:File in listing)
            {
                if(file.isDirectory)
                {
                    processDirectory(file);
                }
                else
                {
                    processFile(file);
                }
            }
        }

        private function processFile(file:File):void
        {
            _i++;
            _fileStream.open(file, FileMode.READ);
            _fileStream.position = 128;
            if(_fileStream.bytesAvailable < 4)
            {
                return;
            }
            var signature:String = _fileStream.readUTFBytes(4);
            if(signature == "DICM" && file.name != "DICOMDIR")
            {
                _dicoms.push(file);
            }
        }
    }
}