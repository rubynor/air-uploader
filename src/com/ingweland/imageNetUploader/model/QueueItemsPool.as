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
    import com.ingweland.imageNetUploader.view.components.QueueItem;

    public class QueueItemsPool
    {
        private static var _pool:Vector.<QueueItem> = new Vector.<QueueItem>();

        public static function getItem():QueueItem
        {
            if(_pool.length > 0)
            {
                return _pool.shift();
            }

            return new QueueItem();
        }

        public static function returnItem(item:QueueItem):void
        {
            _pool.push(item);
        }
    }
}