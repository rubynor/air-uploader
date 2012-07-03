////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.view.mediators.ui
{
    import com.ingweland.imageNetUploader.events.model.UploadEvent;
    import com.ingweland.imageNetUploader.view.ui.UploadScreen;

    import org.robotlegs.mvcs.Mediator;

    public class UploadScreenMediator extends Mediator
    {
        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var view:UploadScreen;


        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function onRegister():void
        {
            addContextListener(UploadEvent.COMPLETED, successfulUploadHandler, UploadEvent);
            addContextListener(UploadEvent.QUEUE_UPDATED, updateQueuHandler, UploadEvent);
            addContextListener(UploadEvent.FAILED, failedUploadHandler, UploadEvent);

            addViewListener(UploadEvent.FILES_SELECTED, redispatchUploadEventHandler, UploadEvent);
            addViewListener(UploadEvent.RETRY, redispatchUploadEventHandler, UploadEvent);
        }

        //----------------------------------------------------------------------
        //
        //  Private methods
        //
        //----------------------------------------------------------------------

        private function redispatchUploadEventHandler(event:UploadEvent):void
        {
            dispatch(event);
        }

        private function successfulUploadHandler(event:UploadEvent):void
        {
            view.processSuccessfulUpload();
        }

        private function updateQueuHandler(event:UploadEvent):void
        {
            view.updateQueue(event.queueItems);
        }

        private function failedUploadHandler(event:UploadEvent):void
        {
            view.processFailedUpload(event.filesLeft);
        }
    }
}