QTDIR=$(grep qtdir $HOME/.kdesrc-buildrc | awk '{ print $3 }' )
KDEDIR=$(grep kdedir $HOME/.kdesrc-buildrc  | awk '{ print $3 }')
KDEDIRS=$KDEDIR
PATH=$KDEDIR/bin:$QTDIR/bin:$PATH
MANPATH=$QTDIR/doc/man:$MANPATH

# Act appropriately if LD_LIBRARY_PATH is not already set.
if [ -z $LD_LIBRARY_PATH ]; then
  LD_LIBRARY_PATH=$KDEDIR/lib:$QTDIR/lib
else
  LD_LIBRARY_PATH=$KDEDIR/lib:$QTDIR/lib:$LD_LIBRARY_PATH
fi

export QTDIR KDEDIRS PATH MANPATH LD_LIBRARY_PATH
