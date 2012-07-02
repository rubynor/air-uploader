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
    import com.ingweland.imageNetUploader.events.model.StartupEvent;
    import com.ingweland.imageNetUploader.model.APIRequestsModel;

    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    import org.robotlegs.mvcs.Command;

    public class LoadGlobalConfigCommand extends Command
    {
        //----------------------------------------------------------------------
        //
        //  Injections
        //
        //----------------------------------------------------------------------

        [Inject]
        public var apiRequestsModel:APIRequestsModel;

        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------

        override public function execute():void
        {
            var file:File = File.applicationDirectory.resolvePath("data/config.xml");
            var fs:FileStream = new FileStream();
            fs.open(file, FileMode.READ);
            var xml:XML = XML(fs.readUTFBytes(fs.bytesAvailable));
            var tempArray:Array = new Array();
            tempArray["rootUrl"] = xml.rootUrl.toString();
            tempArray["login"] = xml.services.login.toString();
            tempArray["upload"] = xml.services.upload.toString();

            apiRequestsModel.requests = tempArray;

            dispatch(new StartupEvent(StartupEvent.CONFIG_LOADED));
        }
    }
}