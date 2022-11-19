#include <log>
#include <zmq>



logger.is_out_file := true
logger.is_use_editor := false

logger.info("server")

ctx := zmq_ctx_new()
responder := zmq_socket(ctx, ZMQ_REP)
rtn := zmq_bind(responder, "tcp://*:5555")

str := zmq_recv_string(responder)
logger.info(str)
zmq_send_string(responder, "我是zmq")

zmq_close(responder)
zmq_ctx_term(ctx)