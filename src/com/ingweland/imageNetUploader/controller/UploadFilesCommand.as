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
    import co.uk.mikestead.net.URLFileVariable;
    import co.uk.mikestead.net.URLRequestBuilder;

    import com.ingweland.imageNetUploader.events.model.UploadEvent;
    import com.ingweland.imageNetUploader.model.APIRequestsModel;
    import com.ingweland.imageNetUploader.model.UploadingQueueModel;
    import com.ingweland.imageNetUploader.model.UserModel;
    import com.ingweland.imageNetUploader.model.vo.QueueItemVO;

    import deng.fzip.FZip;

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.utils.ByteArray;

    import org.robotlegs.mvcs.Command;

    public class UploadFilesCommand extends Command
    {
        private var _fileStream:FileStream = new FileStream();
        private var _byteArray:ByteArray = new ByteArray();

        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var event:UploadEvent;

        [Inject]
        public var apiRequestsModel:APIRequestsModel;

        [Inject]
        public var userModel:UserModel;

        [Inject]
        public var uploadingQueueModel:UploadingQueueModel;

        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        private var _currentQueueItem:QueueItemVO;

        override public function execute():void
        {
            commandMap.detain(this);

            uploadingQueueModel.resetFailedUploads();

            upload();
        }

        private function zipFile(file:File):ByteArray
        {
            _byteArray.clear();
            var zip:FZip = new FZip();
            _fileStream = new FileStream();
            _fileStream.open(file, FileMode.READ);
            _fileStream.readBytes(_byteArray);
            zip.addFile(file.name, _byteArray);

            var byteArray:ByteArray = new ByteArray();
            zip.serialize(byteArray);
            return byteArray;
        }

        private function upload():void
        {
            _currentQueueItem = uploadingQueueModel.getNextQueueItem();
            if(_currentQueueItem)
            {
                var loader:URLLoader = new URLLoader();
                var url:String = apiRequestsModel.requests[APIRequestsModel.ROOT_URL] +
                    apiRequestsModel.requests[APIRequestsModel.UPLOAD] +
                    "?auth_token=" + userModel.authToken;
                var variables:URLVariables = new URLVariables();
                    variables["dicom[file]"] = new URLFileVariable(zipFile(_currentQueueItem.file),
                        _currentQueueItem.file.name);
                var request:URLRequest = new URLRequestBuilder(variables).build();
                request.url = url;
                request.method = "POST";
                loader.addEventListener(Event.COMPLETE, upload_completeHandler);
                loader.addEventListener(IOErrorEvent.IO_ERROR, upload_ErrorHandler);
                loader.load(request);
            }
            else
            {
                dispatch(new UploadEvent(UploadEvent.COMPLETED));
                commandMap.release(this);
            }
        }

        protected function upload_ErrorHandler(evt:IOErrorEvent):void
        {
            trace("error")
            trace(evt.target.data)
            uploadingQueueModel.processFailedUpload(_currentQueueItem);
            proceedToNextItem();
        }

        protected function upload_completeHandler(evt:Event):void
        {
            trace(evt.target.data)
            uploadingQueueModel.processCompletedUpload(_currentQueueItem);
            proceedToNextItem();
        }

        private function proceedToNextItem():void
        {
            var percentageCompleted:Number = uploadingQueueModel.bytesUploaded /
                uploadingQueueModel.bytesTotal;
            dispatch(new UploadEvent(UploadEvent.PROGRESS,
                null, null, uploadingQueueModel.itemsLeft, percentageCompleted, _currentQueueItem.id));

            upload();
        }
    }
}