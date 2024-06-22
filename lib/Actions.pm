use 5.40.0;
use experimental 'class';

class MoveAction {
    field $dx : param = 0;
    field $dy : param = 0;

    method execute($target) {
        $target->move( $dx, $dy );
    }
}
