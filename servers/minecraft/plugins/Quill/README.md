# Quill
A flexible and expandable system for creating Minecraft books.

## Commands
- `/book update` - Updates the cache.
- `/book updateassets` - Updates the resource pack.
- `/book list [player]` - Command line variant requires a player. Lists all available books.
- `/book read <book> [player]` - Read an available book.
- `/book readother <player> <book> [player]` - Command line variant requires a player. Read a book available to another player.
- `/book give <book> [player]` - Give a book item for an available book.
- `/book giveother <player> <book> [player]` - Command line variant requires a player. Give a book item that's available to another player.
- `/book set <book>` - Set the current held item to be an available book.
- `/book setother <player> <book>` - Set the currently held item to be a book available to another player.
- `/book unset` - Unset the book from the currently held item

## Permissions
- `quill.admin`
- `quill.book.command`
- `quill.book.command.update`
- `quill.book.command.updateassets`
- `quill.book.command.list`
- `quill.book.command.list.other`
- `quill.book.command.read`
- `quill.book.command.read.other`
- `quill.book.command.readother`
- `quill.book.command.readother.other`
- `quill.book.command.openfor`
- `quill.book.command.openfor.other`
- `quill.book.command.give`
- `quill.book.command.give.other`
- `quill.book.command.giveother`
- `quill.book.command.giveother.other`
- `quill.book.command.set`
- `quill.book.command.setother`
- `quill.book.command.unset`

## How to create a book
### Catalogs
Catalogs are archives that store books which can be accessed by the player. Quill's default catalog uses a book, component and stylesheet catalog which splits the separate parts of a book for easier editing and reusability. Catalogs and their data are stored in the plugin directory under `catalogs/<id>/`.

### Books
Book files are stored under `books/` in the catalog directory. They contain the content required to build a book, such as the author, book id, title, and content. A book can be contained within 1 file, but it is advised to split it among multiple components to increase reusability and clarity. Here is an example book file:

```xml
<book id="example_book" title="Example Book" author="BananaPuncher714">
  <content header="header" styles="body">The main text of the book goes here, between the content tags. Whitespace is not trimmed.</content>
  <components>
    <component id="header">A simple header</component>
    <component id="footer"><b>A bolded footer</b></component>
  </components>
  <styles>
    <!-- The styles here represent  -->
    <style id="body">
      <formatting>
        <format type="color">0xFF8080</format>
      </formatting>
    </style>
  </styles>
</book>
```
When loaded, it looks like this:

![Example Book](https://i.imgur.com/tZBAcmJ.png)

The header and footer are automatically placed at the top and bottom, and the content is split into as many pages as needed to display everything.

### Components
Components are files that contain content which is copy and pasted automatically into books. They are stored under `components/` in the catalog directory. To be included in a book, they can be referenced by their path relative to the `components/` directory. Components can also be placed directly in the book file as well.

### Stylesheets
Stylesheets can be used to format the contents of books and be reused. They can affect the formatting, inherit other styles, and contain properties which may be used by certain component transformers when building the book. Stylesheets are stored under `styles/` in the catalog directory.

### Formatting
Quill comes with a few built in formatting features. It also supports [Minedown](https://github.com/Phoenix616/MineDown).

## Supported plugins
- [PlaceholderAPI](https://github.com/PlaceholderAPI/PlaceholderAPI)
- [BondrewdLikesHisEmotes](https://github.com/MineInAbyss/BondrewdLikesHisEmotes)