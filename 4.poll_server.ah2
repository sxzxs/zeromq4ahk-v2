#include <log>
#include <zmq>

logger.is_out_file := true
logger.is_use_editor := false

logger.info("server")

ctx := zmq_ctx_new()
responder := zmq_socket(ctx, ZMQ_REP)
rtn := zmq_bind(responder, "tcp://*:5555")

SetTimer(recv_event, 100)
OnExit(exit_func) => (zmq_close(responder), zmq_ctx_term(ctx))
loop
{
    logger.info("main")
    Sleep(1000)
}
return

recv_event()
{
    poll_rtn := zmq_poll(items := [Map('socket', responder, 'fd', 0, 'events', ZMQ_POLLIN, 'revents', 0)], 0)
    ;logger.info(poll_rtn[1])
    if(poll_rtn[1] & ZMQ_POLLIN)
    {
        str := zmq_recv_string(responder, &recv_str := '')
        logger.info(recv_str)
        zmq_send_string(responder, "我是zmq")
    }
    ;logger.info(A_index)
}