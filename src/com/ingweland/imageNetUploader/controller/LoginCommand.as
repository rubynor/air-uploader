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
    import com.ingweland.imageNetUploader.events.controller.LoginEvent;
    import com.ingweland.imageNetUploader.model.APIRequestsModel;
    import com.ingweland.imageNetUploader.model.UserModel;

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import mx.controls.Alert;

    import org.robotlegs.mvcs.Command;

    public class LoginCommand extends Command
    {
        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var event:LoginEvent;

        [Inject]
        public var apiRequestsModel:APIRequestsModel;

        [Inject]
        public var userModel:UserModel;

        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function execute():void
        {
            var loader:URLLoader = new URLLoader();
            var url:String = apiRequestsModel.requests[APIRequestsModel.ROOT_URL] +
                apiRequestsModel.requests[APIRequestsModel.LOGIN];
            var request:URLRequest = new URLRequest(url);
            request.data = "user[email]=" + event.username + "&user[password]=" + event.password;

            request.method = "POST";
            loader.addEventListener(Event.COMPLETE, login_completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, login_ErrorHandler);
            loader.load(request);

            commandMap.detain(this);
        }

        protected function login_completeHandler(event:Event):void
        {
            var json:String = event.target.data;
            var tempObject:Object = JSON.parse(json);
            if(tempObject.success)
            {
                userModel.authToken = tempObject.auth_token;
                dispatch(new LoginEvent(LoginEvent.LOGIN_SUCCESSFUL));
            }
            else
            {
                dispatch(new LoginEvent(LoginEvent.LOGIN_FAILED));
            }
            commandMap.release(this);
        }

        protected function login_ErrorHandler(event:IOErrorEvent):void
        {
            var o:Object = JSON.parse(event.target.data.toString());
            if(o && o.hasOwnProperty("success") && !o.success)
            {
                dispatch(new LoginEvent(LoginEvent.LOGIN_FAILED));
            }

            commandMap.release(this);
        }
    }
}