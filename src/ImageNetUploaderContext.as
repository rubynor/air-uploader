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
    import com.ingweland.imageNetUploader.controller.*;
    import com.ingweland.imageNetUploader.events.controller.LoginEvent;
    import com.ingweland.imageNetUploader.events.model.UploadEvent;
    import com.ingweland.imageNetUploader.model.*;
    import com.ingweland.imageNetUploader.view.components.*;
    import com.ingweland.imageNetUploader.view.mediators.components.*;
    import com.ingweland.imageNetUploader.view.mediators.ui.*;
    import com.ingweland.imageNetUploader.view.ui.*;

    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.Context;

    public class ImageNetUploaderContext extends Context
    {
        override public function startup():void
        {
            injector.mapSingleton(APIRequestsModel);
            injector.mapSingleton(UserModel);
            injector.mapSingleton(UploadingQueueModel);

            commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadGlobalConfigCommand, ContextEvent, true);
            commandMap.mapEvent(LoginEvent.LOGIN, LoginCommand, LoginEvent);
            commandMap.mapEvent(UploadEvent.FILES_SELECTED, ProcessSelectedFilesCommand, UploadEvent);
            commandMap.mapEvent(UploadEvent.REMOVE_ITEM, RemoveItemFromQueueCommand, UploadEvent);
            commandMap.mapEvent(UploadEvent.UPLOAD, UploadFilesCommand, UploadEvent);

            mediatorMap.mapView(QueueItem, QueueItemMediator);
            mediatorMap.mapView(ProgressBar, ProgressBarMediator);

            mediatorMap.mapView(LoginScreen, LoginScreenMediator);
            mediatorMap.mapView(UploadScreen, UploadScreenMediator);

            mediatorMap.mapView(ImageNetUploader, ImageNetUploaderMediator);

            dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
        }
    }
}