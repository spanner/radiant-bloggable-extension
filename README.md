# Bloggable

This is work in progress uploaded for discussion. It's not ready for use yet.

Bloggable is a different approach to blogging with radiant. Instead of treating blog entries as free-form pages, it creates a channel populated with relatively homogeneous entries. Each entry is presumed to be about something, which could be a page, asset, event or anything else in the system that has been marked bloggable-about. You can also refer to external objects that fall into categories we understand: youtube videos, flickr images or external urls. This approach is ideal for creating tumblelogs, and out of the box that's roughly what you'll get.

The blogging interface is a simple two-step: choose an object, add some text. The kind of object you choose determines the template that is used to display it.

If you want flexibility, there are lots of ways to make a traditional blog with radiant. If you want a fast, high-turnover blog that consists largely of noticings, quotes, found pictures and video clips, this might be just the thing.

## Extension

Other extensions can extend the range of bloggable items just by declaring a model class bloggable and providing two templates: one for selection and one for display. See the `event_calendar` for an example.