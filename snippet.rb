class Snippet
  def self.menu *args

    extension = View.extension
    file = "#{Xiki.dir}etc/snippets/#{extension}.notes"

    prefix = Keys.prefix

    return View.open file if prefix == :u   # If up+, just go to file

    # If leaf has quote, kill the rest or create new snippet

    if args[-1] =~ /\|/

      txt = ENV['txt'].dup

      txt << "\n" if txt !~ /\n/

      Tree.to_parent :u
      Tree.kill_under
      Line.delete

      View.<< txt, :dont_move=>1

      return
    end

    # Get snippets.foo file from snippets/ dirs, and drill into it

    # TODO: also look in ~/xiki/snippets

    if ! File.exists? file
      # TODO: if none found, show
      return "
        | No snippets were found for the file extension '#{extension}'.
        | You can create some by making a tree in this file:
        @ #{file}
        "
      # TODO: maybe let them type directly into the @snippet menu and do C-. to save
    end


    txt = File.read file
    Tree.children txt, args


    # TODO: if line has quote and path doesn't exist in file (.drill fails), create new snippet

  end

  def self.insert
    "do something with me"
  end
end