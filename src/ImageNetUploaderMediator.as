////////////////////////////////////////////////////////////////////////////////
//
//  Author ILYA GOLOVACH (aka IngweLand)
//  http://ingweland.com
//  ingweland@gmail.com
//  2012
//
////////////////////////////////////////////////////////////////////////////////

package
{
    import com.ingweland.imageNetUploader.events.controller.LoginEvent;
    import com.ingweland.imageNetUploader.events.model.StartupEvent;

    import flash.events.Event;

    import org.robotlegs.mvcs.Mediator;

    public class ImageNetUploaderMediator extends Mediator
    {
        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var view:ImageNetUploader;


        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function onRegister():void
        {
            addContextListener(LoginEvent.LOGIN_SUCCESSFUL, changeStateHandler, LoginEvent);
            addContextListener(StartupEvent.CONFIG_LOADED, changeStateHandler, StartupEvent);
        }

        //----------------------------------------------------------------------
        //
        //  Private methods
        //
        //----------------------------------------------------------------------

        private function changeStateHandler(event:Event):void
        {
            view.changeState(event);
        }
    }
}