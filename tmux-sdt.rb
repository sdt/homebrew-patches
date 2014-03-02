require 'formula'

class TmuxSdt < Formula
  homepage 'http://tmux.sourceforge.net'
  url 'git://git.code.sf.net/p/tmux/tmux-code', :tag => '1.9a'

  depends_on 'pkg-config' => :build
  depends_on 'libevent'

  def install
    system "sh", "autogen.sh"

    ENV.append "LDFLAGS", '-lresolv'
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make install"

    bash_completion.install "examples/bash_completion_tmux.sh" => 'tmux'
    (share/'tmux').install "examples"
  end

  def caveats; <<-EOS.undent
    Example configurations have been installed to:
      #{share}/tmux/examples
    EOS
  end

  def patches; DATA; end

  test do
    system "#{bin}/tmux", "-V"
  end
end

__END__
diff --git a/style.c b/style.c
index 9974408..257d146 100644
--- a/style.c
+++ b/style.c
@@ -234,5 +234,5 @@ style_apply_update(struct grid_cell *gc, struct options *oo, const char *name)
 			colour_set_bg(gc, gcp->bg);
 	}
 	if (gcp->attr != 0)
-		gc->attr |= gcp->attr;
+		gc->attr = gcp->attr;
 }
