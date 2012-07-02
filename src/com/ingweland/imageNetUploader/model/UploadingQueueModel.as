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
    import com.ingweland.imageNetUploader.model.vo.QueueItemVO;
    import com.ingweland.utils.StringUtil;

    import flash.filesystem.File;

    public class UploadingQueueModel
    {
        //----------------------------------------------------------------------
        //
        //  Private properties
        //
        //----------------------------------------------------------------------

        private var _uploadedInThisSession:Vector.<String> = new Vector.<String>();

        //----------------------------------------------------------------------
        //
        //  Public properties
        //
        //----------------------------------------------------------------------

        //----------------------------------
        //  queue
        //----------------------------------
        private var _queue:Vector.<QueueItemVO> = new Vector.<QueueItemVO>();

        /**
         *
         */
        public function get queue():Vector.<QueueItemVO>
        {
            return _queue;
        }

        //----------------------------------
        //  bytesTotal
        //----------------------------------
        private var _bytesTotal:Number = 0;

        /**
         *
         */
        public function get bytesTotal():Number
        {
            return _bytesTotal;
        }

        //----------------------------------
        //  bytesUploaded
        //----------------------------------
        private var _bytesUploaded:Number = 0;

        /**
         *
         */
        public function get bytesUploaded():Number
        {
            return _bytesUploaded;
        }

        //----------------------------------
        //  itemsLeft
        //----------------------------------
        private var _itemsLeft:int;

        /**
         *
         */
        public function get itemsLeft():int
        {
            return _itemsLeft;
        }

        //----------------------------------------------------------------------
        //
        //  Public methods
        //
        //----------------------------------------------------------------------

        public function addItemsToQueue(items:Vector.<File>):Vector.<QueueItemVO>
        {
            var tempQIVO:QueueItemVO;
            var tempVector:Vector.<QueueItemVO> = new Vector.<QueueItemVO>();
            for each (var file:File in items)
            {
                if(!checkQueueHasItem(file))
                {
                    tempQIVO = new QueueItemVO();
                    tempQIVO.id = StringUtil.generateRandomString();
                    tempQIVO.file = file;
                    tempVector.push(tempQIVO);
                    _queue.push(tempQIVO);
                    _bytesTotal += file.size;
                }
            }
            _itemsLeft += tempVector.length;
            trace("------------------------------------------------");
            trace("UploadingQueueModel.addItemsToQueue(items)");
            trace("Queue length >> " + _queue.length);
            trace("Bytes total >> " + _bytesTotal);
            trace("Items added to queue >> " + tempVector.length);
            trace("------------------------------------------------");
            trace()

            return tempVector;
        }

        public function removeItemFromQueue(id:String):void
        {
            var limit:int = _queue.length;
            for (var i:int = 0; i < limit; i++)
            {
                if(_queue[i].id == id)
                {
                    break;
                }
            }

            if(i < _queue.length)
            {
                _bytesTotal -= _queue[i].file.size;
                _itemsLeft--;
                _queue.splice(i, 1);
            }

            trace("------------------------------------------------");
            trace("UploadingQueueModel.removeItemFromQueue(id)");
            trace("Queue length >> " + _queue.length);
            trace("Bytes total >> " + _bytesTotal);
            trace("------------------------------------------------");
            trace()
        }

        public function resetFailedUploads():void
        {
            for each (var qivo:QueueItemVO in _queue)
            {
                if(qivo.uploadFailed)
                {
                    qivo.uploadFailed = false;
                }
            }
        }

        public function getNextQueueItem():QueueItemVO
        {
            for each (var qivo:QueueItemVO in _queue)
            {
                if(!qivo.uploadCompleted && !qivo.uploadFailed)
                {
                    return qivo;
                }
            }

            processUploadCompletion();
            return null;
        }

        public function processCompletedUpload(item:QueueItemVO):void
        {
            item.uploadCompleted = true;
            updateQueueNumbers(item);

            trace("------------------------------------------------");
            trace("UploadingQueueModel.processCompletedUpload(item)");
            trace("Bytes uploaded >> " + _bytesUploaded);
            trace("Items left >> " + _itemsLeft);
            trace("------------------------------------------------");
            trace()
        }

        public function processFailedUpload(item:QueueItemVO):void
        {
            item.uploadFailed = true;
            updateQueueNumbers(item);

            trace("------------------------------------------------");
            trace("UploadingQueueModel.processFailedUpload(item)");
            trace("Bytes uploaded >> " + _bytesUploaded);
            trace("Items left >> " + _itemsLeft);
            trace("------------------------------------------------");
            trace()
        }

        //----------------------------------------------------------------------
        //
        //  Private methods
        //
        //----------------------------------------------------------------------

        private function updateQueueNumbers(item:QueueItemVO):void
        {
            _bytesUploaded += item.file.size;
            _itemsLeft--;
        }

        private function checkQueueHasItem(item:File):Boolean
        {
            for each (var queueItem:QueueItemVO in _queue)
            {
                if(queueItem.file.nativePath == item.nativePath)
                {
                    return true;
                }
            }

            for each (var fileName:String in _uploadedInThisSession)
            {
                if(fileName == item.nativePath)
                {
                    return true;
                }
            }


            return false;
        }

        private function processUploadCompletion():void
        {
            var tempVector:Vector.<QueueItemVO> = new Vector.<QueueItemVO>();
            _bytesTotal = 0;
            _bytesUploaded = 0;
            for each (var qivo:QueueItemVO in _queue)
            {
                if(!qivo.uploadFailed)
                {
                    _uploadedInThisSession.push(qivo.file.nativePath);
                }
                else
                {
                    tempVector.push(qivo);
                    _bytesTotal += qivo.file.size;
                }
            }

            _itemsLeft = tempVector.length;
            _queue = tempVector;
        }
    }
}