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
    import com.ingweland.imageNetUploader.model.UploadingQueueModel;

    import org.robotlegs.mvcs.Command;

    public class RemoveItemFromQueueCommand extends Command
    {
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
            uploadingQueueModel.removeItemFromQueue(event.queueItemId);
            var percentageCompleted:Number = uploadingQueueModel.bytesUploaded /
                uploadingQueueModel.bytesTotal;
            dispatch(new UploadEvent(UploadEvent.PROGRESS,
                null, null, uploadingQueueModel.itemsLeft, percentageCompleted));
        }
    }
}