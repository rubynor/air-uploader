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
    import com.ingweland.imageNetUploader.events.controller.LoginEvent;
    import com.ingweland.imageNetUploader.view.ui.LoginScreen;

    import org.robotlegs.mvcs.Mediator;

    public class LoginScreenMediator extends Mediator
    {
        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var view:LoginScreen;


        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function onRegister():void
        {
            addContextListener(LoginEvent.LOGIN_FAILED, loginFailedHandler, LoginEvent);

            addViewListener(LoginEvent.LOGIN, loginHandler, LoginEvent);
        }

        //----------------------------------------------------------------------
        //
        //  Private methods
        //
        //----------------------------------------------------------------------

        private function loginHandler(event:LoginEvent):void
        {
            dispatch(event);
        }

        private function loginFailedHandler(event:LoginEvent):void
        {
            view.processFailedLogin();
        }

    }
}