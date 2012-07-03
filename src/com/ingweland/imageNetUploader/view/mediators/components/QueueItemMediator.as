////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package com.ingweland.imageNetUploader.view.mediators.components
{
    import com.ingweland.imageNetUploader.events.model.UploadEvent;
    import com.ingweland.imageNetUploader.view.components.QueueItem;

    import org.robotlegs.mvcs.Mediator;

    public class QueueItemMediator extends Mediator
    {
        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var view:QueueItem;


        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function onRegister():void
        {
            addContextListener(UploadEvent.PROGRESS, removeItemHandler, UploadEvent);
        }

        //----------------------------------------------------------------------
        //
        //  Private methods
        //
        //----------------------------------------------------------------------

        private function removeItemHandler(event:UploadEvent):void
        {
            view.removeItem(event.queueItemId);
        }
    }
}