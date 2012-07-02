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
    import com.ingweland.imageNetUploader.view.components.ProgressBar;

    import org.robotlegs.mvcs.Mediator;

    public class ProgressBarMediator extends Mediator
    {
        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var view:ProgressBar;


        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function onRegister():void
        {
            addContextListener(UploadEvent.PROGRESS, uploadProgressHandler, UploadEvent);
        }

        //----------------------------------------------------------------------
        //
        //  Private methods
        //
        //----------------------------------------------------------------------

        private function uploadProgressHandler(event:UploadEvent):void
        {
            view.updateProgress(event.filesLeft, event.uploadedPercentage);
        }
    }
}