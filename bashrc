QTDIR=$(grep qtdir $HOME/.kdesrc-buildrc | awk '{ print $2 }' )
KDEDIR=$(grep kdedir $HOME/.kdesrc-buildrc  | awk '{ print $2 }')
KDEDIRS=$KDEDIR
PATH="$KDEDIR/bin:$QTDIR/bin:$PATH"
MANPATH="$QTDIR/doc/man:$MANPATH"

# Act appropriately if LD_LIBRARY_PATH is not already set.
if [ -z $LD_LIBRARY_PATH ]; then
  LD_LIBRARY_PATH=$KDEDIR/lib:$QTDIR/lib
else
  LD_LIBRARY_PATH=$KDEDIR/lib:$QTDIR/lib:$LD_LIBRARY_PATH
fi

export QTDIR KDEDIRS PATH MANPATH LD_LIBRARY_PATH

function run_xvfb ()
{
    sudo Xvfb $DISPLAY +extension RANDR -screen 0 1024x780x24 &
}

function kill_xvfb () 
{ 
    sudo kill -9 $(pgrep Xvfb)
}

function re_xvfb () 
{ 
    kill_xvfb
    run_xvfb 
}

function run_vnc () 
{
    x11vnc -usepw -display $DISPLAY &
}

function kill_vnc () 
{
    sudo kill -9 $(pgrep x11vnc)
}

function re_vnc ()
{
    kill_vnc
    run_vnc
}
