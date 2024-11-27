xcompose-vim
============

:Description: XCompose digraphs as defined by Vim/Nvim
:License: Apache 2.0


Install
-------

Install e.g., like this::

    ~/.XCompose
    ~/.XCompose-en
    ~/.XCompose-vim

See ``Compose(5)`` for more details.


Caveat
------

System provided Compose file – included with `#include "%L"`
(`/usr/share/X11/locale/<localename>/Compose`) – might include tri+graphs that
effectively hide digraphs beginning with same keys. This seems to be
a limitation of Compose and/or XIM itself. Moreover it's not possible to unset
sequences once they were set. Hence `.XCompose-en`.
